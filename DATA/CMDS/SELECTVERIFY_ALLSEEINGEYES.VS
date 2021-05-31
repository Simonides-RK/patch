//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
Unit u;

if( !objTarget.IsAlive() ) {
        reason = "";
        return false;
}

u = objTarget.AsUnit;
if ( !objTarget.IsHeirOf("Unit") || !u.IsValid ) {
        reason = GetNotificationText("unit target only");
        return false;
}

if (.IsEnemy(objTarget)) {
        reason = GetNotificationText("Friendly target only");
        return false;
}


if ( u.ExistEffect(GetFromStr(cmdparam, "EffectName")) ) {
        reason = GetNotificationText("Invalid target");
        return false;
}

if (.DistTo(objTarget) > .sight) {
        reason = GetNotificationText("out of range");
        return false;
}

if ( u.ExistEffect("divine_journey") ) { 
	reason = Translate("[[110549761]]This Champion now in Divine Journey[[]]");
	return false;
}


return true;