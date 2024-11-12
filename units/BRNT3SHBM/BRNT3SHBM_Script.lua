-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFGaussCannonWeapon3 = WeaponsFile.TDFLandGaussCannonWeapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRNT3SHBM = Class(TWalkingLandUnit){
    Weapons = {
        mainrockets = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        lefthandweapon = Class(TDFGaussCannonWeapon3){
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

                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT3SHBM', army, v):ScaleEmitter(2.1))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle01', army, v):ScaleEmitter(2.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle01', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle02', army, v):ScaleEmitter(2.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle02', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle03', army, v):ScaleEmitter(2.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle03', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle04', army, v):ScaleEmitter(2.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle04', army, v):ScaleEmitter(1.15))
                end
            end,
        },
        righthandweapon = Class(TDFGaussCannonWeapon3){
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

                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT3SHBM', army, v):ScaleEmitter(2.1))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle05', army, v):ScaleEmitter(4.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle05', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle06', army, v):ScaleEmitter(4.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle06', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle07', army, v):ScaleEmitter(4.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle07', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle08', army, v):ScaleEmitter(4.65))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'gun_muzzle08', army, v):ScaleEmitter(1.15))
                end
            end,
        },
        rocketweapon1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon5 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon6 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon7 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        rocketweapon8 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['UEFDeath02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(2.25))
        end
    end,
}

TypeClass = BRNT3SHBM
