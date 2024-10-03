--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UES0201/UES0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Terran Destroyer Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TAALinkedRailgun = WeaponFile.TAALinkedRailgun
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TANTorpedoAngler = WeaponFile.TANTorpedoAngler
local TIFSmartCharge = WeaponFile.TIFSmartCharge

-- upvalue for performance
local CreateRotator = CreateRotator
local IsUnit = IsUnit
local TrashBagAdd = TrashBag.Add

---@class BRNST1BATTLESHIP: TSeaUnit
BRNST1BATTLESHIP = Class(TSeaUnit){
	DestructionTicks = 200,
	Weapons = {
		FrontTurret01 = Class(TDFGaussCannonWeapon){},
		FrontTurret01a = Class(TDFGaussCannonWeapon){},
		FrontTurret01b = Class(TDFGaussCannonWeapon){},
		FrontTurret01c = Class(TDFGaussCannonWeapon){},
		sidec01 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec02 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec03 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec04 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec05 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec06 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec07 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		sidec08 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.5 },
		BackTurret01 = Class(TDFGaussCannonWeapon){},
		FrontTurret02 = Class(TAALinkedRailgun){},
		FrontTurret02a = Class(TAALinkedRailgun){},
		FrontTurret02b = Class(TAALinkedRailgun){},
		Torpedo01 = Class(TANTorpedoAngler){},
		AntiTorpedo = Class(TIFSmartCharge){},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNST1BATTLESHIP
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TSeaUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Spinner02', 'y', nil, 90, 0, 0))

		TSeaUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRNST1BATTLESHIP
