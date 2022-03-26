# gm_mathcache
A module used for caching math calculation data so as not to have to constantly perform specific calculations that eat up resources.

This module is mainly for use on complicated calculations that are not constantly changing.
For example vgui size and pos for huds and panels. Its kinda pointless on data that constantly changes such as Player:GetPos()
However there are other functions in this module that allow you to use this module for other things.

The module works both serverside and clientside.


## Functions
1. MathCache.Cache(id,cback) Caches data into a value. Does not return anything. This simply puts it in the cache or updates it in the cache
2. MathCache.Quick(id,cback) Quickly checks if a data is in storage and returns it, if not it will perform the calculation, store the data and return it.
3. MathCache.Get(id) Returns the data stored at a given id or nil
4. MathCache.Reset(id) Removes a cached ID by setting it to nil
5. MathCache.Dump() Dumps the ENTIRE cache of calculations. anything that is important will be uncached(use with caution)

## TODO:
1. MathCache.SafeDump(ids) - Takes a table of IDs, these IDs will be ignored when dumping the cache. Use this one unless you absolutely want to dump everything
2. Remake the vgui_cache function to work a bit better and cleaner???? We will se
