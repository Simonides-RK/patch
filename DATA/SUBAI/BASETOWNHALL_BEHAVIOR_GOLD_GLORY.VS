// void, Obj This

int delay, glory_delay, gold;
int last_glory_increase;
Obj this;
ObjList ol;
int gold_mine_count, i;

delay = GetConst("TownhallGoldDelay");
glory_delay = GetConst("TownhallGloryDelay");

this = This;
if (.gold_production==-1)
        .gold_production = GetConst("TownhallGoldAmount");
if (.glory_production==-1)
        .glory_production = ResGloryFactor / 10;

while (1) {
        Sleep(delay);
        
        gold = .gold_production;
        if (.class=="Human_Townhall"){
                ol = ClassPlayerObjs("Human_GoldMine", .player, false).GetObjList();
                if (ol.count>1) {
                gold_mine_count=0;
                 for ( i = 0; i < ol.count; i += 1 ) {
                        if (ol[i].IsBuilt()) gold_mine_count += 1;
                 }
     if (gold_mine_count==2) gold = gold + 10;
else if (gold_mine_count>2) gold = gold + 15;
                  
                        
                }
        }
        if (gold > 0)
        {
                IncRes(This.player, ResGold, gold);
                FloatingText(Translate("[[]]+[[]]") + gold, This.pos, GetConst("GoldResColor"), This.player);
        }

        last_glory_increase = EnvReadInt(This.player, "last_glory_increase");
        if(GetTime - last_glory_increase >= glory_delay)
        {
                IncRes(This.player, ResGlory, .glory_production);
                EnvWriteInt(This.player, "last_glory_increase", GetTime);
        }
}

