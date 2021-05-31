// void, Obj me

Unit this;
int nPoints, i;
Obj oShelter;
point pt;

this = me.AsUnit;

oShelter = .in_shelter;

if (oShelter.IsValid()) {
        //1. pick a passable point outside
        for (i=0; i < oShelter.radius + 50; i+=16) {
                pt.Set(oShelter.pos.x + i, oShelter.pos.y);
                if (IsPassable(pt)) break;
        }
        //2. 
        if (!IsPassable(pt)) {
                _pr("unit_exit_shelter: Error -- can't find passable point near shelter!");
                return;
        }
        pt = GetSummonPt(.class, pt, oShelter.radius + 200, 0);
        if (pt != Point(-1,-1) && IsPassable(pt)) {
                .SetBlockCommand(true);
                .GotoStraight(pt, false);
                .SetBlockCommand(false);
}
}
