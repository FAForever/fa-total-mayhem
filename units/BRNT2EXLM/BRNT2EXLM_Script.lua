----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local SWeapons = import('/lua/seraphimweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local SDFSinnuntheWeapon = SWeapons.SDFSinnuntheWeapon

-- upvalue for performance


---@class BRNT2EXLM : TWalkingLandUnit
BRNT2EXLM = Class(TWalkingLandUnit){
	Weapons = {
		autogauss3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.05 },
		autogauss2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.05 },
		autogauss1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.05 },
		biggun = Class(SDFSinnuntheWeapon){
			FxMuzzleFlash = TMEffectTemplate.BRNT2EXLMmuzzle,
			FxMuzzleFlashScale = 8.05,
		},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		DeathWeapon = Class(SCUDeathWeapon){},
		smallerguns = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.4,
			FxMuzzleFlash = EffectTemplate.OhCannonMuzzleFlash02,
		},
	},

	---@param self BRNT2EXLM
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXLM
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT2EXLM
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,
}

TypeClass = BRNT2EXLM
