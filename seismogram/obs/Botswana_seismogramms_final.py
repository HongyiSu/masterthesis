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
east = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..BHE.M.2017.093.174018.SAC')
north = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..BHN.M.2017.093.174018.SAC')
vertical = read('/Users/thomasobermaier/Documents/Studium/BachelorGeophysik/6Semester/BA/Seismogramme/NR.NE208..BHZ.M.2017.093.174018.SAC')

### Channel ID's
HE=east[0]
HN=north[0]
HZ=vertical[0]

### Instrument response
parser = Parser("IRISDMC-NE208.NR.dataless")
pre_filt = (0.005, 0.006, 30.0, 35.0)
east.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})
north.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})
vertical.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})

### Filtering with a butterworth bandpass on a copy of the original 
east_filt = east.copy()
north_filt = north.copy()
vertical_filt = vertical.copy()
    # Nyquist frequency is 0.5 for sampling rate 1 Hz 
if HE.stats.channel == 'BHE':
    east_filt.filter('bandpass', freqmin=0.2, freqmax=0.6, corners=4, zerophase=True)  
else:
    east_filt.filter('bandpass', freqmin=0.2, freqmax=0.49, corners=4, zerophase=True)

if HE.stats.channel == 'BHE':
    north_filt.filter('bandpass', freqmin=0.2, freqmax=0.6, corners=4, zerophase=True)  
else:
    north_filt.filter('bandpass', freqmin=0.2, freqmax=0.49, corners=4, zerophase=True)

if HE.stats.channel == 'BHE':
    vertical_filt.filter('bandpass', freqmin=0.2, freqmax=0.6, corners=4, zerophase=True)  
else:
    vertical_filt.filter('bandpass', freqmin=0.2, freqmax=0.49, corners=4, zerophase=True)

### Plot
tr = east[0]
time = tr.times()

fig, axs = plt.subplots(3, sharex=True, sharey=True, dpi=150, gridspec_kw={'hspace': 0})
fig.suptitle(('Station %s, sampling frequency %s Hz') % (HE.stats.station, HE.stats.sampling_rate))
axs[0].plot(time, east_filt[0].data, 'k')
axs[1].plot(time, north_filt[0].data, 'k')
axs[2].plot(time, vertical_filt[0].data, 'k')

plt.xlim(0,3*60)
axs[1].set_ylabel('Displacement [m]')
axs[2].set_xlabel('Time [s]')
plt.gcf().subplots_adjust(left=0.15)
plt.gcf().subplots_adjust(bottom=0.1)

### Save plot
plt.savefig('plots/%s_%s.png' % (HE.stats.station, HE.stats.sampling_rate))
