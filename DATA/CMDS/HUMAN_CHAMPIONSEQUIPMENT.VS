//void, int player

ObjList ol;
int i;
Hero h;

ol = ClassPlayerObjs("Hero", player, false).GetObjList();


for ( i = 0; i < ol.count; i += 1) {
    h = ol[i].AsHero();
   h.AddEffect("get_champion_item",0,0);
   h.got_champion_item = 1;
}
