----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Tiger Light Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaGatlingCannonWeapon

BROT1BTT3 = Class(AHoverLandUnit){
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
            FxMuzzleEffect = EffectTemplate.AIFBallisticMortarFlash02,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT1BTT3', army, v):ScaleEmitter(0.7))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle01', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle02', army, v):ScaleEmitter(1.4))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(0.7))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(0.7))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'aim', army, v):ScaleEmitter(1.1))
                end
            end,
        },
        clawgun = Class(TDFHeavyPlasmaCannonWeapon){ FxMuzzleFlashScale = 0.4 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        AHoverLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        AHoverLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        AHoverLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonUnitDeathRing01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROT1BTT3', army, v):ScaleEmitter(0.5))
        end
    end,
}

TypeClass = BROT1BTT3
