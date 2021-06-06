// void, Obj This, point pt

Unit this;
int nLen, i;
point tmpPt, ptVector;


this = This.AsUnit();


if (!IsPassable(.pos)) if (.flying!=1){
ptVector=.pos-pt; nLen = ptVector.Len();
        for (i=10; i<=nLen; i+=10){
                ptVector.SetLen(i);
                tmpPt=PassablePointNear(.pos-ptVector, 80, 3, true);
                if(tmpPt.x != -1 && tmpPt.y != -1) {.GotoStraight(tmpPt, true); break;}}}

while (!.ShouldGotoForm(pt))
        if(.Goto(pt, 0, 2000, true, 2500))
                return;         
        
while (!.GotoForm(pt, 0, 2000, true));
