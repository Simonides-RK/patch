//void, Unit this

Unit u;
ObjList ul;
int i, count;

if (.IsAlive()) {
while (.ExistEffect("PaladinArmor")) {	
ul = Intersect(ObjsInCircle(.pos, .wrath_radius, "Unit", false), EnemyObjs(.player, "Unit", false)).GetObjList();
	
	
count = ul.count();
	for ( i = 0; i < count; i += 1 ) {
		u = ul[i].AsUnit();
		if (u.IsAlive()) {
			
			
				CreateFeedback("data/particles/Fire.part.xml", u.pos, 500);
				u.Damage(this, .wrath_damage, false); // indirect damage
				
				}
			}
		Sleep(1000);}
	}