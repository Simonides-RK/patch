// void, Obj this

Unit u;
u = this.AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_Weaken"))
{
	u.armor += GetClassInt("Human_Witch", "weaken_armor_bonus");
	u.SetMaxHealth(u.GetMaxHealth() + u.weaken_health_bonus);
}

if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) u.AddEffect("spiritual_blessing_effect", 0, 0);
