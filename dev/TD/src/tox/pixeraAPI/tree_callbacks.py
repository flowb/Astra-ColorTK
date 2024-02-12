#Shared Use License: This file is owned by Derivative Inc. (â€œDerivativeï¿½) 
#and can only be used, and/or modified for use, in conjunction with 
#Derivativeâ€™s TouchDesigner software, and only if you are a licensee who 
#has accepted Derivativeâ€™s TouchDesigner license or assignment agreement 
#(which also governs the use of this file).  You may share a modified version 
#of this file with another authorized licensee of Derivativeâ€™s TouchDesigner 
#software.  Otherwise, no redistribution or sharing of this file, with or 
#without modification, is permitted.

"""
All callbacks for this treeLister go here. For available callbacks, see:

https://docs.derivative.ca/Palette:treeLister#Custom_Callbacks

treeLister also has all lister callbacks:
https://docs.derivative.ca/Palette:lister#Custom_Callbacks
"""

# def onInit(info):
# 	info['listerExt'].DefaultRoots = ['/None']

# def getObjectFromID(info):
# 	return {'name': 'TreeObject'}

# def getIDFromObject(info):
# 	return '/None'

# def getObjectChildren(info):
# 	return []

def onClick(c):
    if c.get('rowData',None) == None: return
    
    layer = c['rowData']['rowObject']
    #debug(layer)
    if not layer['handle'] == '':
        fx = {
            'id':layer['id'],
            'path':layer['path'],
            'handle':layer['handle'],
            'fxtype':layer['fxtype']
        }
        op.pixera.LoadEffect(fx)
    return



# def onConvertData(info):
#     pass
#     # for i in info['data']:
        
#     #     if i[3]['fx'] == 'True':
#     #         debug(dir(i))
#     #         #debug(i)

# def onRefresh(info):
    
#     return

def onSetCellText(info):
    if info:
        #debug(info)

        nfo = info.get('rowData',{}).get('rowObject',{})
        if nfo:
            fxtype = nfo.get('fxtype', '')
            if not fxtype == '':
                #debug(fxtype) 
                info['ownerComp'].SetCellLookName(info['row'],info['col'],fxtype)
                info['ownerComp'].InitRow(info['row']) 

      