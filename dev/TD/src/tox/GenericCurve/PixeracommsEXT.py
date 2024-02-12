"""
Extension classes enhance TouchDesigner components with python. An
extension is accessed via ext.ExtensionClassName from any operator
within the extended component. If the extension is promoted via its
Promote Extension parameter, all its attributes with capitalized names
can be accessed externally, e.g. op('yourComp').PromotedFunction().

Help: search "Extensions" in wiki
"""

#from TDStoreTools import StorageManager
import TDFunctions as TDF

class PixeracommsEXT:
	"""
	PixeracommsEXT description
	"""
	def __init__(self, ownerComp):
		# The component to which this extension is attached
		self.ownerComp = ownerComp

		# properties
		# TDF.createProperty(self, 'MyProperty', value=0, dependable=True,
		# 				   readOnly=False)

		# attributes:
		self.a = 0 # attribute
		self.B = 1 # promoted attribute
		self.FxPanel = ownerComp.op('fxPanel')
		self.HvY = ownerComp.op('CurvesGraph')
		self.Path = None
		self.Mix = ownerComp.op('Mix')
		self.Mixpath = tdu.Dependency('')
		self.Label = tdu.Dependency(('Null','Null'))
		self.Loading = tdu.Dependency(True)


		# stored items (persistent across saves and re-initialization):
		# storedItems = [
		# 	# Only 'name' is required...
		# 	{'name': 'StoredProperty', 'default': None, 'readOnly': False,
		# 	 						'property': True, 'dependable': True},
		# ]
		# Uncomment the line below to store StoredProperty. To clear stored
		# 	items, use the Storage section of the Component Editor
		
		# self.stored = StorageManager(self, ownerComp, storedItems)

	def LoadPars(self, treeDict):
		op('CurvesGraph').Selected.val = None
		self.Loading.val = True
		self.Path = None
		self.ownerComp.par.display = False
		#debug('boo')
		layer = op.pixera.Layers[int(treeDict['handle'])]
		#debug(layer)
		#debug(treeDict['id'])
		HvYPars = layer.get(treeDict['id'],None)
		#debug(HvYPars)
		#debug(HvYPars['Precision Mode'])
		
		if HvYPars:
			self.Mixpath = 'mix_' + treeDict['fxtype']
			f,t = treeDict['fxtype'].split('Curve')[1].split('Vs')
			self.Label.val = (f,t)

			self.HvY.par.Huelum = (not f == 'Hue')
			self.HvY.Reset()


			self.Mix.par.Value0 = HvYPars[self.Mixpath]

			op('masterRadioButton').par.Value0 = int(HvYPars['Precision Mode'])
			self.HvY.SetMode(int(HvYPars['Precision Mode']))
			
			# set points
			for p in self.HvY.findChildren(name="p*",depth=1,type=COMP):
				p.par.x = HvYPars[p.name+' X'] * self.HvY.width
				p.par.y = HvYPars[p.name+' Y'] * self.HvY.height
			
			
			self.Path = treeDict['path']
			self.ownerComp.par.display = True
		

		strOp = 'op("'+self.ownerComp.path+'")'
		run(strOp+'.Loading.val = False', delayFrames=2)
	

	