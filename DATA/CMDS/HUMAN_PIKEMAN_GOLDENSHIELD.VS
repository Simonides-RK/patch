//void, int player

ObjList ol;
int i;
Unit u;
//Query q;

//q = ClassPlayerObjs("Human_Pikeman", player, false);
ol=ClassPlayerObjs("Human_Pikeman", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){u = ol[i].AsUnit(); if ( u.IsAlive() ) u.AddEffect("goldenshield", 0, 0);}



