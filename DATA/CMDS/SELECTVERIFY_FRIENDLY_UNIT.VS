//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;

if( !objTarget.IsAlive() ) {
	reason = "";
	return false;
}

if ( !objTarget.IsHeirOf("Unit") ) {
	reason = GetNotificationText("unit target only");
	return false;
}

if (.IsEnemy(objTarget)) {
	reason = GetNotificationText("Friendly target only");
	return false;
}
if ( objTarget.AsUnit().ExistEffect("divine_journey") ) { 
	reason = Translate("[[110549761]]This Champion now in Divine Journey[[]]");
	return false;
}

return true;