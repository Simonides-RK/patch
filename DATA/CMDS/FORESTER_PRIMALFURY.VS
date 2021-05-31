//void, int player

ObjList ol;
Unit u;
int i;

ol = ClassPlayerObjs("Unit", player, false).GetObjList();

for ( i = 0; i < ol.count; i += 1 ) {
	u = ol[i].AsUnit();
	if ( !u.IsAlive() ) continue;
	if ( u.race == Race_Foresters && u.class != "Forester_QueenOfTheWolves" && u.class != "Forester_Sharpshooter" && u.class != "Forester_Stalker" && u.class != "Forester_Fairy" && u.class != "Forester_Worker") {	
		u.AddEffect("primal_fury", 0, 0);
	}
}
