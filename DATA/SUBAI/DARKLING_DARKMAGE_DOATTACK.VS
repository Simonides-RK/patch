// void, Obj me, Obj enemy

Unit u;

u = enemy.AsUnit();
if(u.IsAlive())
{
        PlaySound(me.pos, GetClassStr("Darkling_DarkMage", "mind_twist_sound"));
        u.AddEffectTimeout("mind_twist", GetClassInt("Darkling_DarkMage", "mind_twist_multiplyer"), GetClassInt("Darkling_DarkMage", "mind_twist_damage"), GetClassInt("Darkling_DarkMage", "mind_twist_timeout"));
        me.SetEnergy(me.energy - me.mind_twist_energy);
}
