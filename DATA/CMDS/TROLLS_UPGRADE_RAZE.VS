//void, int player

ObjList ol;
ObjList tl;
int i;
Building t;

ol = ClassPlayerObjs("Trolls_MountainTroll", player, true).GetObjList;

for (i = ol.count - 1; i >= 0; i -= 1)
{
	ol[i].armor += GetClassInt("Trolls_MountainTroll", "raze_armor");
}

tl = ClassPlayerObjs("Trolls_Settlement", player, true).GetObjList;

for (i = tl.count - 1; i >= 0; i -= 1)
{
	t = tl[i].AsBuilding();

t.SetMaxHealth(t.maxhealth + t.health_bonus_upg2);

	if(IsUpgradeAvailable(player, "upgrade_Smash_Roll"))
	{t.SetMaxHealth(t.maxhealth + t.health_bonus_upg1 + t.health_bonus_upg2);}

}

