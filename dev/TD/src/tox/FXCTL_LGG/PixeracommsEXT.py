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
		self.Path = None
		self.Dialcluster = ownerComp.op('lggDials')
		self.Lift = ownerComp.op('Lift')
		self.Gamma = ownerComp.op('Gamma')
		self.Gain = ownerComp.op('Gain')
		self.Offset = ownerComp.op('Offset')
		self.Mix = ownerComp.op('top').par.Mix
		self.LumMix = ownerComp.op('top').par.Lummix
		self.Temp = ownerComp.op('top').par.Temp
		self.Tint = ownerComp.op('top').par.Tint
		self.Contrast = ownerComp.op('top').par.Contrast
		self.Saturation = ownerComp.op('top').par.Saturation

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
		self.Loading.val = True
		self.Path = None
		self.ownerComp.par.display = False
		
		layer = op.pixera.Layers[int(treeDict['handle'])]
		lggPars = layer.get(treeDict['id'],None)
		#debug(lggPars)
		if lggPars:
			try:
				self.Lift.SetYRGB( [ lggPars['lift Y'], lggPars['lift R'], lggPars['lift G'], lggPars['lift B'] ] )
				self.Gamma.SetYRGB( [ lggPars['gamma Y'], lggPars['gamma R'], lggPars['gamma G'], lggPars['gamma B'] ] )
				self.Gain.SetYRGB( [ lggPars['gain Y'], lggPars['gain R'], lggPars['gain G'], lggPars['gain B'] ] )
				self.Offset.SetRGB( [ lggPars['offset R'], lggPars['offset G'], lggPars['offset B'] ] )

				self.Mix.val = lggPars['mix_LiftGammaGain']
				self.LumMix.val = lggPars['Lum Mix']
				self.Temp.val = lggPars['Temp']
				self.Tint.val = lggPars['Tint']
				self.Contrast.val = lggPars['Contrast']
				self.Saturation.val = lggPars['Saturation']
				self.Path = treeDict['path']
				self.ownerComp.par.display = True
			except:
				debug('died')
				pass	
		
		strOp = 'op("'+self.ownerComp.path+'")'
		run(strOp+'.Loading.val = False', delayFrames=2)
	