//void, int player

ObjList ol;
int i;
Unit u;
ol = Union(ClassPlayerObjs("Human_Cavalry", player, true), ClassPlayerObjs("Human_HeavyCavalry", player, true)).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
    u = ol[i].AsUnit();
        u.SetSpeedFactor(u.speed_factor + u.adv_armor_speed_bonus);
        u.SetMaxHealth(u.GetMaxHealth() + u.adv_armor_health_bonus);
}

/* ypsilon: no buffs for windrider! 


ol = ClassPlayerObjs("Human_WindRider", player, true).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
    u = ol[i];

        u.SetSpeedFactor(u.speed_factor + u.adv_armor_speed_bonus);
        u.SetMaxHealth(u.GetMaxHealth() + u.adv_armor_health_bonus);
}


*/