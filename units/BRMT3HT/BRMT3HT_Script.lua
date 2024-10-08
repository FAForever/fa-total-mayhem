----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3HT : TLandUnit
BRMT3HT = Class(TLandUnit){
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
			FxMuzzleEffect = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,

			---@param self TDFGaussCannonWeapon
			---@param muzzle string Unused
			PlayFxMuzzleSequence = function(self, muzzle)
				local unit = self.unit
				local army = unit.Army
				local trash = unit.Trash
				for _, v in self.FxGroundEffect do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT3HT', army, v):ScaleEmitter(2.25))
				end
				for _, v in self.FxVentEffect3 do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT3HT', army, v):ScaleEmitter(1.6))
				end
				for _, v in self.FxVentEffect3 do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT3HT', army, v):ScaleEmitter(2.1))
				end
				for _, v in self.FxMuzzleEffect do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle', army, v):ScaleEmitter(4.1))
				end
				for _, v in self.FxVentEffect do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent01', army, v):ScaleEmitter(1.15))
				end
				for _, v in self.FxVentEffect do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent02', army, v):ScaleEmitter(1.15))
				end
				for _, v in self.FxVentEffect2 do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle', army, v):ScaleEmitter(1))
				end
				for _, v in self.FxVentEffect5 do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle01', army, v):ScaleEmitter(2.5))
				end
				for _, v in self.FxVentEffect5 do
					unit.TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle02', army, v):ScaleEmitter(2.5))
				end
			end,
		},
	},

	---@param self BRMT3HT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT3HT
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT3HT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRMT3HT
