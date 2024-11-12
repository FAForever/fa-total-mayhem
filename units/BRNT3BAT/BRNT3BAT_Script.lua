----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Scavenger Medium Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TDFLightPlasmaCannonWeapon = WeaponsFile.TDFLightPlasmaCannonWeapon
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon

BRNT3BAT = Class(TLandUnit){
    Weapons = {
        rocket = Class(ACruiseMissileWeapon){
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 2.2,
        },
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
                for k, v in self.FxGroundEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT3BAT', army, v):ScaleEmitter(3.8))
                end
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT3BAT', army, v):ScaleEmitter(3.8))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Main_Gun_Muzzle', army, v):ScaleEmitter(7.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Main_Gun_Muzzle', army, v):ScaleEmitter(2.55))
                end
            end,
        },
        a3GunA = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.45 },
        a3GunB = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
        Plasgun1 = Class(TDFLightPlasmaCannonWeapon){},
        Plasgun2 = Class(TDFLightPlasmaCannonWeapon){},
        Turret01 = Class(TAMPhalanxWeapon){
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'Left_TMD_Rotator', 'z', nil, 270, 180, 60)
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
        Turret02 = Class(TAMPhalanxWeapon){
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'Right_TMD_Rotator', 'z', nil, 270, 180, 60)
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
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        TLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
}

TypeClass = BRNT3BAT
