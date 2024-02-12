"""
Extension classes enhance TouchDesigner components with python. An
extension is accessed via ext.ExtensionClassName from any operator
within the extended component. If the extension is promoted via its
Promote Extension parameter, all its attributes with capitalized names
can be accessed externally, e.g. op('yourComp').PromotedFunction().

Help: search "Extensions" in wiki
"""

from TDStoreTools import StorageManager
import TDFunctions as TDF
import math
import numpy as np

class CurvesGraphEXT:
	"""
	CurvesGraphEXT description
	"""
	def __init__(self, ownerComp):
		# The component to which this extension is attached
		self.ownerComp = ownerComp

		# properties
		# TDF.createProperty(self, 'MyProperty', value=0, dependable=True, readOnly=False)

		# attributes:
		self.Mode = tdu.Dependency(0)
		self.carve = [ 6, 12, 18]
		self.Huelum = ownerComp.par.Huelum
		self.Selected = tdu.Dependency(None)

	# making your own Vec2 class to calculate PwCosines may seem fancy
	# but honestly I just didn't feel like adapting the GLSL code to
	# Python. It was easier to just create GLSL style structs and use
	# numPy. 
	class Vec2:
		def __init__(self, x: float, y: float):
			self.x = x
			self.y = y
	
	
	def PwCos( self, xPos: float, pA: Vec2, pB: Vec2) -> float:
		return (np.cos((xPos-pA.x)/(pB.x-pA.x)*np.pi)-1.0)*0.5*(pA.y-pB.y)+pA.y

	def GraphEval(self, x: float, segments: list) -> float:
		for i in range(len(segments)):
			segment_start, segment_end, handles = segments[i]
			if segment_start <= x <= segment_end:
				return self.PwCos(x, handles[0], handles[1])
		return 0.0  # ¯\_(ツ)_/¯

	def Reset(self):
		CurvesGraph = self.ownerComp
		slice = self.carve[self.Mode]

		for i in range(1,19):
			shift = math.floor(( (i-1)/slice )%slice) + 1
			xpos = (i-1)/slice*(CurvesGraph.width*shift)
			
			op('p'+str(i)).par.x = xpos
			op('p'+str(i)).par.y = CurvesGraph.height

		for i in range(1,19):
			shift = math.floor(( (i-1)/slice )%slice) + 1
			xpos = (i-1)/slice*(CurvesGraph.width*shift)
			
			op('p'+str(i)).par.x = xpos
			op('p'+str(i)).par.y = CurvesGraph.height/2
	
		op('p19').par.x = CurvesGraph.width
		op('p19').par.y = CurvesGraph.height/2
		return

	def SetMode(self, modeInt):
		self.Mode.val = modeInt
		self.Reset()
		return

	def VecTest(self, x: float, y: float) -> Vec2:
		myVec =  CurvesGraphEXT.Vec2(x,y)
		return myVec
	
	def SwitchMode(self, newMode: int) -> None:
		#debug('---Mode Switch---')
		CurvesGraph = self.ownerComp
		slice = self.carve[self.Mode]

		prevVecs = []
		#serialize current points to some vecs
		for i in range(1,slice+1):
			p = op('p'+str(i))
			prevVecs.append(CurvesGraphEXT.Vec2(\
				p.par.x/CurvesGraph.width,\
				p.par.y/CurvesGraph.height))
		
		# generate wrapping vectors
		prevVecs.insert( 0, CurvesGraphEXT.Vec2(prevVecs[slice-1].x-1.0,prevVecs[slice-1].y) )
		prevVecs.append( CurvesGraphEXT.Vec2(prevVecs[1].x+1.0,prevVecs[1].y) ) #select second vector since we just demoted it

		# print('\n\n\nold points\n')
		# for v in prevVecs:
		# 	print(v.x,v.y)
		
		segments = []
		for v in range(len(prevVecs)-1):
			segments.append(\
				( prevVecs[v].x, prevVecs[v+1].x, (prevVecs[v],prevVecs[v+1])) )
			
		#debug(len(segments))
		
		slice = self.carve[newMode]
		newVecs = []
		for n in range(1,19):
			shift = math.floor(( (n-1)/slice )%slice) + 1
			xpos = (n-1)/slice*(shift)
			newVecs.append(CurvesGraphEXT.Vec2( xpos, 0.5))
		
		for v in newVecs:
			if 0.0 <= v.x <= 1.0:
				v.y = self.GraphEval(v.x, segments)

		# print('\nnew points\n')
		# for v in newVecs:
		# 	print(v.x,v.y)

		slice = self.carve[self.Mode]
		self.Mode.val = newMode
		#self.Reset()
		for p in range(1,len(newVecs)+1):
			
			op('p'+str(p)).par.x = newVecs[p-1].x * CurvesGraph.width
			op('p'+str(p)).par.y = newVecs[p-1].y * CurvesGraph.height
