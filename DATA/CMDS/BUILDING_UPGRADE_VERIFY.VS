//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Building this;
str strValue;
str strDisabled;
str strStatus;

this = objs[0].AsBuilding;

//strDisabled = disabled_reason_text + "\n" + Translate(rollover);
strDisabled = disabled_reason_text + "\n" + rollover;
strStatus = "upgrade_" + cmdid;

if (.IsAlive)
{
	//if (.CmdCount < 2 && .command == "idle")
	if (!.HasUpgradeInQueue())
	{
		if (!ObjsInCircle(.pos, .radius, "BuildingUpgradeProgress", true).IsEmpty)
		{
			disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10734537]]An upgrade is currently in progress.[[]]");
		} else
		{
			
			if (!.building_upgrade.IsValid)
				return true;
			if (.is_haunted == 1)
			{
				UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), player);
				return false;
			}
				
			if (.building_upgrade.IsHeirOf("BuildingUpgrade"))
				disabled_reason_text = strDisabled + "<color 255 255 64>\n\n" + Translate("[[10728005]]This upgrade is currently available.[[]]");
			else
				disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10734537]]An upgrade is currently in progress.[[]]");
			
		}
	}
	else
	{
		disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10743998]]Queue not empty[[]]");
	}
}
return false;
