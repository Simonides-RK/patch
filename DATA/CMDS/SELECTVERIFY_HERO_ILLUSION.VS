//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
Hero h;


h = .AsHero();
if ( !h.IsAlive() ) {
	_pr("heal selectverify script called for a non-hero object!");
	return false;
}

// class-related checks
if ( h.class == "Forester_Stalker" ) {
	if ( (h.burrowed != 0) && (.DistTo(objTarget) > .sight) ) {
		reason = GetNotificationText("Target too far");
		return false;
	}
}

if ( h.class == "Human_WitchQueen" ) {
	if ( h.IsInAir() && (.DistTo(objTarget) > .sight) ) {
		reason = GetNotificationText("Target too far");
		return false;
	}
}

if ( h.class == "Human_WizardOfTheBow" ) {
	if ( (.on_crystal_tower == 1) && (.DistTo(objTarget) > .sight) ) {
		reason = GetNotificationText("Target too far");
		return false;
	}
}

if( !objTarget.IsAlive() ) {
	reason = "";
	return false;
}

if ( !objTarget.IsHeirOf("Unit") ) {
	reason = GetNotificationText("unit target only");
	return false;
}

if ( objTarget.AsUnit().IsInvulnerable() ) {
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