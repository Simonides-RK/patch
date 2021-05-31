// void, Obj me

ParticleSystem this;
ObjList ol;
int count, i, splash_radius, dist, damage, damage_orig;
Obj o;
bool bDoSplash;

this = me.AsParticleSystem();
if(.proj_owner.IsDead())
{
        .Erase();
        return;
}

bDoSplash = true;
if (.proj_target.IsAlive()) bDoSplash=(.proj_target.flying != 1);
if(bDoSplash)
{
        splash_radius = .proj_owner.fire_splash_radius;
        damage_orig = .proj_owner.damage;
        Sleep(.proj_time);      
        
        ol = ObjsInCircle(.pos, splash_radius+250, "BaseGameObject", false).GetObjList();
        count = ol.count();
        for(i = 0; i < count; i += 1)
        {
                o = ol[i];
                if (o.IsAlive()) {
                        if (!.IsEnemy(o)) if (o!=.proj_target) if (o.AsBuilding.IsValid() || .flying==1)  continue;
                        dist = o.DistTo(.pos);
                        if (dist < splash_radius)
                        {
                                damage = CalculateSplash(damage_orig, dist, splash_radius);
                                o.Damage(.proj_owner, CalculateDamage(DamageExplosive, o, damage, o.armor), true);
                                CreateFeedback("data/particles/HitFeedback_Fire.part.xml", o, 3000, true);
                        }
                }
        }
}
else
{
                .Goto(.proj_target.pos, .proj_time, -160);
                damage = CalculateDamage(.proj_owner, .proj_target, .proj_owner.damage, .proj_target.armor);
                Sleep(.proj_time);
                if(.proj_target.IsAlive())
                        .proj_target.Damage(.proj_owner, damage, true);

}



.StopEmitters();
Sleep(.life_time);
.Erase();
