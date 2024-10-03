--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UES0202/UES0202_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Cruiser Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TSAMLauncher = WeaponFile.TSAMLauncher
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon

-- upvalue for performance
local CreateRotator = CreateRotator
local IsUnit = IsUnit
local TrashBagAdd = TrashBag.Add

---@class BRNST1ARTILLERY: TSeaUnit
BRNST1ARTILLERY = Class(TSeaUnit){
	DestructionTicks = 200,
	Weapons = {
		FrontTurret01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		FrontTurret02 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		FrontTurret03 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		FrontTurret04 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		BackTurret02 = Class(TSAMLauncher){ FxMuzzleFlash = EffectTemplate.TAAMissileLaunchNoBackSmoke },
	},

	---@param self BRNST1ARTILLERY
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TSeaUnit.OnStopBeingBuilt(self, builder, layer)

		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Spinner02', 'y', nil, 90, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Spinner01', 'y', nil, -50, 0, 0))

		TSeaUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRNST1ARTILLERY
