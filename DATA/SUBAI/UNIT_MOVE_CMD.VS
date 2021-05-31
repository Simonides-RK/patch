// void, Obj This, point pt

Unit this;
int time_started;
bool bThere;


int nLen, i;
point tmpPt, ptVector;

this = This.AsUnit();
time_started = GetTime();

if (!IsPassable(.pos)) if (.flying!=1){
ptVector=.pos-pt; nLen = ptVector.Len();
        for (i=10; i<=nLen; i+=10){
                ptVector.SetLen(i);
                tmpPt=PassablePointNear(.pos-ptVector, 80, 3, true);
                if(tmpPt.x != -1 && tmpPt.y != -1) {.GotoStraight(tmpPt, true); break;}}}


bThere = false;
while (!.ShouldGotoForm(pt))
        if(.Goto(pt, 0, 2000, true, 2500))
                { bThere = true; break; }
        
if (!bThere)
        while (!.GotoForm(pt, 0, 2000, true));

if(.CmdCount()==1)
        if(.TimeWithoutAttack() < .stand_pos_didntattack && GetTime() - time_started < .stand_pos_didntmove)
        {
                .stand_pos_end_time = GetTime() + .stand_pos_duration;
                .AddCommand(true, "stand_position");
                return;
        }
