// void, Obj This, point pt

ObjList olRuined;
int i;
str cmdcost;
int player;
Building this, dying;
int nTime, nDuration, nPercent;
int nHealth, nOldHealth;
Unit worker;
worker=This.AsUnit();
cmdcost="2000/60/0/4";
player=This.player;
this=This;
nDuration=5000;

if (GetCost(cmdcost, ResGold) > GetRes(player, ResGold)){
        UserNotification("not enough gold", "", Point(-1, -1), player);
        return;}
if (GetCost(cmdcost, ResGems) > GetRes(player, ResGems)){
        UserNotification("not enough gems", "", Point(-1, -1), player);
        return;}
if (GetCost(cmdcost, ResGlory) * ResGloryFactor > GetRes(player, ResGlory)){
        UserNotification("not enough glory", "", Point(-1, -1), player);
        return;}

while(!worker.Goto(pt, 150, 1500, false, -1));
        .Face(pt);
if (GetCost(cmdcost, ResGold) > GetRes(player, ResGold)){
        UserNotification("not enough gold", "", Point(-1, -1), player);
        return;}
if (GetCost(cmdcost, ResGems) > GetRes(player, ResGems)){
        UserNotification("not enough gems", "", Point(-1, -1), player);
        return;}
if (GetCost(cmdcost, ResGlory) * ResGloryFactor > GetRes(player, ResGlory)){
        UserNotification("not enough glory", "", Point(-1, -1), player);
        return;}


//wait 30 seconds

olRuined = ISRestoration(pt, This.player);
if (olRuined.count > 0) {
        Sleep(1); //wait for the constructors to be called
//.GotoStraight(, true);
this=olRuined[0];
//for (i=0; i < olRuined.count; i+=1) if (olRuined[i]!=this) olRuined[i].SetCommand("being_restored");
//while(!worker.Goto(.pos, .radius + 150, 1500, false, -1));
        worker.Face(.pos);
//        Sleep(1); //wait for the constructors to be called
        .being_restored_worker=worker;
        for (i=0; i < olRuined.count; i+=1) {
                olRuined[i].SetCommand("being_restored");
        }
DecRes(player, ResGold,         GetCost(cmdcost, ResGold   ));
DecRes(player, ResGems,         GetCost(cmdcost, ResGems   ));
DecRes(player, ResSupport,      GetCost(cmdcost, ResSupport));
DecRes(player, ResGlory,        GetCost(cmdcost, ResGlory) * ResGloryFactor);
//while (olRuined[0].command=="being_restored") Sleep(100);
} else 
        UserNotification("common", Translate("[[25167043]]Please select a point near a destroyed colony.[[]]"), Point(-1, -1), This.player);
