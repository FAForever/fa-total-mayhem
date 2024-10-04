--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UAA0203/UAA0203_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Gunship Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AeonWeapons = import('/lua/aeonweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon

-- upvalue local functions
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BROAT1EXGS : AAirUnit
BROAT1EXGS = Class(AAirUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
		rocket3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
		rocket4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
		AntiAirMissiles01 = Class(AAAZealotMissileWeapon){},
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},
		},
	},

	---@param self BROAT1EXGS
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		AAirUnit.OnStopBeingBuilt(self, builder, layer)

		self:CreateTheEffects()

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BROAT1EXGS
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['AResourceGenAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROAT1EXGS', army, v):ScaleEmitter(0.5))
		end
		for _, v in EffectTemplate['AResourceGenAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['AResourceGenAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy05', army, v):ScaleEmitter(0.3))
		end
	end,

	---@param self BROAT1EXGS
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		AAirUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self any
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonBattleShipHit01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROAT1EXGS', army, v):ScaleEmitter(1.65))
		end
	end,
}

TypeClass = BROAT1EXGS
