// void, Obj This

Building this;
point ptExit;
int d, speedup;

this = This.AsBuilding();

d = .cmddelay;
if ( IsUpgradeAvailable(.player, "upgrade_WeaponMarkets") ) {
	speedup = GetClassInt("Human_Townhall", "weaponmarket_speedup");
	d = d * (100 - speedup) / 100;
}

.Progress(d);

if (!.rally_object.IsValid)
{
	_pr("train.vs: This building ("+.class+") doesn't have a valid rally_object");
	return;
}

ptExit = .GetNearestEntityPoint(EntityPointSettlementSpecial1, .pos);

while (.special_visual_obj2.IsValid)
	Sleep(100); /// wait the natural built dragon to take off
if (.IsAlive)
{
	.special_visual_obj2 = Place(cmdparam + "_Exit", ptExit, this.player);
	.special_visual_obj2.dragon_townhall = this;
	.special_visual_obj2.natural_growth = 0;
	.special_visual_obj2.destroy_dragon_townhall = 0;
}
