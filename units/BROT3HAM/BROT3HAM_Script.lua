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
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon

BROT3HAM = Class(CWalkingLandUnit){
    Weapons = {
        DeathWeapon = Class(SCUDeathWeapon){},
        rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        RightRiotgun = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
            FxMuzzleFlashScale = 0.75,
        },
        LeftRiotgun = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
            FxMuzzleFlashScale = 0.75,
        },
        rightarmweapon = Class(TDFGaussCannonWeapon){
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
            FxMuzzleEffect = EffectTemplate.AIFBallisticMortarFlash02,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxGroundEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3HAM', army, v):ScaleEmitter(1.6))
                end
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3HAM', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'rightarm_muzzle01', army, v):ScaleEmitter(4.25))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'rightarm_muzzle01', army, v):ScaleEmitter(3.25))
                end
            end,
        },
        leftarmweapon = Class(TDFGaussCannonWeapon){
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
            FxMuzzleEffect = EffectTemplate.AIFBallisticMortarFlash02,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxGroundEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3HAM', army, v):ScaleEmitter(1.6))
                end
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3HAM', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'leftarm_muzzle01', army, v):ScaleEmitter(4.25))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'leftarm_muzzle01', army, v):ScaleEmitter(3.25))
                end
            end,
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
}

TypeClass = BROT3HAM
