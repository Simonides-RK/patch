//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Darkling_Fanatic", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) {
				u.armor += GetClassInt("Darkling_Fanatic", "berserk_armor_bonus");
				u.SetMaxHealth(u.GetMaxHealth() + u.berserk_health_bonus);				
							}
} 