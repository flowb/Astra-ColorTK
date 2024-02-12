import numpy as np
import math

# ε = 'epsilon' a really tiny number that 'solves' divide by zero errors
ε = 1.0e-10

def rad2xy(radians: float, mag: float) -> tuple[float,float]:
	x = mag*math.cos(radians)
	y = mag*math.sin(radians)
	return x, y 


def xy2rad(x: float, y: float) -> tuple[float,float]:
	angle = math.atan2(y,x+ε)
	mag = np.hypot(x,y) *2.0
	return angle, mag


def hsv2rgb( hue: float, saturation: float, value: float ) -> tuple[float, float, float]:
	K = np.asarray([1.0, 2.0/3.0, 1.0/3.0, 3.0])
	fract = np.fmod( np.full( 3, hue) + [K[0],K[1],K[2]], 1.0 )
	p = np.absolute( ( fract * 6.0 ) - np.full( 3, K[3] ) )

	rgb = np.clip( p - np.full( 3, K[0] ), 0.0, 1.0 )
	mixSat = ( ( 1.0 - saturation ) * np.full( 3, K[0] ) ) + ( saturation * rgb )
	red, green, blue = tuple(mixSat * value)
	return red, green, blue
	

def rgb2hsv( red: float, green: float, blue: float ) -> tuple[float,float,float]:
	K = np.asarray( [0.0, -1.0/3.0, 2.0/3.0, -1.0] )

	p = np.asarray( [blue, green, K[3], K[2]] ) if green < blue \
		else np.asarray( [green, blue, K[0], K[1]] )
	q = np.asarray( [p[0], p[1], p[3], red] ) if red < p[0] \
		else np.asarray( [red, p[1], p[2], p[0]] )

	d = q[0] - min( q[3], q[1] )

	h = abs( q[2] + ( q[3]-q[1] ) / ( 6.0 * d + ε ) )
	s = d / ( q[0] + ε )
	v = q[0]
	return h,s,v


class YRGB:
	def __init__(self):
		self.Y = tdu.Dependency(1.0)
		self.H = 0.0
		self.S = 0.0
		self.rgb = tdu.Dependency([1.0,1.0,1.0])
		self.ycoe = [ 0.2156, 0.7122, 0.0722 ]
		return
	

	def chanRel(self, chnIdx, delta):
		adj = (delta)/2
		for c in range(3):
			if c == chnIdx:
				self.rgb[c].val += delta
			else:
				self.rgb[c].val -= (adj*self.ycoe[chnIdx]/self.ycoe[c])
		return
	
	def chanSet(self, chnIdx, newVal):
		adj = (self.rgb[chnIdx]-newVal)/2
		for c in range(3):
			if c == chnIdx:
				self.rgb[c] = newVal
			else:
				self.rgb[c] += (adj*self.ycoe[chnIdx]/self.ycoe[c])
			
			self.rgb[c] = round(self.rgb[c],2)
		return

	def setHS(self, hue, sat):
		self.H = hue
		self.S = sat
		#self.rgb.val = np.round(list(hsv2rgb(hue,sat,1.0)),2)
		self.rgb.val = list( np.round( hsv2rgb(hue,sat,1.0),2 ) )
		self.applyY()
		return

	def setY(self, Y):
		self.Y.val = round(Y,2)
		self.applyY()
		pass

	def luma(self) -> float:
		return np.dot(self.rgb.val,self.ycoe)

	def applyY(self):
		scaleY = self.Y.val / ( ε+self.luma() )
		#self.rgb.val = np.round(list(np.multiply( self.rgb.val, scaleY )),2)
		self.rgb.val = list( np.round( np.multiply( self.rgb.val, scaleY ),2 ) )
		return
	
	def SetYRGB(self, Y: float, R: float, G: float, B: float):
		self.rgb.val = [R,G,B]
		self.Y.val = Y
		self.applyY()
		return
	