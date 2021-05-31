// void, Obj me, Obj u

Unit this, shaman;
ObjList list;
int i;
bool bInitiallyVisible, bInitiallyEnemy, bNoMoreVisible;

//_pr("shaman::attack");
this = me.AsUnit();

if(!.IsValidTarget(u))
{
        .in_attack = -1;
        return;
}

if(.in_attack == 1)
{
        .in_attack = -1;
        // einitial unit visible/enemy flags    
        bInitiallyVisible = .initially_visible == 1;
        bInitiallyEnemy = .initially_enemy == 1;
        if(u.class=="Human_Shelter" || !.CanAttack(u) || (bInitiallyVisible && !u.GetVisible()) || (bInitiallyEnemy && !.IsEnemy(u)))
        {
                return;
        }
}
bInitiallyVisible = u.GetVisible();
bInitiallyEnemy = .IsEnemy(u);
// store these values for extraction when returning here after channel/vitalize/fatigue command
.initially_visible = bInitiallyVisible;
.initially_enemy = bInitiallyEnemy;

if(.DistTo(u) > 500  && .ShouldGotoForm(u.pos))
{
        while(!.GotoForm(u,150,1000,false))
        {
                if(!.IsValidTarget(u))
                {
                        break;
                }
                else if (.InRange(u))
                {
                        break;
                }
        }
}


while(.IsValidTarget(u))
{
        .attacking = 3;          if(.GotoAttack(u, 1000, true, 2000))
        {
                .unit_attacked = u;
                .attacking = 1;
                
                if(.modal_button == .mb_vitalize)
                {
                        if(.energy < .energy_vitalize || u.class=="Human_Shelter")
                        {
                                return;
                        }
                        if(u.class != "Forester_Shaman" && u.energy < u.GetMaxEnergy() && !IsFlagSet(u.user_flags1, u.to_be_vitalized))
                        {
                                .in_attack = 1;
                                .AddCommand(true, "attack", u);
                                .AddCommand(true, "vitalize", u);
                        }
                        return;                 
                }
                
                if(.modal_button == .mb_fatigue)
                {
                        if(.energy < .energy_fatigue || !.IsEnemy(u) ||u.class=="Human_Shelter")
                        {
                                return;
                        }
                        if(u.energy > .fatigue_damage / 3)
                        {
                                .in_attack = 1;
                                .AddCommand(true, "attack", u);
                                .AddCommand(true, "fatigue", u);
                        }
                        return;                 
                }
                
                if(.modal_button == .mb_channeling)
                {
                        while(.IsValidTarget(u))
                        {
                                list = Intersect(ObjsInRange(this, "Forester_Shaman", .GetRange(), true), FriendlyObjs(.player, "Forester_Shaman", true)).GetObjList();
                                for(i = list.count() - 1; i >= 0; i -= 1)
                                {
                                        shaman = list[i].AsUnit();
                                        if(shaman != this && shaman.attacking == 1 && (shaman.command == "attack" || shaman.command == "stand_position"))
                                        {
                                                if(.reserved_int0 == 1 || (.reserved_int0 == 0 && shaman.unit_attacked == u))
                                                {
                                                        if(.in_air == 1)
                                                        {
                                                                .in_air = 0;
                                                                .PlayAnim(24);          // don't use 20 because it's taunt anim used in move method
                                                        }
                                                        .in_attack = 1;
                                                        .AddCommand(true, "attack", u);
                                                        .AddCommand(true, "channel", shaman);
                                                        return;
                                                }
                                        }
                                }
                                //_pr("shaman::attack - channel receiving ...");
                                .Face(u);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .PlayAnim(AnimSpecial2);
                                .in_air = 1;
                                bNoMoreVisible = false;
                                if ( u.IsValid() ) {
                                        if ( bInitiallyVisible && !u.GetVisible() ) bNoMoreVisible = true;
                                }
                                if(!.CanAttack(u) || bNoMoreVisible || (bInitiallyEnemy && !.IsEnemy(u)))
                                {
                                        // shaman is ready to shoot but the target is not valid
                                        // pick up a new target
                                        //_pr("shaman::attack - searching for a new target while in air");
                                        u = .BestTargetInSquadSight();
                                        if(u.IsValid())
                                        {
                                                bInitiallyVisible = u.GetVisible();
                                                bInitiallyEnemy = .IsEnemy(u);
                                                if(!.CanAttack(u))
                                                {
                                                        // there's no valid target around - descend to the ground without shooting
                                                        .in_air = 0;
                                                        .PlayAnim(24);          // don't use 20 because it's taunt anim used in move method
                                                        return;
                                                }
                                        }
                                        else
                                        {
                                                return;
                                        }
                                }
                                .Face(u);
                                if(.GetRange() == .range1)
                                {
                                        .StartAnim(AnimSpecial3);
                                }
                                else if(.GetRange() == .range2)
                                {
                                        .StartAnim(AnimSpecial5);
                                }
                                else if(.GetRange() == .range3)
                                {
                                        .StartAnim(AnimSpecial4);
                                }
                                if(.GetAnim())
                                {
                                        Sleep(.TimeToActionMoment());
                                }
                                if(u.IsAlive)
                                {
                                        //_pr("shaman::attack - while channeled");
                                        if(!.CanAttack(u) || (bInitiallyVisible && !u.GetVisible()) || (bInitiallyEnemy && !.IsEnemy(u)))
                                        {
                                                // target became invalid while playing the attack animation
                                                // projectile should exit and go to the target but not doing damage
                                                //_pr("shaman::attack - projectile damage x0");
                                                .shamans_channeled = -1;
                                        }
                                        else
                                        {
                                                .shamans_channeled = .shamans_channeling;
                                        }
                                        if(.GetRange() == .range1)
                                        {
                                                .CreateProjectile(u, .projectile1, 30, 0);
                                        }
                                        else if(.GetRange() == .range2)
                                        {
                                                .CreateProjectile(u, .projectile2, 30, 0);
                                        }
                                        else if(.GetRange() == .range3)
                                        {
                                                .CreateProjectile(u, .projectile3, 30, 0);
                                        }
                                        .shaman_last_attack_time = GetTime();
                                        if(.GetAnim())
                                        {
                                                Sleep(.TimeToAnimFinish());
                                        }
                                }
                        }
                }       
        }
        else
        {
                if(.modal_button == .mb_channeling)
                {
                        list = Intersect(ObjsInRange(this, "Forester_Shaman", .GetRange(), true), FriendlyObjs(.player, "Forester_Shaman", true)).GetObjList();
                        for(i = list.count() - 1; i >= 0; i -= 1)
                        {
                                shaman = list[i].AsUnit();
                                if(shaman != this && shaman.attacking == 1 && (shaman.command == "attack" || shaman.command == "stand_position"))
                                {
                                        if(.reserved_int0 == 1 || (.reserved_int0 == 0 && shaman.unit_attacked == u))
                                        {
                                                if(.in_air == 1)
                                                {
                                                        .in_air = 0;
                                                        .PlayAnim(24);  // don't use 20 because it's taunt anim used in move method                                             
                                                }
                                                .in_attack = 1;
                                                .AddCommand(true, "attack", u);
                                                .AddCommand(true, "channel", shaman);
                                                return;
                                        }
                                }
                        }
                }
        }
}

.AddCommand(true, "engage");