//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Unit this;
str dest, specname;
int gold, gems, support, glory;
int i;


disabled_reason_text = "";
if ( !IsUpgradeAvailable(player, "upgrade_Smash_Roll") ) return false;


this = objs[0].AsUnit();


if (.energy < .smash_roll_energy) {
	disabled_reason_text = Translate("[[smash_energy]]Not enough energy to smash roll.[[]]");
	return false;
}

return true;