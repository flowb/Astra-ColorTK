import colour as col
import json

colorspaces = {}

for c in col.RGB_COLOURSPACES:
    space = col.RGB_COLOURSPACES[c]
    colorspaces[space.name] = {}
    N = colorspaces[space.name]
    N['YCOE'] = list(space.matrix_RGB_to_XYZ[1:2][0])
    
    N['matrix'] = {}

    N['matrix']['RGBtoXYZ'] = []
    for r in range(3):
        N['matrix']['RGBtoXYZ'].append(list( space.matrix_RGB_to_XYZ[r] ))

    N['matrix']['XYZtoRGB'] = []
    for r in range(3):
        N['matrix']['XYZtoRGB'].append(list( space.matrix_XYZ_to_RGB[r] ))

    N['primaries'] = []
    for r in range(3):
        N['primaries'].append(list(space.primaries[r]))

    N['whitepoint'] = list(space.whitepoint)

    N['whiteK'] = col.xy_to_CCT(space.whitepoint)


with open("dev/colour/colour-data.json","w") as json_file:
    json.dump(colorspaces, json_file,indent="\t")


