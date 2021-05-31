//void, Obj this

Query qUnits;
ObjList ol;
int i;
Obj o;

qUnits = FriendlyObjsInRange(this, "Unit", .radius + 80, false);

ol = qUnits.GetObjList();

for (i=0; i < ol.count; i+=1) {
        o = ol[i];
        if (o.in_shelter == this) {
        o.SetCommand("exit_shelter");

       }
}
