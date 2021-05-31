//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
ObjList ol;
Hero h;

h = .AsHero();
if(!objTarget.IsValid) {
	reason = "";
	return false;
}
if( !objTarget.AsBuilding().IsValid() ) {
	reason = GetNotificationText("building target only");
	return false;
}

if ( h.IsInAir() && .pos.Dist(objTarget.pos) > .sight + objTarget.radius ) {
	reason = GetNotificationText("Target too far");
	return false;
}

if ( !.IsEnemy(objTarget) ) {
	reason = GetNotificationText("enemy target only");
	return false;
}

ol = ObjsInCircle(objTarget.pos, objTarget.radius, "BuildingHauntDummy", true).GetObjList();

if ( ol.count > 0 ) {
	reason = Translate("[[11027479]]Building already haunted.[[]]");
	return false;
}

return true;