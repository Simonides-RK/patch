// void, Obj This

Hero this;

this = This.AsHero();

if(.restore_sight_on_ressurect == 1)
{
	.restore_sight_on_ressurect = 0;
	.SetSight(.GetSight() - .crystal_tower_range_inc);
}

if(.in_shelter.IsAlive())
{
	.SetCommand("engage"); //as if it's entangled
}

if ( IsUpgradeAvailable(.player, "upgrade_ChampionsEquipment") ) {

if (!.ExistEffect("get_champion_item") && .got_champion_item != 1)
	{
	.AddEffect("get_champion_item",0,0);
	.got_champion_item = 1;
	}
}