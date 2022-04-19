#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  8 15:56:36 2020

@author: moorkamp
"""

import obspy
from obspy.io.xseed import Parser
import matplotlib.pyplot as plt

st = obspy.read("NR.NE208..BHE.M.2017.093.174018.SAC")
parser = Parser("IRISDMC-NE208.NR.dataless")

pre_filt = (0.005, 0.006, 30.0, 35.0)
st.simulate(pre_filt=pre_filt,seedresp={'filename': parser, 'units': "DIS"})

print (st[0])

tr = st[0]
time = tr.times()

plt.subplot(211)
plt.plot(time, tr.data, 'k')
plt.ylabel('Displacement [m]')
plt.xlabel('Time [s]')
plt.show()