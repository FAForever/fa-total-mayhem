------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom

---@class BRMT1EXPDT2 :TStructureUnit
BRMT1EXPDT2 = Class(TStructureUnit){
	Weapons = { MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom){} },
}
TypeClass = BRMT1EXPDT2