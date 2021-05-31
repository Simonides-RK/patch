//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Unit this;
str dest, specname;
int gold, gems, support, glory;
int i;

// should be avaiable only if single wolf master is selected and he has at least one wolf alive

disabled_reason_text = "";
if ( !IsUpgradeAvailable(player, "upgrade_WolfScout") ) return false;

//_pr("wolf scout: verify");
if ( objs.count > 1 ) return false; // no need to send multiple wolves at same location

this = objs[0].AsUnit();

if ( .scout_charges == 0 ) {
	disabled_reason_text = Translate("[[10843157]]Can't send more wolf scouts.[[]]");
	return false;
}

if (.energy < .scout_wolf_energy_cost) {
	disabled_reason_text = Translate("[[scout_energy]]Not enough energy to send wolf scout.[[]]");
	return false;
}

if ( .wm_wolf1.IsValid() )
	if ( .wm_wolf1.IsAlive() ) return true;

if ( .wm_wolf2.IsValid() )
	if ( .wm_wolf2.IsAlive() ) return true;

if ( .wm_wolf3.IsValid() )
	if ( .wm_wolf3.IsAlive() ) return true;

if ( .wm_wolf4.IsValid() )
	if ( .wm_wolf4.IsAlive() ) return true;

disabled_reason_text = Translate("[[10851383]]There are currently no wolves to send scouting.[[]]");

return false;