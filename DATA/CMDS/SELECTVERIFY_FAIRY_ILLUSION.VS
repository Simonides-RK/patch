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

if ( objTarget.AsUnit().IsInvulnerable() || objTarget.AsUnit().class=="Darkling_SoulWatcher" || objTarget.AsUnit().class=="Forester_GrayWolf" || objTarget.AsUnit().class=="Forester_WhiteWolf") {
        reason = GetNotificationText("Invalid target");
        return false;
}

if (.IsEnemy(objTarget)) {
        reason = GetNotificationText("Friendly target only");
        return false;
}

if ( objTarget.IsHeirOf("Hero") ) {
        reason = GetNotificationText("Can't apply illusion on heroes");
        return false;
}

if ( objTarget.AsUnit().ExistEffect("illusion") ) {
        reason = GetNotificationText("Illusion already applied");
        return false;
}

if ( objTarget.AsUnit().legendary == 1 ) {
        reason = Translate("[[11006394]]Can't apply illusion on legendary unit[[]]");
        return false;
}

if ( objTarget.IsHeirOf("BaseWorker") ) {
        reason = Translate("[[11015771]]Can't apply illusion on workers[[]]");
        return false;
}


return true;