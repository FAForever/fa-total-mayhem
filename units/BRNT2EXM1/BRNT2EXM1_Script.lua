----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT2EXM1 : CWalkingLandUnit
BRNT2EXM1 = Class(CWalkingLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.7 },
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNT2EXM1
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXM1
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXM1
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT2EXM1
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT2EXM1
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath03'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'UEL1001_PelvisB01', army, v):ScaleEmitter(0.7))
		end
	end,
}

TypeClass = BRNT2EXM1
