----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEAconcpt1/UEAconcpt1_script.lua
--  Author(s):  Jessica St. Croix, David Tomandl
--
--  Summary  :  UEF Spy Plane Script
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

BRNAT1ADVFIG = Class(TAirUnit){
    Weapons = {
        aamissiles1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        AGmissiles1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TAirUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        TAirUnit.OnDetachedFromTransport(self, transport, bone)
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

TypeClass = BRNAT1ADVFIG
