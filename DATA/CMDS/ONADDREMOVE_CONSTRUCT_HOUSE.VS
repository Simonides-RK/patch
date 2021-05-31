// bool, Obj this, Obj target, point pt, str cmdcost, bool bAdd

int player, built;
Building bdNew;
Query q;

player = .player;

if (pt.x == -1 || pt.y == -1) {
	_pr("onaddremove_construct_default: use only when constructing buildings!");
	return false;
}

if (bAdd) {
		if (!IsPassableToPlaceByMovingUnits(cmdparam, pt, .player))
			return false;
		if (GetCost(cmdcost, ResGold) > GetRes(player, ResGold))
			{
				UserNotification("not enough gold", "", Point(-1, -1), .player);
				return false;
			}
		if (GetCost(cmdcost, ResGems) > GetRes(player, ResGems))
			{
				UserNotification("not enough gems", "", Point(-1, -1), .player);
				return false;
			}
		if (GetCost(cmdcost, ResSupport) != 0 && GetCost(cmdcost, ResSupport) > GetRes(player, ResSupport))
			{
				UserNotificationRace("not enough houses", "", Point(-1, -1), .player);
				return false;
			}
		if (.is_haunted == 1)
			{
				UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), player);
				return false;
			}

		DecRes(player, ResGold,    GetCost(cmdcost, ResGold));
		DecRes(player, ResGems,    GetCost(cmdcost, ResGems));
		DecRes(player, ResSupport, GetCost(cmdcost, ResSupport));
		DecRes(player, ResGlory,   GetCost(cmdcost, ResGlory) * ResGloryFactor);

		// Place the building
		bdNew = PlacePassableBuilding(cmdparam, pt, player);
		bdNew.DamageWithNoAttacker(bdNew.maxhealth*9/10);
		bdNew.townhall = this.fake_queuer_townhall;
		bdNew.SetBuilt(false);
		//bdNew.SetHidden(true);
		bdNew.SetTranslucency(0);
//		bdNew.SetCmdEnable(false);
		bdNew.SetCommand("waiting_to_be_built");  //don't play idle
		bdNew.glory_cost = GetCost(cmdcost, ResGlory) * ResGloryFactor;

} else {

	// Find the placed building and remove it
	q = ObjsInCircle(pt, 5, cmdparam, true);
	if (q.IsEmpty) {
		_pr("onaddremove_construct_default: Could not find the building placed when the command was added");
	} else {
		bdNew = q.GetObjList()[0].AsBuilding();
		bdNew.Erase();
	}

	IncRes(player, ResGold,  GetCost(cmdcost, ResGold));
	IncRes(player, ResGems,  GetCost(cmdcost, ResGems));
	IncRes(player, ResSupport, GetCost(cmdcost, ResSupport));
	IncRes(player, ResGlory, .glory_cost);
}

return true;
