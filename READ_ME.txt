1. import_myc.m

Imports All_Radius_Values.csv data from Data folder

* Change cond variable for depth (0), or mag (1) analysis *


2. gmm_myc.m

Uses imported data to form Gaussian Mixture Model and Bayesian Inference Criteria figures.

Returns A_d

* Edit A_d before running d_vs_mu *  
(Data points in Figure 2 are colored to represent common fiber types. This coloring is determined by the 'component' index. Edit the component based upon the 'mu' /radius index)

A_d: 1x4 cell, a cell for each depth/magnification 
A_d = [ mu, sigma, mixing component, depth, image, component ]

Edit each depth/mag, and change the final column (component/fiber type) based on the first column (radius). 

mu ; component #
--- --------------
~0.2; component 1
~0.4; component 2
~0.8; component 3
~1.2; component 4. 


3. d_vs_mu.m

Uses A_d to produce Figure 2

-----------------------------------------------------------------
Supplemental:
read_seg1.m

Produces montages of raw and segmented SEM images found in Data folder