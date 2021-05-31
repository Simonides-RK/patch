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
//	if ( .townhall_upgradelevel != 2 ) {
	if ( EnvReadInt(.player, "TownhallUpgrades/" + .race_str) != 2 ) {
		strDisabled = "";
		return false;
	}
	
	//if ((.CmdCount() < 2) && (.command == "idle"))
	if (!.HasUpgradeInQueue())
	{
		strValue = EnvReadString( this, "upgrade_status" );
		if (strValue == "in progress") {
			//this could not happen, because the method we are executing is 'idle'
			disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10734537]]An upgrade is currently in progress.[[]]");
			return false;
		}
		strValue = EnvReadString( .player, strStatus );
		if (strValue == "in progress") {
			disabled_reason_text = strDisabled + "<color 255 255 64>\n\n" + Translate("[[11150411]]This upgrade is already in progress in another location[[]]");
			return false;
		}
		if (strValue == "available") {
			disabled_reason_text = strDisabled + "<color 255 255 64>\n\n" + Translate("[[10728005]]This upgrade is currently available.[[]]");
			return false;
		}
		if (strValue == "disabled") {
			return false;
		}
		if (.is_haunted == 1)  {
			disabled_reason_text = Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
			return false;
		}
		return true;
	}
	else
	{
		disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10743998]]Queue not empty[[]]");
	}
}
return false;
