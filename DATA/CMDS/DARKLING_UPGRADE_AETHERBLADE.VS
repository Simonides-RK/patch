//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Darkling_ApostleOfDeath", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) { 
        //u.armor+=2;
        //u.SetMaxHealth(u.GetMaxHealth() + 60);
		u.armor += GetClassInt("Darkling_ApostleOfDeath", "aether_blade_armor_bonus");
		u.SetMaxHealth(u.GetMaxHealth() + u.aether_blade_health_bonus);			
        }
}
