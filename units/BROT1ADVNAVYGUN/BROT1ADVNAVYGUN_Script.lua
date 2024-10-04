--------------------------------------------------------------
-- File     :  /cdimage/units/UAB2303/UAB2303_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Light Artillery Installation Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------
local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AeonWeapons = import('/lua/aeonweapons.lua')

local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon

---@class BROT1ADVNAVYGUN : AStructureUnit
BROT1ADVNAVYGUN = Class(AStructureUnit){
	Weapons = { MissileRack = Class(ADFCannonQuantumWeapon){} },
}

TypeClass = BROT1ADVNAVYGUN
