//void, Obj this
int d, s;
Unit u;

d = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_damage"); 
s = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_attackspeed"); 
u = this.AsUnit();

.SetVisible(false);
u.AddEffect("hatred", .hatred_add_damage, -1);
if (IsUpgradeAvailable(.player, "upgrade_Afterlife")) .SetMaxHealth(.GetMaxHealth() + .afterlife_health_bonus);
if (IsUpgradeAvailable(.player, "upgrade_AetherBlade")) {
		.armor += GetClassInt("Darkling_ApostleOfDeath", "aether_blade_armor_bonus");
		.SetMaxHealth(.GetMaxHealth() + .aether_blade_health_bonus);
		
}
if (IsUpgradeAvailable(.player, "upgrade_HellRaisedWeapons")) 
{
	u.damage = u.damage + u.initial_damage * d / 100;
	u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
}