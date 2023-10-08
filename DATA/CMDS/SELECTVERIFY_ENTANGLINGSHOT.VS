//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;

if( !objTarget.IsValid() ) {
	reason = "";
	return false;
}

if ( !objTarget.AsUnit().IsValid() ) {
	reason = GetNotificationText("unit target only");
	return false;
}

if ( objTarget.AsUnit().IsInvulnerable() ) {
	reason = GetNotificationText("Invalid target");
	return false;
}

if ( objTarget.class == "Forester_Overlord" || objTarget.class == "Forester_StalkerPlant" ) {
	reason = GetNotificationText("Invalid target");
	return false;
}

if ( !.IsEnemy(objTarget) ) {
	reason = GetNotificationText("enemy target only");
	return false;
}

if ( !objTarget.IsRevealed(.player) ) {
	reason = Translate("[[10982986]]Can't target invisible units[[]]");
	return false;
}

if ( objTarget.AsUnit().flying != 0 ) {
	reason = Translate("[[10997219]]Can't target flying units[[]]");
	return false;
}

if(objTarget.on_crystal_tower == 1) {
	reason = GetNotificationText("Can't target on Crystal Tower!");
	return false;
}

return true;