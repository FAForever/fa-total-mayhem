----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Scavenger Medium Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local Effects = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

BRNT2BM = Class(TWalkingLandUnit){
    Weapons = {
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        gatling1a = Class(TAMPhalanxWeapon){},
        gatling2a = Class(TAMPhalanxWeapon){},
        gatling3a = Class(TAMPhalanxWeapon){},
        gatling4a = Class(TAMPhalanxWeapon){},
        gatling1 = Class(TAMPhalanxWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'minigunspin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        gatling2 = Class(TAMPhalanxWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'minigun01spin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        gatling3 = Class(TAMPhalanxWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle02', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'minigun02spin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle02', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        gatling4 = Class(TAMPhalanxWeapon){
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle03', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'minigun03spin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects =
                    EffectUtils.CreateBoneEffects(self.unit, 'minigunmuzzle03', self.unit:GetArmy(), Effects.WeaponSteam01)
                TAMPhalanxWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        TWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
            self:SetWeaponEnabledByLabel('gatling1a', false)
            self:SetWeaponEnabledByLabel('gatling2a', false)
            self:SetWeaponEnabledByLabel('gatling3a', false)
            self:SetWeaponEnabledByLabel('gatling4a', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
            self:SetWeaponEnabledByLabel('gatling1a', true)
            self:SetWeaponEnabledByLabel('gatling2a', true)
            self:SetWeaponEnabledByLabel('gatling3a', true)
            self:SetWeaponEnabledByLabel('gatling4a', true)
            self:SetWeaponEnabledByLabel('gatling1', false)
            self:SetWeaponEnabledByLabel('gatling2', false)
            self:SetWeaponEnabledByLabel('gatling3', false)
            self:SetWeaponEnabledByLabel('gatling4', false)
        end
    end,
}

TypeClass = BRNT2BM
