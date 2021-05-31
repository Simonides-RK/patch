//void, Obj this

//void, Obj this

Unit u;

u = .AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_Horse_Hunters"))
{
	u.SetSpeedFactor(u.speed_factor + u.hunter_bonus_speed);
	u.SetMaxHealth(u.maxhealth + u.hunter_bonus_health);
}
u.AddEffect("reinfspears", 0, 0);

