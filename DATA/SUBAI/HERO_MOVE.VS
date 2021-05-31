// void, Obj This, point pt
Hero this;
int nLen, i;
point tmpPt, ptVector;

this = This.AsHero();

if (!IsPassable(.pos)){
ptVector=.pos-pt; nLen = ptVector.Len();
        for (i=10; i<=nLen; i+=10){
                ptVector.SetLen(i);
                tmpPt=PassablePointNear(.pos-ptVector, 80, 3, true);
                if(tmpPt.x != -1 && tmpPt.y != -1) {.GotoStraight(tmpPt, true); break;}}}
//.pr("hero::move");


for (i=0; i<.commanded_army.count; i+=1)
        .commanded_army[i].SetCommand("move", pt);

while (!.ShouldGotoForm(pt))
        if(.Goto(pt, 0, 2000, true, 2500))
                return;         
        
while (!.GotoForm(pt, 0, 2000, true));
