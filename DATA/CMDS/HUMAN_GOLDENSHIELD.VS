//void, int player

ObjList ol;
int i;
Unit u;
//Query q;

//q = ClassPlayerObjs("Human_Pikeman", player, false);
ol=ClassPlayerObjs("Human_Swordsman", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){u = ol[i].AsUnit(); if ( u.IsAlive() ) u.AddEffect("goldenshield_swordsmans", 0, 0);}
ol=ClassPlayerObjs("Human_Paladin", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){u = ol[i].AsUnit(); if ( u.IsAlive() ) u.AddEffect("goldenshield_swordsmans", 0, 0);}
ol=ClassPlayerObjs("Human_Cavalry", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){u = ol[i].AsUnit(); if ( u.IsAlive() ) u.AddEffect("goldenshield_swordsmans", 0, 0);}
ol=ClassPlayerObjs("Human_HeavyCavalry", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){u = ol[i].AsUnit(); if ( u.IsAlive() ) u.AddEffect("goldenshield_swordsmans", 0, 0);}