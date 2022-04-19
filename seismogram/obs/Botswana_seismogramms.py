########## Botswana Seismogramms
from obspy import read
from obspy.io.xseed import Parser
import numpy as np
import matplotlib.pyplot as plt
import os

### creat output folder
if not os.path.exists('plots'):
    os.makedirs('plots')
    
### BHE = broad band, sampled with 20Hz; LHE = longperiod, sampled with 1Hz
east = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..LHE.M.2017.093.174018.SAC')
north = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..LHN.M.2017.093.174018.SAC')
vertical = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..LHZ.M.2017.093.174018.SAC')
#print (east)

### Channel ID's
HE=east[0]
HN=north[0]
HZ=vertical[0]
#print(HE.data)

### One variable to plot 3 components in one seismogramm
threecomponents = vertical
threecomponents += north
threecomponents += east

### Instrument response
parser = Parser("IRISDMC-NE208.NR.dataless")
pre_filt = (0.005, 0.006, 30.0, 35.0)
east.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})
north.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})
vertical.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})

### Determine start and endtime
dt = vertical[0].stats.starttime
#threecomponents.plot(starttime=dt+0.8*60, endtime=dt + 4*60)

### Filtering with a butterworth bandpass on a copy of the original 
threecomp_filt = threecomponents.copy()
    # Nyquist frequency is 0.5 for sampling rate 1 Hz 
if HE.stats.channel == 'BHE':
    threecomp_filt.filter('bandpass', freqmin=0.2, freqmax=0.6, corners=4, zerophase=True)  
else:
    threecomp_filt.filter('bandpass', freqmin=0.2, freqmax=0.49, corners=4, zerophase=True)

### save to file
threecomp_filt.plot(starttime=dt, endtime=dt + 3*60, outfile='plots/%s_%s.png' % (HE.stats.station, HE.stats.sampling_rate))

### show plot
threecomp_filt.plot(starttime=dt+0.8*60, endtime=dt + 4*60)

