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

if(.on_crystal_tower == 1) {
	reason = GetNotificationText("Can't target on Crystal Tower!");
	return false;
}

if(objTarget.AsUnit().IsUncontrollable())
{
	reason = GetNotificationText("Cant control unit");
	return false;
}
if ( objTarget.AsUnit().ExistEffect("divine_journey") ) { 
	reason = Translate("[[110549761]]This Champion now in Divine Journey[[]]");
	return false;
}

return true;