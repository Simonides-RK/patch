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

if ( objTarget.AsUnit().legendary == 1 ) {
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.AsUnit().IsInvulnerable() ) {
        reason = GetNotificationText("Invalid target");
        return false;
}

//if ( objTarget.AsUnit().ExistEffect("dichotimize") || objTarget.AsUnit().ExistEffect("resurected")) {
//        reason = GetNotificationText("Invalid target");
//       return false;
//}

if ( objTarget.AsUnit().IsUncontrollable() && !objTarget.AsUnit().IsIndependentGuardian() ) {
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.can_be_selected == 0 ) {
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.class == "Darkling_SoulWatcher" ) {      // note: probably should reject all peaceful units
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.class == "Darkling_GoldSpirit" ) {      // note: probably should reject all peaceful units
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.class == "Darkling_Spirit" ) {      // note: probably should reject all peaceful units
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.class == "Darkling_DarkMage" ) {      // note: probably should reject all peaceful units
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.class == "Darkling_ApostleOfDeathGhost" ) { // particular problems with that class, it shouldn't be dichotomized anyways
        reason = GetNotificationText("Invalid target");
        return false;
}

if ( objTarget.IsHeirOf("Hero") ) {
        reason = GetNotificationText("unit target only");
        return false;
}


return true;