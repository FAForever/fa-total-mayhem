----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Tiger Light Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

---@class BRNT1MT: TLandUnit
BRNT1MT = Class(TLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.5 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNT1MT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1MT
	---@param transport Unit
	---@param bone string
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1MT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRNT1MT
