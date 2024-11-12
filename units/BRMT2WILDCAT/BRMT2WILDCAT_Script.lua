-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local CDFHeavyDisintegratorWeapon = WeaponsFile.CDFHeavyDisintegratorWeapon
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TDFPlasmaCannonWeapon = WeaponsFile2.TDFPlasmaCannonWeapon
local TAMPhalanxWeapon = WeaponsFile2.TAMPhalanxWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Effects = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRMT2WILDCAT = Class(CWalkingLandUnit){
    Weapons = {
        gatling1 = Class(CDFHeavyDisintegratorWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'Dummy03', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'spinner02', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end

                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(800)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'Dummy03', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        gatling2 = Class(CDFHeavyDisintegratorWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'Dummy04', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'spinner01', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end

                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(800)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'Dummy04', self.unit:GetArmy(), Effects.WeaponSteam01)
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
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        self:CreatTheEffects()
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
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(1.70))
            self.Trash:Add(CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(1.70))
        end
    end,
}

TypeClass = BRMT2WILDCAT
