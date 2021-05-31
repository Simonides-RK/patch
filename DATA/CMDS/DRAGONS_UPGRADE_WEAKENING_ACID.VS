//void, int player


ObjList dl;
int i;
Building d;

//Independent Upgrades Health Boosts:


dl = ClassPlayerObjs("Dragons_Townhall", player, true).GetObjList;

for (i = dl.count - 1; i >= 0; i -= 1)
{
	d = dl[i].AsBuilding();

d.SetMaxHealth(d.maxhealth + d.health_bonus_upg1);

	if(IsUpgradeAvailable(player, "upgrade_Burning_Wings"))
	{d.SetMaxHealth(d.maxhealth + d.health_bonus_upg1 + d.health_bonus_upg2);}

}
