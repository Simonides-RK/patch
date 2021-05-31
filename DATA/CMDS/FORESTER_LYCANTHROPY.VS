//void, int player

ObjList ol;
int i;
Unit u;
ol = ClassPlayerObjs("Forester_WolfMaster", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if (u.IsAlive())  {
        u.SetMaxHealth(u.GetMaxHealth()*115/100);
        u.AddEffect("Lycanthropy",1,15);
        }
}


ol = ClassPlayerObjs("Forester_Werewolf", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() && u.werewolf_state == 2) {
        u.SetMaxHealth(u.GetMaxHealth()*115/100);
        u.AddEffect("Lycanthropy",1,15);
        }

}

/*
ol = ClassPlayerObjs("Forester_QueenOfTheWolves", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if (u.IsAlive() && u.queen_state == 2)  {
        u.reserved_int9=u.GetMaxHealth()*15/100;
        u.SetMaxHealth(u.GetMaxHealth()*115/100);
        u.AddEffect("Lycanthropy",1,15);
        }
}
*/


