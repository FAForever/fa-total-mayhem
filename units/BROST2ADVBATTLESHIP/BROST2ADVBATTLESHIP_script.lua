local AeonWeapons = import('/lua/aeonweapons.lua')
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local WeaponFile = import('/lua/terranweapons.lua')
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AANChronoTorpedoWeapon = AeonWeapons.AANChronoTorpedoWeapon
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SDFChronotronCannonWeapon = SWeapons.SDFChronotronCannonWeapon

BROST2ADVBATTLESHIP = Class(ASeaUnit){
    Weapons = {
        Torpedo1 = Class(AANChronoTorpedoWeapon){},
        FrontTurret = Class(ADFCannonQuantumWeapon){},
        FrontTurret2 = Class(ADFCannonQuantumWeapon){},
        FrontTurret3 = Class(ADFCannonQuantumWeapon){},
        FrontTurret4 = Class(ADFCannonQuantumWeapon){},
        FrontTurretbig1 = Class(SDFChronotronCannonWeapon){
            FxMuzzleFlashScale = 4.85,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
        },
        FrontTurretbig2 = Class(SDFChronotronCannonWeapon){
            FxMuzzleFlashScale = 4.85,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
        },
        AntiAirMissiles01 = Class(AAAZealotMissileWeapon){},
        AntiAirMissiles02 = Class(AAAZealotMissileWeapon){},
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    BackWakeEffect = {},
    OnStopBeingBuilt = function(self, builder, layer)
        ASeaUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Sonara', 'y', nil, 90, 0, 0))

        ASeaUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
}

TypeClass = BROST2ADVBATTLESHIP
