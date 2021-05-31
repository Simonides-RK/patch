//void, int player

ObjList ol;
ObjList bl;
int i;
Unit u;
Building b;

ol = ClassPlayerObjs("Nomad_Spearman", player, true).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
    u = ol[i].AsUnit();
	u.SetSpeedFactor(u.speed_factor + u.hunter_bonus_speed);
	u.SetMaxHealth(u.maxhealth + u.hunter_bonus_health);
}

bl = ClassPlayerObjs("Nomad_Townhall", player, true).GetObjList();

for (i = bl.count - 1; i >= 0; i -= 1)
{
    b = bl[i].AsBuilding();
	b.SetMaxHealth(b.maxhealth + b.health_bonus_upg1);
	if(IsUpgradeAvailable(player, "upgrade_Plundering"))
{b.SetMaxHealth(b.maxhealth + b.health_bonus_upg1 + b.health_bonus_upg2);}
}