//void, Obj this

Unit u;

u = this.AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_ForesterMoon"))
{
			u.armor += GetClassInt("Forester_Hunter", "moonguard_armor_bonus");
			u.SetMaxHealth(u.GetMaxHealth() + .moonguard_health_bonus);
}
