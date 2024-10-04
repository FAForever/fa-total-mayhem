----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- Upvale for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BROT1EXM1 : CWalkingLandUnit
BROT1EXM1 = Class(CWalkingLandUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 2.1,
			FxMuzzleFlash = {
				'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
				'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
				'/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
			},
			FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
			FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
			FxVentEffect = EffectTemplate.CDisruptorVentEffect,
			FxVentEffect2 = EffectTemplate.WeaponSteam01,
			FxVentEffect4 = EffectTemplate.CHvyProtonCannonHitUnit01,
			FxVentEffect5 = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxMuzzleEffect = EffectTemplate.ADisruptorCannonMuzzle01,
			FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
			PlayFxMuzzleSequence = function(self, muzzle)
				local army = self.unit:GetArmy()
				for k, v in self.FxMuzzleEffect do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme', army, v):ScaleEmitter(1.45))
				end
				for k, v in self.FxVentEffect do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(0.5))
				end
				for k, v in self.FxVentEffect do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(0.5))
				end
				for k, v in self.FxVentEffect2 do
					self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme', army, v):ScaleEmitter(1))
				end
			end,
		},
		Riotgun = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
	},

	---@param self BROT1EXM1
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BROT1EXM1
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BROT1EXM1
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BROT1EXM1
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BROT1EXM1
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonUnitDeathRing02'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROT1EXM1', army, v):ScaleEmitter(0.55))
		end
	end,
}

TypeClass = BROT1EXM1
