-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/URS0103/URS0103_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  Cybran Frigate Script
-- **
-- **  Copyright � 2006 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local WeaponFile = import('/lua/terranweapons.lua')
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon

BRMST1DESTR = Class(CSeaUnit){
    DestructionTicks = 200,
    Weapons = {
        Torpedo01 = Class(CANNaniteTorpedoWeapon){},
        Torpedo02 = Class(CANNaniteTorpedoWeapon){},
        ProtonCannon1 = Class(CDFProtonCannonWeapon){ FxMuzzleFlashScale = 1.6 },
        ProtonCannon2 = Class(CDFProtonCannonWeapon){ FxMuzzleFlashScale = 1.6 },
        AAGun1 = Class(CAAAutocannon){},
        AAGun2 = Class(CAAAutocannon){},
        AAGun3 = Class(CAAAutocannon){},
        AAGun4 = Class(CAAAutocannon){},
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CSeaUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Object11', 'y', nil, 120, 0, 0))

        CSeaUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
}

TypeClass = BRMST1DESTR
