----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT3DOOMSDAY : TLandUnit
BRNT3DOOMSDAY = Class(TLandUnit){
	Weapons = {
		rocket = Class(ACruiseMissileWeapon){
			FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
			FxMuzzleFlashScale = 2.2,
		},
		MissileRack01 = Class(TSAMLauncher){},
		DeathWeapon = Class(SCUDeathWeapon){},
		trigun01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 7.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		trigun02 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 7.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		trigun03 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 7.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		trigun04 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 7.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun02 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun03 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun04 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun05 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun06 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun07 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		sidegun08 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNT3DOOMSDAY
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT3DOOMSDAY
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT3DOOMSDAY
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT3DOOMSDAY
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT3DOOMSDAY
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks01', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks02', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks03', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks04', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02b'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks05', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks06', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks07', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'tracks08', army, v):ScaleEmitter(2.5))
		end
		for _, v in TMEffectTemplate['UEFDeath02a'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object53', army, v):ScaleEmitter(2.5))
		end
	end,
}

TypeClass = BRNT3DOOMSDAY
