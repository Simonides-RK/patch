// void, Obj This

Unit newunit;
Building this;
point ptExit;

this = This.fake_queuer_townhall.AsBuilding();

if(.GetMana(cmdid) < .GetManaCost(cmdid))
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

if(.IsRecharging(cmdid))
{
        .SetRecharging(cmdid, false);
        .SetMana(cmdid, 0);
}

if(.rally_object.IsValid())
{
        ptExit = .GetExitPoint(.rally_object.pos);
        newunit = BuildUnit(cmdparam, ptExit, this.player);
        FocusObject(newunit);
        newunit.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), true);
        IncRes(.player, ResSupport, GetCost(newunit.cost, ResSupport)); // Because the unit will take it back in its 'init' script
        .legendary_unit = newunit;
        Sleep(0);
        if(newunit.HasCommand("spawn"))
        {
                newunit.InsertCommand("spawn");
        }
        ClearSelection(.player);
        .legendary_unit.Select(.player);
        
} else {
        _pr("train.vs: This building ("+.class+") doesn't have a valid rally_object");
}

.is_legendary_training = 0;

