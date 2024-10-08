----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

---@class BRMT2BM : CWalkingLandUnit
BRMT2BM = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 0.75 },
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRMT2BM
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2BM
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2BM
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRMT2BM
