//void, Obj this
int d, s;
Unit u;

d = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_damage"); 
s = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_attackspeed"); 
u = this.AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_UnholyStrength")) u.armor += GetClassInt("Darkling_DarkRider", "unholy_armor_bonus");

if (IsUpgradeAvailable(.player, "upgrade_Nightweb")) u.SetMaxHealth(u.GetMaxHealth() + u.nightweb_health_bonus);
if (IsUpgradeAvailable(.player, "upgrade_HellRaisedWeapons")) 
{
	u.damage = u.damage + u.initial_damage * d / 100;
	u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
}