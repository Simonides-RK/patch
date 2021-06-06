//void, int player

ObjList ol;
ObjList dl;
int i;
Building d;

//Independent Upgrades Health Boosts:

ol = ClassPlayerObjs("Dragons_GreenDragon", player, true).GetObjList;

for (i = ol.count - 1; i >= 0; i -= 1)
{
	u = ol[i].AsUnit();
	
	u.SetMaxHealth(u.GetMaxHealth() + u.weakening_bonus_health);
	u.armor += GetClassInt("Dragons_GreenDragon", "weakening_bonus_armor");
	
}


dl = ClassPlayerObjs("Dragons_Townhall", player, true).GetObjList;

for (i = dl.count - 1; i >= 0; i -= 1)
{
	d = dl[i].AsBuilding();

d.SetMaxHealth(d.maxhealth + d.health_bonus_upg1);

	if(IsUpgradeAvailable(player, "upgrade_Burning_Wings"))
	{d.SetMaxHealth(d.maxhealth + d.health_bonus_upg1 + d.health_bonus_upg2);}

}
