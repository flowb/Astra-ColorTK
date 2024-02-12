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
import math
import numpy as np
cf = mod('/core/python/colorfunc')


class DYRGBEXT:
	"""
	DYRGBEXT description
	"""
	def __init__(self, ownerComp):
		# The component to which this extension is attached
		self.ownerComp = ownerComp

		# properties
		TDF.createProperty(self, 'Color', value=cf.YRGB(), dependable=True, readOnly=False)
		TDF.createProperty(self, 'UIRGB', value=tdu.Dependency([1.0,1.0,1.0]), dependable=True, readOnly=False)
		TDF.createProperty(self, 'Value', value=tdu.Dependency(1.0), dependable=True, readOnly=False)

		self.Precision = \
			{
				"HS":0.4,
				"Y":0.1
			}
		
		self.Default = \
			{
				"HS":[0.0,0.0],
				"Y":1.0,
				"Value":1.0
			}
		
		#rotate the hueSat dial to look like Davinci
	
		self.HueOffset = tdu.Dependency(math.pi*0.3333)
		self.DialSatScale = tdu.Dependency(2.0)

		iop.HS_Dial.panel.u.val = iop.HS_Dial.panel.v.val = 0.0
		# stored items (persistent across saves and re-initialization):
		# storedItems = [
		# 	# Only 'name' is required...
		# 	{'name': 'StoredProperty', 'default': None, 'readOnly': False, 'property': True, 'dependable': True},
		# ]
		# Uncomment the line below to store StoredProperty. To clear stored
		# 	items, use the Storage section of the Component Editor
		
		# self.stored = StorageManager(self, ownerComp, storedItems)

	def UpdValue(self):
		self.Value.val = max(self.UIRGB.val)

	def HSUpdate(self):
		#convert the current cartesian position of the HS picker to polar coords
		angle, mag = cf.xy2rad(iop.HS_Dial.panel.u.val, iop.HS_Dial.panel.v.val)
		angle += self.HueOffset.val #add the hue dial rotation
		hue = 0.5+(angle/math.pi)*0.5 #normalize the radians
		#sat = min(mag/(2.0*self.DialSatScale.val),1.0) #normalize and clamp the magnitude into sat
		sat = mag/(2.0*self.DialSatScale.val)
		self.UIRGB.val = list( np.round( cf.hsv2rgb(hue,sat,self.Value),2) )
		self.Color.setHS(hue, sat) #apply the values to the color
		return
	

	def SetHueOffset(self, newVal):
		self.HueOffset.val = newVal
		self.HSUpdate()
		return
	
	def UpdatePos(self):
		#debug(self.UIRGB)
		#r,g,b = self.Color.rgb.val
		r,g,b = self.UIRGB.val
		h,s,v = cf.rgb2hsv(r,g,b)
		#debug(v)
		mag = s*self.DialSatScale.val
		rad = (h-0.5)*2*math.pi
		rad -= self.HueOffset.val
		#debug(rad,mag)
		iop.HS_Dial.panel.u.val, iop.HS_Dial.panel.v.val = cf.rad2xy(rad, mag)
		#debug(self.UIRGB)
		iop.HS_Dial.op('pickPoint/color').cook(force=True) #this is a hack to get around what looks like a bug in dependency evaluation
		return

	def SetYRGB(self, yrgb: list()):
		Y,R,G,B = yrgb
		self.Color.SetYRGB(Y,R,G,B)
		self.UIRGB.val = [R,G,B]
		self.UpdValue()
		self.UpdatePos()
		iop.Y_Dial.panel.u.val = (self.Color.Y.val - self.Default['Y']) / self.Precision['Y']
		return
	