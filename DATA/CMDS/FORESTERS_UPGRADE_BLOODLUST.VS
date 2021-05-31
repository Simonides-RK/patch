//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Forester_WolfMaster", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor/4);
}
