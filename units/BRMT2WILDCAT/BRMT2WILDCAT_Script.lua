--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Effects = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local CDFHeavyDisintegratorWeapon = WeaponsFile.CDFHeavyDisintegratorWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local TAMPhalanxWeapon = WeaponsFile2.TAMPhalanxWeapon
local TDFPlasmaCannonWeapon = WeaponsFile2.TDFPlasmaCannonWeapon

-- upvalues for performance
local CreateRotator = CreateRotator
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT2WILDCAT : CWalkingLandUnit
BRMT2WILDCAT = Class(CWalkingLandUnit){
	Weapons = {
		gatling1 = Class(CDFHeavyDisintegratorWeapon){

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxWeaponPackSequence = function(self)
				local army = self.Army
				local unit = self.unit

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(0)
				end

				self.ExhaustEffects = EffectUtils.CreateBoneEffects(unit, 'Dummy03', army, Effects.WeaponSteam01)

				TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
			end,

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxRackSalvoChargeSequence = function(self)
				local trash = self.Trash
				local unit = self.unit

				if not self.SpinManip then
					self.SpinManip = CreateRotator(self.unit, 'spinner02', 'z', nil, 270, 180, 60)
					unit.TrashBagAdd(trash, self.SpinManip)
				end

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(800)
				end
				TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
			end,

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxRackSalvoReloadSequence = function(self)
				local army = self.Army
				local unit = self.unit

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(200)
				end
				self.ExhaustEffects = EffectUtils.CreateBoneEffects(unit, 'Dummy03', army, Effects.WeaponSteam01)
				TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
			end,
		},
		gatling2 = Class(CDFHeavyDisintegratorWeapon){

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxWeaponPackSequence = function(self)
				local army = self.Army
				local unit = self.unit

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(0)
				end
				self.ExhaustEffects = EffectUtils.CreateBoneEffects(unit, 'Dummy04', army, Effects.WeaponSteam01)
				TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
			end,

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxRackSalvoChargeSequence = function(self)
				local unit = self.unit

				if not self.SpinManip then
					local trash = unit.Trash

					self.SpinManip = CreateRotator(unit, 'spinner01', 'z', nil, 270, 180, 60)

					TrashBagAdd(trash,self.SpinManip)
				end

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(800)
				end
				TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
			end,

			---@param self CDFHeavyDisintegratorWeapon
			PlayFxRackSalvoReloadSequence = function(self)
				local army = self.Army
				local unit = self.unit

				if self.SpinManip then
					self.SpinManip:SetTargetSpeed(200)
				end
				self.ExhaustEffects =
					EffectUtils.CreateBoneEffects(unit, 'Dummy04', army, Effects.WeaponSteam01)
				TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
			end,
		},
		gatling2a = Class(CDFHeavyDisintegratorWeapon){},
		gatling1a = Class(CDFHeavyDisintegratorWeapon){},
		laserweapon = Class(TDFPlasmaCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRMT2WILDCAT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

		self:CreateTheEffects()

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
			self:SetWeaponEnabledByLabel('gatling1a', false)
			self:SetWeaponEnabledByLabel('gatling2a', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
			self:SetWeaponEnabledByLabel('gatling1a', true)
			self:SetWeaponEnabledByLabel('gatling2a', true)
			self:SetWeaponEnabledByLabel('gatling1', false)
			self:SetWeaponEnabledByLabel('gatling2', false)
		end
	end,

	---@param self BRMT2WILDCAT
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(1.70))
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(1.70))
		end
	end,
}
TypeClass = BRMT2WILDCAT