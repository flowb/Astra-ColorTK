"""
Extension classes enhance TouchDesigner components with python. An
extension is accessed via ext.ExtensionClassName from any operator
within the extended component. If the extension is promoted via its
Promote Extension parameter, all its attributes with capitalized names
can be accessed externally, e.g. op('yourComp').PromotedFunction().

Help: search "Extensions" in wiki
"""

fxOps = {
	'LiftG':op('/FXCTL_LGG'),
	'Curve':op('/GenericCurve')
}

from TDStoreTools import StorageManager
import TDFunctions as TDF

import json

from enum import Enum
class RequestType(Enum):
	TX = 1
	TIMELINES = 2
	TIMELINEATTR = 3

class ReqExec:
	def __init__(self, ids, script):
		#debug('new async request: ', ids, script)
		self.Ids = ids
		self.Script = script
 
	def checkin(self, id):
		#debug('checking in: ', id)
		self.Ids = [i for i in self.Ids if i != id]
		if len(self.Ids) == 0:
			#debug('all checked in. running ', self.Script)
			eval(self.Script)
			#debug('done. deleting myself...')
			op.pixera.Requests.remove(self)
		
class PixeraEXT:
	"""
	PixeraEXT description
	"""
	def __init__(self, ownerComp):
		# The component to which this extension is attached
		self.ownerComp = ownerComp

		# properties
		TDF.createProperty(self, 'Timelines', value={}, dependable=True, readOnly=False)
		TDF.createProperty(self, 'Layers', value={}, dependable=True, readOnly=False)

		# attributes:
		self.a = 0 # attribute
		self.B = 1 # promoted attribute
		self.Tracked = ['s2','Curve']
		self.Requests = []
		self.TreeData = tdu.Dependency([])
		self.CuedFx = {}
		self.TreeDat = self.ownerComp.op('treeDAT')

		# stored items (persistent across saves and re-initialization):
		storedItems = [
			# Only 'name' is required...
			{'name': 'StoredProperty', 'default': None, 'readOnly': False,
			 						'property': True, 'dependable': True},
		]
		# Uncomment the line below to store StoredProperty. To clear stored
		# 	items, use the Storage section of the Component Editor
		
		# self.stored = StorageManager(self, ownerComp, storedItems)
		run("op.pixera.TreeUpd()", delayFrames=1)

	def ResponseProc(self, recvd):
		#debug(recvd[:4])

		msgs = self.Rx(recvd)
		for msg in msgs:
			#msg = json.loads(m[4:])
			
			
			context = msg.get('context',None)

			if context:
				#debug(context['method'])

				if context['method'] == 'Pixera.Timelines.getTimelines':
					#self.Timelines.clear()
					for handle in msg['result']:
						if self.Timelines.get(handle,'none') == 'none':
							self.Timelines[handle] = {}
						self.Tx("Pixera.Timelines.Timeline.getAttributes",{'handle':handle}, 1)
				
				if context['method'] == 'Pixera.Timelines.Timeline.getAttributes':
					#debug(msg)
					#self.Timelines[context['handle']]['name'] = msg['result']['name']
					for attrib in msg['result']:
						self.Timelines[context['handle']][attrib] = msg['result'][attrib]
						#debug(context['handle'], attrib)
					self.Tx("Pixera.Timelines.Timeline.getLayers",{"handle":context['handle']},1)

				if context['method'] == 'Pixera.Timelines.Timeline.getLayers':
					#self.Layers.clear()
					if not self.Timelines[context['handle']].get('layers',None):
							self.Timelines[context['handle']]['layers'] = []
					for handle in msg['result']:
						if handle not in self.Layers:
							#debug(msg)
							self.Layers[handle] = {'timeline':context['handle'], 'fx':[], 'knownFx':[], 'handle':handle}
							self.Timelines[context['handle']]['layers'].append(handle)
							self.Tx("Pixera.Timelines.Layer.getName",{"handle":handle},1)
							self.Tx("Pixera.Timelines.Layer.getFxNames",{"handle":handle},1)
							self.Tx("Pixera.Timelines.Layer.getLayerJsonDescrip",{"handle":handle},1)
						
				if context['method'] == 'Pixera.Timelines.Layer.getLayerJsonDescrip':
					
					# for effect in [e for e in msg['result'] if e in ['LiftGammaGain']]:
					# 	self.Layers[context['handle']][effect] = json.loads(msg['result'])[effect]
					
					#self.Layers[context['handle']] = json.loads(msg['result'])['LiftGammaGain']
					layerAttr = json.loads(msg['result'])
					#debug(layerAttr)
					for a in layerAttr:
						if a in self.Layers[context['handle']]['fx']:
							for p in layerAttr[a]:
								#debug(p)
								if p[:4] == 'mix_':
									fxType = p[4:]
									#debug(fxType)
									self.Layers[context['handle']]['knownFx'].append((a,fxType))
									

						#debug('>'+a+'<', '>' + self.Tracked[0] + '<',  a in self.Tracked)
						#if a[:2] in self.Tracked:
							#debug('!!!')
						self.Layers[context['handle']][a] = layerAttr[a]

				
				if context['method'] == 'Pixera.Timelines.Layer.getName':
					#debug(msg)
					self.Layers[context['handle']]['name'] = msg['result']
					timelineName = self.Timelines[self.Layers[context['handle']]['timeline']]['name']
					self.Layers[context['handle']]['path'] = timelineName + '.' + msg['result']
					
				if context['method'] == 'Pixera.Timelines.Layer.getFxNames':
					self.Layers[context['handle']]['fx'] = msg['result']
					#debug(msg['result'])
					
			if msg['id'] > 1:
				for r in self.Requests:
					r.checkin(msg['id'])
				

		return
	
	# this one unpacks pixera messages into dicts
	def Rx(self, recvd):
		messages = []

		while len(recvd) > 0:

			#check for header
			if recvd[:4] == b'pxr1':

				#trim header extract payload length
				recvd=recvd[4:]
				msgLen = int.from_bytes(recvd[:4],'little')
				recvd=recvd[4:]

				if msgLen <= len(recvd):
					messages.append( json.loads(recvd[:msgLen]) )
					recvd = recvd[msgLen:]
				
		return messages


	def Tx(self, method, params, reqId):
		header = "pxr1"
		
		payload = { "jsonrpc":"2.0", "id":reqId }
		payload['method'] = str(method)
		payload['params'] = dict(params)

		msgLen = len( json.dumps(payload) ).to_bytes(4,'little')

		op('tcpip1').sendBytes(header,msgLen,json.dumps(payload))

		# if reqId > 1:
		# 	self.Requests[reqId] = payload
		# 	debug('added: ',reqId)
	

	def GetTimelines(self):
		self.Timelines.clear()
		self.Layers.clear()
		self.Tx("Pixera.Timelines.getTimelines",{},1)

	def LoadLayer(self, handle):
		self.Tx("Pixera.Timelines.Layer.getName",{"handle":handle},11)
		self.Tx("Pixera.Timelines.Layer.getFxNames",{"handle":handle},12)
		self.Tx("Pixera.Timelines.Layer.getLayerJsonDescrip",{"handle":handle},13)
		script = "op.primaryWheels.LoadParsFromLayer("+str(handle)+")"
		self.Requests.append(ReqExec([11,12,13],script))

	def LoadEffect(self, fxInfo: dict):
		handle = int(fxInfo['handle'])
		
		self.Tx("Pixera.Timelines.Layer.getName",{"handle":handle},11)
		self.Tx("Pixera.Timelines.Layer.getFxNames",{"handle":handle},12)
		self.Tx("Pixera.Timelines.Layer.getLayerJsonDescrip",{"handle":handle},13)
		#script = "op.primaryWheels.LoadParsFromLayer("+str(handle)+")"
		self.CuedFx = fxInfo
		script = "op.pixera.BuildFxControl()"

		self.Requests.append(ReqExec([11,12,13],script))
	

	def TreeUpd(self):

		t = self.TreeDat
		t.clear()
		#op.pixera.Layers.clear()
		
		#t.val.clear()
		t.appendRow(['id','path','handle','fxtype'])
		#rows = []
		for l in op.pixera.Layers:
			layer = op.pixera.Layers[l]
			if layer.get('name',None) == None: return
			t.appendRow([layer['name'],layer['path'],''])
			for f in layer['fx']:
				r = [f, layer['path']+'.'+f,layer['handle']]
				for name, fxtype in layer['knownFx']:
					if name == f:
						r.append(fxtype)
				t.appendRow(r)
			
		for l in op.pixera.Timelines:
			tl = op.pixera.Timelines[l]['name']
			t.appendRow([tl,tl,''])

		
	
	def ApplyColourSpace(self):
		t = self.TreeDat
		cs = op('/colorspace_settings')
		space = cs.ColourSpace[cs.Current.val.eval()]

		for fx in t.col(0):
			if fx.val[:5] in fxOps:
				# if fx.val[:5] == 's2HvS':
				# 	path = t[fx.row,'path'].val + '.YCOE '
				# 	for c in range(3):
				# 		val = space['YCOE'][c]
				# 		op.pixera.Tx("Pixera.Compound.setParamValue",{"path":path+['R','G','B'][c],"value":val},1)
						
				#elif fx.val[:5] == 'LiftGammaGain':
				mtx = space['matrix']['RGBtoXYZ']
				for c in range(3):
					path = t[fx.row,'path'].val + '.RX' + str(c+1) + ' '
					for r in range(3):
						op.pixera.Tx("Pixera.Compound.setParamValue",{"path":path+str(r),"value":mtx[r][c]},1)

				op.pixera.Tx("Pixera.Compound.setParamValue",{"path":t[fx.row,'path'].val + '.WhiteK',"value":space['whiteK']},1)
				op.pixera.Tx("Pixera.Compound.setParamValue",{"path":t[fx.row,'path'].val + '.White X',"value":space['whitepoint'][0]},1)
				op.pixera.Tx("Pixera.Compound.setParamValue",{"path":t[fx.row,'path'].val + '.White Y',"value":space['whitepoint'][1]},1)
				op.pixera.Tx("Pixera.Compound.setParamValue",{"path":t[fx.row,'path'].val + '.Green X',"value":space['primaries'][1][0]},1)
				op.pixera.Tx("Pixera.Compound.setParamValue",{"path":t[fx.row,'path'].val + '.Green Y',"value":space['primaries'][1][1]},1)
		return
			

	def BuildFxControl(self):
		for o in fxOps:
			fxOps[o].par.display = False
		fxType = self.CuedFx['fxtype'][:5]
		if fxType in fxOps:
			fxOps[fxType].LoadPars(self.CuedFx)
		#debug(fxType)
		return