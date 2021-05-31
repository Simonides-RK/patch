//void, Obj this

Unit u;

u = this.AsUnit();
	
if (IsUpgradeAvailable(.player, "upgrade_GoldenShield"))  u.AddEffect("goldenshield_swordsmans", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) u.AddEffect("spiritual_blessing_effect", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_Swordsman_Stamina"))
{
        u.SetSpeedFactor(u.speed_factor + GetClassInt("Human_Swordsman", "stamina_speed_bonus"));
        u.SetAttackSpeedFactor(u.attack_speed_factor + GetClassInt("Human_Swordsman", "stamina_attackspeed_bonus"));
}


u.SetDisableRangedAttack(true);
.SetRange(GetClassInt("Unit", "range"));