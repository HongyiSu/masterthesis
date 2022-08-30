import numpy as np
import argparse
import seissolxdmf
from scipy import spatial

# parsing python arguments
parser = argparse.ArgumentParser(
    description="find closest fault triangle center from receiver"
)
parser.add_argument("--fault", nargs=1, help="fault hdf5 filename")
parser.add_argument("--receivers", nargs=1, help="fault receveiver filename (ascii)")
args = parser.parse_args()

sx = seissolxdmf.seissolxdmf(args.fault[0])
faultxyz = sx.ReadGeometry()
connect = sx.ReadConnect()

centers = (
    faultxyz[connect[:, 0]] + faultxyz[connect[:, 1]] + faultxyz[connect[:, 2]]
) / 3.0

FidReceivers = args.receivers[0]
FidReceiversnew = args.receivers[0] + "2"
Receivers = np.loadtxt(FidReceivers, ndmin=2)
tree = spatial.KDTree(centers)
dist, ids = tree.query(Receivers)

FidReceiversnew = FidReceivers + "2"
fout = open(FidReceiversnew, "w")

for k, rec in enumerate(Receivers):
    i = ids[k]
    print(f"processing receiver {k}, ({rec} -> {centers[i]}), distance {dist[k]:.2f})")
    newrec = centers[i]
    fout.write("%f %f %f\n" % (newrec[0], newrec[1], newrec[2]))
fout.close()
