----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/URA0102/URA0102_script.lua
--  Author(s):  John Comes, David Tomandl
--
--  Summary  :  Cybran Unit Script
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon
local SDFBombOtheWeapon = import('/lua/seraphimweapons.lua').SDFBombOtheWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPAT1ADVBOMB = Class(CAirUnit){
    Weapons = {
        aircraft = Class(CAAAutocannon){ FxMuzzleFlashScale = 0 },
        autoattack = Class(CAAAutocannon){ FxMuzzleFlashScale = 0 },
        Bomb = Class(SDFBombOtheWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CAirUnit.OnStopBeingBuilt(self, builder, layer)
        self:CreatTheEffects()
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        CAirUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Effect01', army, v):ScaleEmitter(0.35))
        end
        for k, v in EffectTemplate['OthuyAmbientEmanation'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Gauche_Projectile02', army, v):ScaleEmitter(0.08))
        end
    end,
}

TypeClass = BRPAT1ADVBOMB
