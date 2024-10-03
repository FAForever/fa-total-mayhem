------------------------------------------------------------------------ 
-- File     :  /cdimage/units/UEB2301/UEB2301_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Heavy Gun Tower Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT2EPD : TStructureUnit
BRMT2EPD = Class(TStructureUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 2.6,
			FxMuzzleFlash = {
				'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
				'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
				'/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
			},
			FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
			FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
			FxVentEffect = EffectTemplate.CDisruptorVentEffect,
			FxVentEffect2 = EffectTemplate.WeaponSteam01,
			FxMuzzleEffect = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,

			---@param self TDFGaussCannonWeapon
			---@param muzzle string Unused
			PlayFxMuzzleSequence = function(self, muzzle)
				local army = self.Army
				local unit = self.unit
				local trash = self.Trash

				for _, v in self.FxVentEffect3 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'BRMT2EPD', army, v):ScaleEmitter(1.35))
				end
				for _, v in self.FxMuzzleEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'Turret_Muzzle', army, v):ScaleEmitter(3.15))
				end
				for _, v in self.FxVentEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent01', army, v):ScaleEmitter(1))
				end
				for _, v in self.FxVentEffect do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'vent02', army, v):ScaleEmitter(1))
				end
				for _, v in self.FxVentEffect2 do
					TrashBagAdd(trash, CreateAttachedEmitter(unit, 'smoke01', army, v):ScaleEmitter(1))
				end
			end,
		},
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self any
	---@param builder any
	---@param layer any
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash,CreateRotator(self, 'radar', 'y', nil, 110, 0, 0))
		self:CreateTheEffects()
	end,

	---@param self any
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'effect01', army, v):ScaleEmitter(3.30))
		end
	end,
}

TypeClass = BRMT2EPD
