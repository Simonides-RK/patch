//void, int player

ObjList ol;
ObjList  nl;
int i;
Building n;

ol = ClassPlayerObjs("Nomad_Cavalry", player, true).GetObjList;

for (i = ol.count - 1; i >= 0; i -= 1)
{
	ol[i].armor += GetClassInt("Nomad_Cavalry", "plunder_armor");
}

nl = ClassPlayerObjs("Nomad_Townhall", player, true).GetObjList;

for (i = nl.count - 1; i >= 0; i -= 1)
{
	n = nl[i].AsBuilding();
	
n.SetMaxHealth(n.maxhealth + n.health_bonus_upg2);

	if(IsUpgradeAvailable(player, "upgrade_Horse_Hunters"))
	{n.SetMaxHealth(n.maxhealth + n.health_bonus_upg1 + n.health_bonus_upg2);}

}
