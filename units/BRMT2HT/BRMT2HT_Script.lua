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
local TDFMachineGunWeapon = WeaponsFile.TDFMachineGunWeapon

-- Upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add


---@class BRMT2HT : TLandUnit
BRMT2HT = Class(TLandUnit){
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
				local army = self.Army
				local unit = self.unit
				local trash = self.Trash

				for _, v in self.FxGroundEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT2HT', army, v):ScaleEmitter(1.0))
				end
				for _, v in self.FxVentEffect3 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT2HT', army, v):ScaleEmitter(0.7))
				end
				for _, v in self.FxMuzzleEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle', army, v):ScaleEmitter(3.45))
				end
				for _, v in self.FxVentEffect5 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle01', army, v):ScaleEmitter(2.15))
				end
				for _, v in self.FxVentEffect5 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle02', army, v):ScaleEmitter(2.15))
				end
				for _, v in self.FxVentEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent01', army, v):ScaleEmitter(1.7))
				end
				for _, v in self.FxVentEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent02', army, v):ScaleEmitter(1.7))
				end
				for _, v in self.FxVentEffect2 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle', army, v):ScaleEmitter(2.0))
				end
			end,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		commanderw = Class(TDFMachineGunWeapon){},
	},

	---@param self BRMT2HT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2HT
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2HT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRMT2HT
