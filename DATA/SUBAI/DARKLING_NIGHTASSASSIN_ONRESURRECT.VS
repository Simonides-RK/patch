// void, Obj This

Hero this;

//_pr("witch queen: onresurrect");
this = This.AsHero();

if ( .IsSkillAvailable("Cloud_of_Darkness") ) {
	// raising the "justdev" flag caused calling "oninside" twice and thus setting the invisibility flag (ref counted) twice
	.cloudofdarkness_available = 1;
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