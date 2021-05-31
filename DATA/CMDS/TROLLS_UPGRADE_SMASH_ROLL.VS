//void, int player


ObjList tl;
int i;
Building t;

//Independent Upgrades Health Boosts:

tl = ClassPlayerObjs("Trolls_Settlement", player, true).GetObjList;

for (i = tl.count - 1; i >= 0; i -= 1)
{
	t = tl[i].AsBuilding();

t.SetMaxHealth(t.maxhealth + t.health_bonus_upg1);

	if(IsUpgradeAvailable(player, "upgrade_Raze"))
	{t.SetMaxHealth(t.maxhealth + t.health_bonus_upg1 + t.health_bonus_upg2);}

}

