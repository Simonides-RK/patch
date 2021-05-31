// void, Obj this

int unit_level, SupportCost, chance;

if (.dragon_townhall.IsValid)
{
        Unit dragon;
        Obj objRally;
        
        objRally = .dragon_townhall.rally_object;

        .PlayAnim(AnimSpecial1, .pos);

        .SetHidden(true);
        if (.natural_growth == 1)
                dragon = Place("Dragons_GreenDragon", .pos + Point(233, 351), .player);
        else
                dragon = BuildUnit("Dragons_GreenDragon", .pos + Point(233, 351), .player);
        dragon.independent_glory = .dragon_exit_glory;
        IncResNoLimit(.player, ResSupport, GetCost(dragon.cost, ResSupport)); // Because the unit will take it back in its 'init' script
        dragon.Face(dragon.pos + Point(100, 0));

        SupportCost = GetCost(dragon.cost, ResSupport);
        dragon.SetNoRandomItemFlag(false); 
        
        if (.natural_growth == 1)
        {
                point target_point;
                str group_name;
                group_name = "independent_at_" + .dragon_townhall.pos.x + "_" + .dragon_townhall.pos.y;
                dragon.AddToGroup(group_name);
                dragon.SetUncontrollableFlag(true);
                Sleep(1);
                SetFlag(dragon.user_flags1, dragon.dont_return_population, true);
                dragon.AsUnit.SetIndependentGuardian(true);
                
                target_point = RandomPoint(.dragon_townhall.pos, 500, 5);
                dragon.SetCommand("advance", target_point);
        }
        else
                if (objRally.IsValid)
                        dragon.ExecDefaultCmd(objRally.pos, objRally.GetRallyTargetObj(), false);
                        
        Sleep(0);
                        
        if (.destroy_dragon_townhall == 1)
        {       /// the townhall is waiting the dragon to take off before collapse
                if (.dragon_townhall.special_visual_obj2 == this)
                {
                        Obj dummy;
                        .dragon_townhall.special_visual_obj2 = dummy;
                }
                .dragon_townhall.DropDead;
        }
}
.Erase;
