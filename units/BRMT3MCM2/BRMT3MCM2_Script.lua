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
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TDFRiotWeapon = WeaponsFile2.TDFRiotWeapon
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RobotTalkFile = import('/lua/cybranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local CIFGrenadeWeapon = RobotTalkFile.CIFGrenadeWeapon

BRMT3MCM2 = Class(CWalkingLandUnit){
    Weapons = {
        robottalk = Class(CIFGrenadeWeapon){ FxMuzzleFlashScale = 0 },
        mgweapon = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
            FxMuzzleFlashScale = 0.75,
        },
        lefthandweapon = Class(CCannonMolecularWeapon){
            FxMuzzleFlash = EffectTemplate.CHvyProtonCannonMuzzleflash,
            FxMuzzleFlashScale = 1.6,
        },
        righthandweapon = Class(CCannonMolecularWeapon){
            FxMuzzleFlash = EffectTemplate.CHvyProtonCannonMuzzleflash,
            FxMuzzleFlashScale = 1.6,
        },
        rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
        rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
        rocket3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
        rocket4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
        laserfire = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
        HeavyBolter = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 2.15 },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        CWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['MadCatDeath02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.5))
        end
    end,
}

TypeClass = BRMT3MCM2
