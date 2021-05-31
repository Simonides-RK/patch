//void, int player

ObjList ol;
int i;
Unit u;

// u.armor += GetClassInt("Darkling_", "unholy_armor_bonus");   <-- template

ol = ClassPlayerObjs("Darkling_Cannoneer", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) u.armor += GetClassInt("Darkling_Cannoneer", "unholy_armor_bonus");
}

ol = ClassPlayerObjs("Darkling_DarkRider", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) u.armor += GetClassInt("Darkling_DarkRider", "unholy_armor_bonus");
}

ol = ClassPlayerObjs("Darkling_DarkMage", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) u.armor += GetClassInt("Darkling_DarkMage", "unholy_armor_bonus");
}