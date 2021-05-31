// void, Obj me, Obj u

Unit this;

this = me.AsUnit();



if ( .modal_button == .mb_invisibility && !.IsEnemy(u) && u.AsUnit().IsValid() && .energy > .energy_to_cast_needed) 
{ 
        if(u.IsAlive())
        {
                if(!u.AsUnit.ExistEffect("invisible"))
                {

        if ( .DistTo(u) > 500  && .ShouldGotoForm(u.pos) ) {
                while ( !.GotoForm(u,150,1000,false) ) {
                        if ( !u.IsAlive() || .InRange(u) )      break;
                }}

                        .Face(u);
                        .PlayAnim(AnimAttack1);
                        if(u.IsAlive())
                        {
                                u.AsUnit.AddEffectTimeout("invisible", 0, 0, .invisible_time_effect);
                                .SetEnergy(.energy - .energy_to_cast_needed);
                                PlaySound(.pos, .invisibility_sound);
                        }
                }
        }

}



if(u.IsAlive() || u.AsBuilding.IsValid)
{
        if(.DistTo(u) > 500 && .ShouldGotoForm(u.pos))
        {
                while (!.GotoForm(u,150,1000,false))
                {
                        if(.EnemiesInSquad())
                        {
                                .AddCommand(true, "engage");
                                return;                         
                        }
                        if(!u.IsAlive() && !u.AsBuilding().IsValid())
                        {
                                break;
                        }
                        else
                        {
                                if(.InRange(u))
                                {
                                        break;
                                }
                        }
                }
        }

        while(.IsValidTarget(u))
        {
                if(.EnemiesInSquad())
                {
                        .AddCommand(true, "engage");
                        return;
                }
                if(.GotoAttack(u, 1000, true, 2000))
                {
                        break;
                }
        }
}

if (.CmdCount()==1)
        .AddCommand(true, "engage");
