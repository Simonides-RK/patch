// void, Obj this, ObjList ol

int i;
Unit u;
int damage;
if(GetTime() > .time_placed + .caltrop_duration)
{
        if(.command != "selfdestroy")
        {
                .SetCommand("selfdestroy");
        }
}
for(i = ol.count() - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if(u.IsAlive())
        {
        if (u.flying==1) continue;
		if (u.ExistEffect("divine_journey")) continue;  
        if (u.class=="Human_WitchQueen" ) if (u.IsInAir()) continue;
        if (u.class=="Forester_Shaman") if (u.in_air==1) continue;

                damage = CalculateDirectDamage(this, u, .caltrop_damage);
                FloatingText(Translate("[[]]-[[]]") + damage, u.pos, GetConst("CriticalDamageColor"), 0);
                u.DamageWithNoAttacker(damage);
        }
}
