-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local TDFMachineGunWeapon = WeaponsFile2.TDFMachineGunWeapon
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

BRMT3CLOAKER = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CDFElectronBolterWeapon){},
		HeavyBolter2 = Class(CDFElectronBolterWeapon){},
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
	},
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('robottalk', false)
		else
			self:SetWeaponEnabledByLabel('robottalk', true)
		end
		self.DelayedCloakThread = self:ForkThread(self.CloakDelayed)
	end,
	CloakDelayed = function(self)
		if not self.Dead then
			WaitSeconds(2)
			self.IntelDisables['RadarStealth']['ToggleBit5'] = true
			self.IntelDisables['Cloak']['ToggleBit8'] = true -- not needed after cloakfied fixed
			self.IntelDisables['CloakField']['ToggleBit3'] = true
			self:EnableUnitIntel('ToggleBit5', 'RadarStealth')
			self:EnableUnitIntel('ToggleBit8', 'Cloak') -- not needed after cloakfied fixed
			self:EnableUnitIntel('ToggleBit3', 'CloakField')
		end
		KillThread(self.DelayedCloakThread)
		self.DelayedCloakThread = nil
	end,
}

TypeClass = BRMT3CLOAKER
