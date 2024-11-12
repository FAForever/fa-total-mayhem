-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- **  Author(s):  John Comes, Gordon Duclos
-- **
-- **  Summary  :  Aeon Galactic Colossus Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeapons = import('/lua/aeonweapons.lua')
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local TMAnovacatgreenlaserweapon = TMWeaponsFile.TMAnovacatgreenlaserweapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local AAAZealotMissileWeapon = AWeapons.AAAZealotMissileWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BROT3NCM = Class(AWalkingLandUnit){
    Weapons = {
        laserblue = Class(TMAnovacatbluelaserweapon){},
        laserblue2 = Class(TMAnovacatbluelaserweapon){},
        laserblue3 = Class(TMAnovacatbluelaserweapon){},
        lasergreen = Class(TMAnovacatgreenlaserweapon){},
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.85,
            FxMuzzleFlash = {
                '/effects/emitters/aeon_quanticcluster_muzzle_flash_03_emit.bp',
                '/effects/emitters/aeon_quanticcluster_muzzle_flash_06_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
            FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
            FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
            FxVentEffect = EffectTemplate.CDisruptorVentEffect,
            FxVentEffect2 = EffectTemplate.WeaponSteam01,
            FxVentEffect4 = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
            FxVentEffect5 = TMEffectTemplate.AeonNovaCatFireEffect01,
            FxMuzzleEffect = EffectTemplate.AOblivionCannonMuzzleFlash02,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme', army, v):ScaleEmitter(0.45))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme', army, v):ScaleEmitter(1.65))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(1.15))
                end
            end,
        },
        MainGun2 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.85,
            FxMuzzleFlash = {
                '/effects/emitters/aeon_quanticcluster_muzzle_flash_03_emit.bp',
                '/effects/emitters/aeon_quanticcluster_muzzle_flash_06_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
            FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
            FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
            FxVentEffect = EffectTemplate.CDisruptorVentEffect,
            FxVentEffect2 = EffectTemplate.WeaponSteam01,
            FxVentEffect4 = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
            FxVentEffect5 = TMEffectTemplate.AeonNovaCatFireEffect01,
            FxVentEffect6 = EffectTemplate.AGravitonBolterMuzzleFlash01,
            FxMuzzleEffect = EffectTemplate.AQuantumCannonMuzzle02,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxGroundEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3NCM', army, v):ScaleEmitter(2.55))
                end
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BROT3NCM', army, v):ScaleEmitter(2.1))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme2', army, v):ScaleEmitter(7.05))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme2', army, v):ScaleEmitter(1.65))
                end
                for k, v in self.FxVentEffect5 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'spark01', army, v):ScaleEmitter(2.15))
                end
                for k, v in self.FxVentEffect5 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'spark02', army, v):ScaleEmitter(2.15))
                end
                for k, v in self.FxVentEffect6 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'spark01', army, v):ScaleEmitter(3.0))
                end
                for k, v in self.FxVentEffect6 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'spark02', army, v):ScaleEmitter(3.0))
                end
                for k, v in self.FxVentEffect4 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'stikkflamme2', army, v):ScaleEmitter(3.15))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(1.75))
                end
            end,
        },
        AntiAirMissiles = Class(AAAZealotMissileWeapon){},
        AntiAirMissiles2 = Class(AAAZealotMissileWeapon){},
        robottalk = Class(AAAZealotMissileWeapon){ FxMuzzleFlashScale = 0 },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        AWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
}
TypeClass = BROT3NCM
