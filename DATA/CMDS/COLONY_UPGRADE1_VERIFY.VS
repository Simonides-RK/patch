// bool, ObjList objs, int player, str cmdcost, str OUT disabled_reason_text, str rollover

int gold, gems, support, glory, req_count;
Building this;
bool bHuman, bDarkling, bForester;
str result, requirements;
str strValue;
str strDisabled;
str strStatus;

this = objs[0].AsBuilding;

disabled_reason_text = " ";
strDisabled = disabled_reason_text + "\n" + Translate(rollover);
strStatus = "upgrade_" + cmdid;

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

if (IsUpgradeAvailable(player, "upgrade_HumanLevel1") || 
    IsUpgradeAvailable(player, "upgrade_ForesterLevel1") || 
    IsUpgradeAvailable(player, "upgrade_DarklingLevel1"))
	return true;

gold = GetCost(cmdcost, ResGold);
gems = GetCost(cmdcost, ResGems);
support = GetCost(cmdcost, ResSupport);
glory = GetCost(cmdcost, ResGlory) * ResGloryFactor;

result = "";

if (gold)
	if (gold > GetRes(player, ResGold))
		result = result + "<imagetransp assets/interface/resview/gold_ico.bmp><color 255 64 64>" + gold + "<color 255 255 255>" + " ";
	else
		result = result + "<imagetransp assets/interface/resview/gold_ico.bmp>" + gold + " ";

if (gems)
	if (gems > GetRes(player, ResGems))
		result = result + "<imagetransp assets/interface/resview/gems_ico.bmp><color 255 64 64>" + gems + "<color 255 255 255>" + " ";
	else
		result = result + "<imagetransp assets/interface/resview/gems_ico.bmp>" + gems + " ";

if (support)
	if (support > GetRes(player, ResSupport))
		result = result + "<imagetransp assets/interface/resview/sup_ico.bmp><color 255 64 64>" + support + "<color 255 255 255>" + " ";
	else
		result = result + "<imagetransp assets/interface/resview/sup_ico.bmp>" + support + " ";

if (glory)
	if (glory > GetRes(player, ResGlory))
		result = result + "<imagetransp assets/interface/resview/glory_ico.bmp><color 255 64 64>" + glory / ResGloryFactor + "<color 255 255 255>" + " ";
	else
		result = result + "<imagetransp assets/interface/resview/glory_ico.bmp>" + glory / ResGloryFactor + " ";

bHuman = ClassPlayerObjs(cHuman_Townhall, player, false).count > 0;
bDarkling = ClassPlayerObjs(cDarkling_Townhall, player, false).count > 0;
bForester = ClassPlayerObjs(cForester_Townhall, player, false).count > 0;

if (!bHuman && !bDarkling && !bForester)
	{
		bHuman = true;
		bDarkling = true;
		bForester = true;
	}

requirements = "";	
if (bHuman && !IsUpgradeAvailable(player, "upgrade_HumanLevel1"))
	{
		requirements = requirements + Translate("[[10753070]]\n  - [[]]") + GetCommandDisplayName("upgrade_HumanLevel1") + "\n     " + Translatef("[[10766546]](upgrade at %s1)[[]]", GetClassDisplayName("Human_Townhall", false));
		req_count += 1;
	}
if (bForester && !IsUpgradeAvailable(player, "upgrade_ForesterLevel1"))
	{
		requirements = requirements + Translate("[[10753070]]\n  - [[]]") + GetCommandDisplayName("upgrade_ForesterLevel1") + "\n     " + Translatef("[[10766546]](upgrade at %s1)[[]]", GetClassDisplayName("Forester_Townhall", false));
		req_count += 1;
	}
if (bDarkling && !IsUpgradeAvailable(player, "upgrade_DarklingLevel1"))
	{
		requirements = requirements + Translate("[[10753070]]\n  - [[]]") + GetCommandDisplayName("upgrade_DarklingLevel1") + "\n     " + Translatef("[[10766546]](upgrade at %s1)[[]]", GetClassDisplayName("Darkling_Townhall", false));
		req_count += 1;
	}

if (req_count == 1)
  requirements = Translate("[[10774316]]Requires:[[]]") + requirements;
else if (req_count > 1)
	requirements = Translate("[[10787889]]Requires one of the following:[[]]") + requirements;

requirements = "<color 255 64 64>" + requirements;
disabled_reason_text = Translate(rollover) + "\n\n" + requirements;

return false;