//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
point pt;
Unit u;
ObjList ol;

pt = ptTarget;
if(!pt.InRect(GetMapRect()))
{
	reason = GetNotificationText("out of map");
	return false;
}

u = .AsUnit();
ol = Intersect(ObjsInCircle(ptTarget, u.smash_roll_radius, "Unit", false), EnemyObjs(u.player, "Unit", false)).GetObjList();
if ( ol.count == 0 ) {
	reason = Translate("[[11071220]]No enemy units in area.[[]]");
	return false;
}

return true;