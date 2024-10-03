----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Tiger Light Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT2EXMDF : TLandUnit
BRNT2EXMDF = Class(TLandUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 3.5,
			FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash01,
		},
		MainGun2 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 3.5,
			FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash01,
		},
		Turret01 = Class(TAMPhalanxWeapon){
			PlayFxWeaponUnpackSequence = function(self)
				if not self.SpinManip then
					self.SpinManip = CreateRotator(self.unit, 'spinner', 'z', nil, 270, 180, 60)
					self.unit.Trash:Add(self.SpinManip)
				end
				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(270)
				end
				TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
			end,
			PlayFxWeaponPackSequence = function(self)
				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(0)
				end
				TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},

	---@param self BRNT2EXMDF
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXMDF
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXMDF
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT2EXMDF
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT2EXMDF
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFHEAVYMISSILE01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNT2EXMDF', army, v):ScaleEmitter(2.0))
		end
	end,
}

TypeClass = BRNT2EXMDF
