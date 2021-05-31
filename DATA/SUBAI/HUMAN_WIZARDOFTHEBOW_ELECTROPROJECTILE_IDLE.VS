// void, Obj me

Unit u;

u = me.proj_target;
if(!u.IsValid())
{
        me.Erase();
        return;
}

Sleep(me.proj_time);

if(me.proj_owner.IsAlive() && u.IsAlive())
{       
if (u.AsHero.IsValid()) 
{u.Damage(me.proj_owner, me.proj_owner.electrostatic_damage*60/100, false);
//FloatingText(Translate("[[]]-[[]]")  + me.proj_owner.electrostatic_damage*60/100, u.pos, 0xCC3366, 0);
}
else        
{u.Damage(me.proj_owner, me.proj_owner.electrostatic_damage, false);
//FloatingText(Translate("[[]]-[[]]") + me.proj_owner.electrostatic_damage, u.pos, 0xCC3366, 0);
}
        if ( (u.user_flags1 & u.cant_be_stunned) == 0 ) {
                u.SetCommand("stun");
        }
}

me.Erase();