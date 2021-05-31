// void, Obj This, point pt

Obj target;
Unit this;
int range, nGold, nGems;
ObjList ol;
point ptNow;

this = This.AsUnit;

ptNow = .pos;
range = GetClassInt("Nomad_Townhall", "plunder_area");
while ( !.Goto(pt, range, 1000, false, 2000) );

ol = Intersect(Substract(ObjsInCircle(pt, range, "Building", false), ObjsInCircle(pt, range, "BaseIndependentHouse", false)), EnemyObjs(.player, "Building", false)).GetObjList();

while ( ol.count > 0 ) {
	target = .BestTargetInRangeIgnoring(pt, range, "BaseWorker");
	if ( !target.IsValid() )
		{
		while (!.Goto(pt, 300, 1000, false, 2000));
		target = .BestTargetInRangeIgnoring(pt, 300, "BaseWorker");
		if ( !target.IsValid() )
			{
			target = ol[rand(ol.count)].AsBuilding;
			}
			if ( !target.IsValid() ) {break;}
		}
	while ( !.GotoAttack(target, 1000, true, 2000) );
	while ( .Attack(target, false) );
	Sleep(150);
	ol.ClearDead();
}

.plundering = 0;
//_pr("plunder: end");