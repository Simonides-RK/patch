//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Darkling_ApostleOfDeath", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) u.SetMaxHealth(u.GetMaxHealth() + u.afterlife_health_bonus);		
			//u.SetMaxHealth(u.GetMaxHealth() + 100);
}
