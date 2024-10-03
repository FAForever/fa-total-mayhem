-----------------------------------------------------------------------
-- File     :  /cdimage/units/URA0102/URA0102_script.lua
-- Author(s):  John Comes, David Tomandl
-- Summary  :  Cybran Interceptor Script : URA0102
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------------
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

---@class BRMAT1INTC : CAirUnit
BRMAT1INTC = Class(CAirUnit){
	Weapons = {
		aircraft = Class(CAAAutocannon){ FxMuzzleFlashScale = 0 },
		AutoCannon = Class(CAAAutocannon){},
		AutoCannon2 = Class(CAAAutocannon){},
	},
}
TypeClass = BRMAT1INTC