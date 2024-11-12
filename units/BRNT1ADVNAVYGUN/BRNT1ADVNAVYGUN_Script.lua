-- ****************************************************************************
-- **
-- **  File     :  /Mods/units/UEB2201/UEB2201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  UEF Light Artillery Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TSubUnit = import('/lua/terranunits.lua').TSubUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

BRNT1ADVNAVYGUN = Class(TSubUnit){
    SwitchAnims = true,
    IsWaiting = false,
    Weapons = { MainGun = Class(TDFGaussCannonWeapon){} },
}

TypeClass = BRNT1ADVNAVYGUN
