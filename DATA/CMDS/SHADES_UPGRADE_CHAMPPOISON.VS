//void, int player


ObjList sl;
int i;
Building s;

//Independent Upgrades Health Boosts:

sl = ClassPlayerObjs("Shades_Settlement", player, true).GetObjList;

for (i = sl.count - 1; i >= 0; i -= 1)
{
	s = sl[i].AsBuilding();

s.SetMaxHealth(s.maxhealth + s.health_bonus_upg1);

	if(IsUpgradeAvailable(player, "upgrade_bottle_o_fog"))
	{s.SetMaxHealth(s.maxhealth + s.health_bonus_upg1 + s.health_bonus_upg2);}

}


