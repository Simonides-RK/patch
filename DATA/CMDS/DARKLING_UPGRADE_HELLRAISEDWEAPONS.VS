//void, int player

ObjList ol;
int i, d, s;
Unit u;

d = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_damage"); 
s = GetClassInt("Darkling_Townhall", "hellraisedweapons_bonus_attackspeed"); 

ol = ClassPlayerObjs("Darkling_Fanatic", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() )
		{
			u.damage = u.damage + u.initial_damage * d / 100;
			u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
		}
}

ol = ClassPlayerObjs("Darkling_DarkRider", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) 
		{
			u.damage = u.damage + u.initial_damage * d / 100; 
			u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
		}
}


ol = ClassPlayerObjs("Darkling_ApostleOfDeath", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) 
		{
			u.damage = u.damage + u.initial_damage * d / 100; 
			u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
		}
}

ol = ClassPlayerObjs("Darkling_Disciple", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) 
		{
			u.damage = u.damage + u.initial_damage * d / 100; 
			u.SetAttackSpeedFactor(u.attack_speed_factor + u.attack_speed_factor * s / 100);
		}
}

