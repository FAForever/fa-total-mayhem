----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFPlasmaCannonWeaponD = WeaponsFile.TDFPlasmaCannonWeapon
local TANTorpedoLandWeapon = WeaponsFile.TANTorpedoLandWeapon
local TSAMLauncher = WeaponsFile.TSAMLauncher

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT3ADVBTBOT : CWalkingLandUnit
BRNT3ADVBTBOT = Class(CWalkingLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.7 },
		Turret01 = Class(TANTorpedoLandWeapon){},
		MainGun2 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 5.0,
			FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
		},
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MissileRack01 = Class(TSAMLauncher){},
		Gatlingg = Class(TDFPlasmaCannonWeaponD){ IdleState = State(TDFPlasmaCannonWeaponD.IdleState){
			Main = function(self)
				TDFPlasmaCannonWeaponD.IdleState.Main(self)
			end,
			OnGotTarget = function(self)
				if not self.SpinManip01 then
					self.SpinManip01 = CreateRotator(self.unit, 'Object18', 'z', nil, 250, 250, 250)
					self.unit.Trash:Add(self.SpinManip01)
					self.SpinManip01:SetTargetSpeed(850)
				end
				if not self.SpinManip02 then
					self.SpinManip02 = CreateRotator(self.unit, 'Object17', 'z', nil, 250, 250, 250)
					self.unit.Trash:Add(self.SpinManip02)
					self.SpinManip02:SetTargetSpeed(-850)
				end
				TDFPlasmaCannonWeaponD.OnGotTarget(self)
			end,
			OnFire = function(self)
				TDFPlasmaCannonWeaponD.IdleState.OnFire(self)
				if self.SpinManip01 then
					self.SpinManip01:SetTargetSpeed(850)
				end
				if self.SpinManip02 then
					self.SpinManip02:SetTargetSpeed(-850)
				end
			end,
			OnLostTarget = function(self)
				if self.SpinManip01 then
					self.SpinManip01:SetTargetSpeed(0)
				end
				if self.SpinManip02 then
					self.SpinManip02:SetTargetSpeed(0)
				end
				TDFPlasmaCannonWeaponD.OnLostTarget(self)
			end,
		} },
	},

	---@param self BRNT3ADVBTBOT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT3ADVBTBOT
	---@param transport Unit
	---@param bone Bone
	OnDetachedFromTransport = function(self, transport, bone)
		CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT3ADVBTBOT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT3ADVBTBOT
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT3ADVBTBOT
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for k, v in TMEffectTemplate['UEFDeath03'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.7))
		end
	end,
}

TypeClass = BRNT3ADVBTBOT
