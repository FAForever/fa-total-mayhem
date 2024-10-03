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
local TDFMachineGunWeapon = WeaponsFile.TDFMachineGunWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT1BT: TLandUnit
BRNT1BT = Class(TLandUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.5,
			FxMuzzleFlash = {
				'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
				'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
				'/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
			},
			FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
			FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
			FxVentEffect = EffectTemplate.CDisruptorVentEffect,
			FxVentEffect2 = EffectTemplate.WeaponSteam01,
			FxVentEffect4 = EffectTemplate.THeavyFragmentationGrenadeHit,
			FxMuzzleEffect = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
			FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
			PlayFxMuzzleSequence = function(self, muzzle)
				local army = self.unit:GetArmy()
				for k, v in self.FxVentEffect3 do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT1BT', army, v):ScaleEmitter(0.7))
				end
				for k, v in self.FxMuzzleEffect do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(3.1))
				end
				for k, v in self.FxVentEffect2 do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(2.15))
				end
			end,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		commanderw = Class(TDFMachineGunWeapon){},
		grenadew = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.30 },
	},

	---@param self BRNT1BT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1BT
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1BT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT1BT
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT1BT
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeathSML01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNT1BT', army, v):ScaleEmitter(0.6))
		end
	end,
}

TypeClass = BRNT1BT
