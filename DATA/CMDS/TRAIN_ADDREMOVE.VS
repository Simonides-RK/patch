// bool, Obj this, str cmdcost, bool bAdd

int player;

player = .player;

if (bAdd)
	{
		if(.CmdCount >= 6)
		{
			UserNotification("build queue is full", "", Point(-1, -1), player);
			return false;
		}
		if (GetCost(cmdcost, ResGold) > GetRes(player, ResGold))
			{
				UserNotification("not enough gold", "", Point(-1, -1), player);
				return false;
			}
		if (GetCost(cmdcost, ResGems) > GetRes(player, ResGems))
			{
				UserNotification("not enough gems", "", Point(-1, -1), player);
				return false;
			}
		if (GetCost(cmdcost, ResSupport) != 0 && GetCost(cmdcost, ResSupport) > GetRes(player, ResSupport))
			{
				UserNotificationRace("not enough houses", "", Point(-1, -1), player);
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
	}
else
	{
		IncRes(player, ResGold,		GetCost(cmdcost, ResGold   ));
		IncRes(player, ResGems,		GetCost(cmdcost, ResGems   ));
		IncRes(player, ResSupport,	GetCost(cmdcost, ResSupport));
		IncRes(player, ResGlory,	GetCost(cmdcost, ResGlory) * ResGloryFactor);

	}

return true;
