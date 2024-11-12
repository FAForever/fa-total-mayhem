-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRNT3PDRO = Class(TStructureUnit){
    Weapons = { MainGun = Class(TDFGaussCannonWeapon){
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
        FxMuzzleEffect = EffectTemplate.CIFCruiseMissileLaunchSmoke,
        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
        PlayFxMuzzleSequence = function(self, muzzle)
            local army = self.unit:GetArmy()

            for k, v in self.FxVentEffect3 do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT3PDRO', army, v):ScaleEmitter(2.0))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent03', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent04', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent05', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent06', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent07', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxVentEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent08', army, v):ScaleEmitter(1.15))
            end
            for k, v in self.FxMuzzleEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle01', army, v):ScaleEmitter(1.3))
            end
            for k, v in self.FxMuzzleEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle02', army, v):ScaleEmitter(1.3))
            end
            for k, v in self.FxVentEffect2 do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle02', army, v):ScaleEmitter(3.15))
            end
            for k, v in self.FxMuzzleEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle03', army, v):ScaleEmitter(1.3))
            end
            for k, v in self.FxMuzzleEffect do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle04', army, v):ScaleEmitter(1.3))
            end
            for k, v in self.FxVentEffect2 do
                self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'muzzle04', army, v):ScaleEmitter(3.15))
            end
        end,
    } },
}

TypeClass = BRNT3PDRO
