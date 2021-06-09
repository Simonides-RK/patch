//void, int player

ObjList ol;
Unit u;
int i;

ol = ClassPlayerObjs("Unit", player, true).GetObjList();

for ( i = 0; i < ol.count; i += 1 ) {
	u = ol[i].AsUnit();
	
	if ( !u.IsPlayableRace && !u.IsIndependentGuardian() ) {
		u.AddEffect("strength_of_the_forest", 0, 0);
	}
}
