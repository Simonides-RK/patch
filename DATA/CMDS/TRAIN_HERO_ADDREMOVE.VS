// bool, Obj this, str cmdcost, bool bAdd

int player;
bool is_alive;
int heroes;
ObjList ol;

is_alive = false;

player = .player;

if (bAdd)
	{
		ol = ClassPlayerObjs(cmdparam, .player, true).GetObjList();
		if ( ol.count > 0 ) is_alive = true;
		
		heroes = EnvReadInt(.player, "training_heroes");
		if(.player_hero1.IsValid())
		{
			heroes += 1;
			if(.player_hero1.class == cmdparam)
				 is_alive = true;
		}
		if(.player_hero2.IsValid())
		{
			heroes += 1;
			if(.player_hero2.class == cmdparam)
				 is_alive = true;
		}
		if(.player_hero3.IsValid())
		{
			heroes += 1;
			if(.player_hero3.class == cmdparam)
				 is_alive = true;
		}
		if(heroes >= 3)
		{
			UserNotification("there can be only one hero", Translate("[[11127360]]You can have no more than three Champions[[]]"), Point(-1, -1), .player);
			return false;
		}
		if(is_alive || EnvReadInt(.player, cmdparam+"_TrainNow") == 1)
		{
			UserNotification("there can be only one hero", Translate("[[11135072]]There can be only one Champion of this type.[[]]"), Point(-1, -1), .player);
			return false;
		}
		if(.CmdCount > 6)
		{
			UserNotification("build queue is full", "", Point(-1, -1), player);
			return false;
		}
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
		if (GetCost(cmdcost, ResGlory) * ResGloryFactor > GetRes(player, ResGlory))
		{
			UserNotification("not enough glory", "", Point(-1, -1), player);
			return false;
		}
		if (.is_haunted == 1)
			{
				UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), player);
				return false;
			}

		DecRes(player, ResGold,		GetCost(cmdcost, ResGold   ));
		DecRes(player, ResGems,		GetCost(cmdcost, ResGems   ));
		DecRes(player, ResSupport,	GetCost(cmdcost, ResSupport));
		DecRes(player, ResGlory,	GetCost(cmdcost, ResGlory) * ResGloryFactor);
		EnvWriteInt(.player, cmdparam+"_TrainNow", 1);
		EnvWriteInt(.player, "training_heroes", EnvReadInt(.player, "training_heroes") + 1);
	}
else
	{
		IncRes(player, ResGold,		GetCost(cmdcost, ResGold   ));
		IncRes(player, ResGems,		GetCost(cmdcost, ResGems   ));
		IncRes(player, ResSupport,	GetCost(cmdcost, ResSupport));
		IncRes(player, ResGlory,	GetCost(cmdcost, ResGlory) * ResGloryFactor);
		EnvWriteInt(.player, cmdparam+"_TrainNow", 0);
		EnvWriteInt(.player, "training_heroes", EnvReadInt(.player, "training_heroes") - 1);
	}

return true;
