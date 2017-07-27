import re
import numpy as np


def grabPartMAFSeq(MAFSeq,x_coords):
    coordtransform = np.array(range(len(MAFSeq)))
    coordtransform = np.delete(coordtransform,[val.start(0) for val in re.finditer('-',MAFSeq)])
    return MAFSeq[coordtransform[x_coords[0]]:coordtransform[x_coords[1]]]

MAFSeq = '-ATC--GCTA--'
x_coords = (1,4)
print grabPartMAFSeq(MAFSeq,x_coords)