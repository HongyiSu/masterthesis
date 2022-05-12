# Import
from pyproj import Proj

# Coordinates first_fault_plane.kml
content = "25.78630591547188,-22.63250866292953,0 25.53863310009017,-22.45523571938825,0 25.3098338819107,-22.29295158563638,0 25.0783952099167,-22.11056797468847,0"

# Working: Split coordinates and transform to UTM, then store temporary
memory = []
coordinates = content.split(' ')
for lines in coordinates:
    line = lines.split(',')
    lat = line[1]
    lon = line[0]
    myProj = Proj("+proj=utm +zone=34k +ellps=WGS84 +datum=WGS84 +units=m +no_defs +south")
    easting, northing = myProj(lon, lat) 
    print('Aus Lat =',lat,'und Lon =',lon,'wird in UTM (Zone =','):',' Easting', easting,'Northing', northing)
    e = str(easting)
    n = str(northing)
    memory.append(n + '\t' + e + '\t' + '\n')

# Remove last '\n' from temporary memory
memory[len(memory)-1] = memory[len(memory)-1][:-1]

# Print to file
destination = open(".\\second_fault_plane.dat",'w')
for text in memory:
    destination.write(text)   
destination.close()