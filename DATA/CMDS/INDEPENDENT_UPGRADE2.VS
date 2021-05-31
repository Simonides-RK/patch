//void, int player


ObjList el, nl, sl, dl, tl;
int i;
Building e, n, s, d, t;

//Independent Upgrades Health Boosts:

el = ClassPlayerObjs("Elves_Settlement", player, true).GetObjList;

for (i = el.count - 1; i >= 0; i -= 1)
{
    e = el[i].AsBuilding();




if(IsUpgradeAvailable(player, "upgrade_Elven_Encouragement"))
{e.SetMaxHealth(e.maxhealth + e.health_bonus_upg2);}

if(IsUpgradeAvailable(player, "upgrade_Elven_Unity") && IsUpgradeAvailable(player, "upgrade_Elven_Encouragement"))
{e.SetMaxHealth(e.maxhealth + e.health_bonus_upg1 + e.health_bonus_upg2);}

}

nl = ClassPlayerObjs("Nomad_Townhall", player, true).GetObjList;

for (i = nl.count - 1; i >= 0; i -= 1)
{
	n = nl[i].AsBuilding();

if(IsUpgradeAvailable(player, "upgrade_Plundering"))
{n.SetMaxHealth(n.maxhealth + n.health_bonus_upg2);}

if(IsUpgradeAvailable(player, "upgrade_Horse_Hunters") && IsUpgradeAvailable(player, "upgrade_Plundering"))
{n.SetMaxHealth(n.maxhealth + n.health_bonus_upg1 + n.health_bonus_upg2);}

}

sl = ClassPlayerObjs("Shades_Settlement", player, true).GetObjList;

for (i = sl.count - 1; i >= 0; i -= 1)
{
	s = sl[i].AsBuilding();

if(IsUpgradeAvailable(player, "upgrade_bottle_o_fog"))
{s.SetMaxHealth(b.maxhealth + s.health_bonus_upg2);}

if(IsUpgradeAvailable(player, "upgrade_Shades_champpoison") && IsUpgradeAvailable(player, "upgrade_bottle_o_fog"))
{s.SetMaxHealth(s.maxhealth + s.health_bonus_upg1 + s.health_bonus_upg2);}

}

dl = ClassPlayerObjs("Dragons_Townhall", player, true).GetObjList;

for (i = dl.count - 1; i >= 0; i -= 1)
{
	d = dl[i].AsBuilding();

if(IsUpgradeAvailable(player, "upgrade_Burning_Wings"))
{d.SetMaxHealth(b.maxhealth + d.health_bonus_upg2);}

if(IsUpgradeAvailable(player, "upgrade_Weakening_Acid") && IsUpgradeAvailable(player, "upgrade_Burning_Wings"))
{d.SetMaxHealth(d.maxhealth + d.health_bonus_upg1 + d.health_bonus_upg2);}

}

tl = ClassPlayerObjs("Trolls_Settlement", player, true).GetObjList;

for (i = tl.count - 1; i >= 0; i -= 1)
{
	t = tl[i].AsBuilding();

if(IsUpgradeAvailable(player, "upgrade_Raze"))
{t.SetMaxHealth(t.maxhealth + t.health_bonus_upg2);}

if(IsUpgradeAvailable(player, "upgrade_Smash_Roll") && IsUpgradeAvailable(player, "upgrade_Raze"))
{t.SetMaxHealth(t.maxhealth + t.health_bonus_upg1 + t.health_bonus_upg2);}

}

