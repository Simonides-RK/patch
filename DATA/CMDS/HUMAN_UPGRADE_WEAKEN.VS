//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Human_Witch", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) 
        {
				u.armor += GetClassInt("Human_Witch", "weaken_armor_bonus");
				u.SetMaxHealth(u.GetMaxHealth() + u.weaken_health_bonus);
        }
}

ol = ClassPlayerObjs("Human_Prophet", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) 
        {
				u.armor += GetClassInt("Human_Prophet", "weaken_armor_bonus");
				u.SetMaxHealth(u.GetMaxHealth() + u.weaken_health_bonus);				
        }
}
