// bool, Obj this, Obj target, point pt, str cmdcost, bool bAdd

int player;
Unit u;

player = .player;
u = target.AsUnit;
if(!u.IsValid)
{
	UserNotification("unit target only", "", Point(-1, -1), .player);
	return false;
}
if(u.IsEnemy(this))
{
	UserNotification("friendly target only", "", Point(-1, -1), .player);
	return false;
}
if (this.DistTo(target)>this.sight)
{
	UserNotification("common", Translate("[[10954322]]The target unit is too far[[]]"), Point(-1, -1), .player);
	return false;
}

if(u.ExistEffect(GetFromStr(cmdparam, "EffectName")))
if(Str2Int(GetFromStr(cmdparam, "EffectTimeout")) == 0)
{
	UserNotification("common", Translate("[[10967106]]This unit is already enchanted[[]]"), Point(-1, -1), .player);
	return false;
}

if (bAdd)
	{
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
		if (.IsHeirOf("Building"))
			{
			if (.is_haunted == 1)
				{
				UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), player);
				return false;
				}
			}
			
		DecRes(player, ResGold,		GetCost(cmdcost, ResGold   ));
		DecRes(player, ResGems,		GetCost(cmdcost, ResGems   ));
		DecRes(player, ResSupport,	GetCost(cmdcost, ResSupport));
		DecRes(player, ResGlory,	GetCost(cmdcost, ResGlory));
	}
else
	{
		IncRes(player, ResGold,		GetCost(cmdcost, ResGold   ));
		IncRes(player, ResGems,		GetCost(cmdcost, ResGems   ));
		IncRes(player, ResSupport,	GetCost(cmdcost, ResSupport));
		IncRes(player, ResGlory,	GetCost(cmdcost, ResGlory));
	}

return true;
