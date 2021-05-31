//void, int player

ObjList ol;
int i;
Unit u;

ol=ClassPlayerObjs("Forester_Hunter", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1){
u = ol[i].AsUnit(); 
        if ( u.IsAlive() ) {
				u.armor += GetClassInt("Forester_Hunter", "moonguard_armor_bonus");
				u.SetMaxHealth(u.GetMaxHealth() + u.moonguard_health_bonus);	
        }
}
