----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local CDFProtonCannonWeapon = WeaponsFile.CDFProtonCannonWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local CDFParticleCannonWeapon = WeaponsFile.CDFParticleCannonWeapon

-- upvalues for performance
local CreateRotator = CreateRotator
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT2MEDM : CWalkingLandUnit
BRMT2MEDM = Class(CWalkingLandUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun = Class(CDFParticleCannonWeapon){},
		ParticleGun1 = Class(CDFProtonCannonWeapon){},
		ParticleGun2 = Class(CDFProtonCannonWeapon){},
		lefthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.4 },
		righthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.4 },
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
	},

	---@param self BRMT2MEDM
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object13', 'z', nil, -690, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Object14', 'z', nil, 690, 0, 0))
		self:CreateTheEffects()
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2MEDM
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRMT2MEDM
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRMT2MEDM
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT2MEDM
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(3.10))
		end
	end,

	---@param self BRMT2MEDM
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath02'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(0.8))
		end
	end,
}

TypeClass = BRMT2MEDM
