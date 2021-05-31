// void, Obj this
int d, s;
Unit u;

d = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_damage"); 
s = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_attackspeed"); 
u = this.AsUnit();

u.SetEnergy(0);
.SetEnergyRegenerationRate(0);
if (IsUpgradeAvailable(.player, "upgrade_berserk"))
{
	u.armor += GetClassInt("Darkling_Fanatic", "berserk_armor_bonus");
	u.SetMaxHealth(u.GetMaxHealth() + .berserk_health_bonus);
}        

if (IsUpgradeAvailable(.player, "upgrade_HellRaisedWeapons")) 
{
	u.damage = u.damage + u.initial_damage * d / 100;
	u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
}