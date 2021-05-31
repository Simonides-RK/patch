// void, Obj This, ObjList ol

int i;
Unit u;
Building this;
this=This.AsBuilding;
for( i = 0;
 i < ol.count;
 i += 1 ) {
        u = ol[i].AsUnit();
         if ( u.IsAlive() ) {
                if ( u.ExistEffect("unit_in_shelter") ) {
                        u.RemoveEffect("unit_in_shelter", 0, 0);

                }
        }
}
