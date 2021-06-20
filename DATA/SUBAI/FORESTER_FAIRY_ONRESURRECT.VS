// void, Obj This

Hero this;

//_pr("witch queen: onresurrect");
this = This.AsHero();

if ( .IsSkillDeveloped("Mind_Blend") ) {
	.mind_blend_just_developed = 1;
	.has_mind_blend = 1;	
}

if ( .IsSkillDeveloped("Pain_Channeling") ) {
	.AddEffect("pain_channeling", .pain_channeling_percent, 0);
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