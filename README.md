# gm_mathcache
A module used for caching math calculation data so as not to have to constantly perform specific calculations that eat up resources.

This module is mainly for use on complicated calculations that are not constantly changing.
For example vgui size and pos for huds and panels. Its kinda pointless on data that constantly changes such as Player:GetPos()
However there are other functions in this module that allow you to use this module for other things.

The module works both serverside and clientside.
