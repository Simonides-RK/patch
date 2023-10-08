// void, Obj This

Building this;
int i;
Unit newunit;
point ptExit;
str cmd;
int new_mana;

this = This.fake_queuer_townhall.AsBuilding();

cmd = "Spring_Of_Life";
new_mana = .GetMana(cmd) - .GetManaCost(cmd);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}

.SetMana(cmd, new_mana);


FocusObject(this);
for(i = 0; i < .spring_of_life_archers + .spring_of_life_horseman; i += 1)
{
	if(.rally_object.IsValid())
	{
		ptExit = .GetExitPoint(.rally_object.pos);
		if(i < .spring_of_life_archers)
		{
			newunit = Place("Elves_Archer", ptExit, .player);
		}
		else
		{
			newunit = Place("Elves_HorseArcher", ptExit, .player);
		}
		newunit.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), true);
		IncResNoLimit(.player, ResSupport, GetCost(newunit.cost, ResSupport)); // Because the unit will take it back in its 'init' script
		Sleep(5);
		SetFlag(newunit.user_flags1, newunit.dont_return_population, true);		
		Sleep(5);		
	} 
	else
	{
		_pr("spring_of_live: This building ("+.class+") doesn't have a valid rally_object");
	}
}

