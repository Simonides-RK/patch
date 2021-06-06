// void, Obj this

Building b;

b = .AsBuilding();
if ( !b.IsAlive() ) return;

b.DamageWithNoAttacker(1000000);