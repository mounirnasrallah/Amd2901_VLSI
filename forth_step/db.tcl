#!/usr/bin/env avt_shell

#############################################################
# Timing Database Generation                                #
#############################################################

# Spice parser
avt_config avtSpiTolerance high


# Timing Analysis Parameters
avt_config simVthHigh 0.8
avt_config simVthLow 0.2
avt_config tasGenerateConeFile yes
avt_config avtVerboseConeFile yes
avt_config simToolModel eldo

inf_SetFigureName amd2901

# Technology Parameters
avt_LoadFile amd2901.spi spice

set fig [hitas amd2901]
