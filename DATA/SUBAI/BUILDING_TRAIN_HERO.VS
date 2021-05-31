// void, Obj This
// void, Obj This

Unit newunit;
Building this;
point ptExit;
Hero h;
int i, j, slot, slot_count, max_slots, cost;
int cost_min, cost_delta;
str strSlotType;

this = This.AsBuilding();

.Progress();

if(.rally_object.IsValid) {
	ptExit = .GetExitPoint(.rally_object.pos);
	newunit = BuildUnit(cmdparam, ptExit, this.player);
	newunit.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), true);
	IncRes(.player, ResSupport, GetCost(newunit.cost, ResSupport)); // Because the unit will take it back in its 'init' script

	if(!.player_hero1.IsValid)	
		.player_hero1 = newunit;
	else
	if(!.player_hero2.IsValid)	
		.player_hero2 = newunit;
	else
	if(!.player_hero3.IsValid)	
		.player_hero3 = newunit;

	EnvWriteInt(.player, cmdparam+"_TrainNow", 0);
	EnvWriteInt(.player, "training_heroes", EnvReadInt(.player, "training_heroes") - 1);
	
	if ( IsUpgradeAvailable(.player, "upgrade_ChampionsEquipment") ) {
		h = newunit.AsHero();
		h.AddEffect("get_champion_item",0,0);
		h.got_champion_item = 1;
	}

	if(newunit.HasCommand("spawn"))
	{
		newunit.InsertCommand("spawn");
	}
} else {
	_pr("train.vs: This building ("+.class+") doesn't have a valid rally_object");
}
