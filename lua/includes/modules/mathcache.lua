local gmod = (branch and true) or false	-- Used to allow for the library to function outside of garry's mod properly

if gmod then
	AddCSLuaFile()
	MathCache = MathCache or {} -- Create our global table for the library
end

local store = {} -- Where we store cached math calculations 

-- For vgui caching, only exists clientside
if gmod and CLIENT then		-- This does not exist outside of garry's mod
	local ui_cache = {}

	--[[
		vgui_cache function:

		Description: To support screen resolution changes we need a seperate function made for caching stuff relating to vgui size, pos, ect.
		This way we can void them all without having to also void all the other cached data for non-vgui stuff.

		Parameters:
			id - The ID of the vgui data to cache
			cback - The function callback used to perform a calculation

		Notes: Make sure you check if the cache data is valid and if not recache it. Otherwise when when screen size changes the data will suddenly be nil
	]]
	local function vgui_cache(id,cback)
		local data = cback() || false

		if data then
			store[id] = data
			if data == 0 then
				print('[vgui | '..id..'] Callback function storing value of 0. Please double check that this value should be this small.')
			end
		else
			print('[vgui | '..id..'] Callback function did not propperly finish, calculation has not been cached!!!')
		end
	end
	MathCache.vgui_cache = vgui_cache

	hook.Add('OnScreenSizeChanged','vgui_cache_reset',function()
		ui_cache = {}
	end)
end

--[[
	Cache function:
	Description: Used for caching expensive calculations of thing that are not dynamically changing but are needed often.
	Parameters:
		id - The ID of the calculation you want to cache(can be a number or string, however it is best to use a string unless you know exactly what each entry will be.)
		cback - The function callback used to perform a calculation

	Notes: you can cache numbers, but you can also cache Vectors, Angles, Colors, Strings and Bools. Just make sure not to cache dynamic data
]]
local function Cache(id,cback)
	local data = cback() || false

	if data then
		store[id] = data
		if data == 0 then
			print('['..id..'] Callback function storing value of 0. Please double check that this value should be this small.')
		end
	else
		print('['..id..'] Callback function did not propperly finish, calculation has not been cached!!!')
	end
end

--[[
	Quick Calculation function:
	Description: Quickly check and retireve the data or calculate it
	Parameters:
		id - The ID of the data you want to retrieve
		cback - A function to calculate the data IF it doesn't exist in the storage
]]
local function Quick(id,cback)
	if store[id] then
		return store[id]	
	end

	store[id] = cback()
	return store[id]
end

--[[
	Get function:
	Description: Retrieves a previously cached data piece.
	Parameters:
		id - The ID of the data you want to retrieve
]]
local function Get(id)
	return store[id]
end

--[[
	Reset function:
	Description: Clears a cached data ID
	Parameters:
		id - The ID of the data you want to clear
]]
local function Reset(id)
	store[id] = nil
end

--[[
	Dump function:
	Description: Clears the entire math cache

	notes: Be sure that your checking if any instance of MathCache.Get() has returned nil, otherwise expect errors
]]
local function Dump()
	store = {}
end

if gmod then
	MathCache.Cache = Cache
	MathCache.Get = Get
	MathCache.Quick = Quick
	MathCache.Reset = Reset
	MathCache.Dump = Dump
else	-- For compatibility outside of garry's mod
	return {
		Cache = Cache,
		Get = Get,
		Quick = Quick,
		Reset = Reset,
		Dump = Dump
	}
end

