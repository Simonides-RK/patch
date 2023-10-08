//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
if(!objTarget.IsValid) {
	reason = "";
	return false;
}

if( !objTarget.AsUnit().IsValid() ) {
	reason = GetNotificationText("unit target only");
	return false;
}

if ( objTarget.AsUnit().IsInvulnerable() ) {
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

if ( !.AsHero().CanBackstab(objTarget.AsUnit()) ) {
	reason = Translate("[[11060796]]Can't backstab this unit[[]]");
	return false;
}

if(.on_crystal_tower == 1) {
	reason = GetNotificationText("Can't target on Crystal Tower!");
	return false;
}

return true;