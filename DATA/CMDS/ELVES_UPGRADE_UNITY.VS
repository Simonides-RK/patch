//void, int player


ObjList el;
int i;
Building e;

//Independent Upgrades Health Boosts:

el = ClassPlayerObjs("Elves_Settlement", player, true).GetObjList;

for (i = el.count - 1; i >= 0; i -= 1)
{
    e = el[i].AsBuilding();





e.SetMaxHealth(e.maxhealth + e.health_bonus_upg1);

	if(IsUpgradeAvailable(player, "upgrade_Elven_Encouragement"))
	{e.SetMaxHealth(e.maxhealth + e.health_bonus_upg1 + e.health_bonus_upg2);}

}

