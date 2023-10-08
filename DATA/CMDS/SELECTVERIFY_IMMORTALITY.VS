//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
Hero h;

if( !objTarget.IsAlive() ) {
	reason = "";
	return false;
}

if (.IsEnemy(objTarget)) {
	reason = GetNotificationText("Friendly target only");
	return false;
}

h  = objTarget.AsHero();

if ( !h.IsValid() ) {
	reason = Translate("[[11041976]]Only friendly Champions can be targeted[[]]");
	return false;
}

if(.on_crystal_tower == 1) {
	reason = GetNotificationText("Can't target on Crystal Tower!");
	return false;
}

if ( h.ExistEffect("immortal") ) {
	reason = Translate("[[11054976]]This Champion already has Immortality[[]]");
	return false;
}

if ( h.ExistEffect("divine_journey") ) { 
	reason = Translate("[[110549761]]This Champion now in Divine Journey[[]]");
	return false;
}

return true;