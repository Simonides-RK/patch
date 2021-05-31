//void, Obj This

Building this;
Obj oStatue;
Unit newunit;
Query q;
point ptStatue;

this = This.fake_queuer_townhall.AsBuilding();

if(.GetMana(cmdid) < .GetManaCost(cmdid))
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

ptStatue = .GetEntityPointByIndex(EntityPointSettlementSpecial3, 0);

q = ObjsInCircle(ptStatue, 10, "Trolls_Upgrade_Statue", true);
oStatue = q.GetObjList()[0];
if (!oStatue.IsValid) {
        _pr("trolls, train Earthshaker:  There is no sp... oops, statue!");
        return;
}

if(.IsRecharging(cmdid))
{
        .SetRecharging(cmdid, false);
        .SetMana(cmdid, 0);
}

FocusObject(oStatue);
oStatue.PlayAnim(AnimSpecial1);
oStatue.SetTranslucency(0);

if(.rally_object.IsValid())
{       
        newunit = BuildUnit(cmdparam, ptStatue, this.player);   
        newunit.Face(newunit.pos + Point(50,50));
        newunit.SetInvulnerable(true);
        newunit.SetCommand("move_straight", newunit.pos + Point(50,50));
        Sleep(1000); // Actually calculated - 72 pixels distance w/ 70 speed
        newunit.SetInvulnerable(false);
        
        newunit.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), false);
        IncRes(.player, ResSupport, GetCost(newunit.cost, ResSupport)); // Because the unit will take it back in its 'init' script
        .legendary_unit = newunit;
        ClearSelection(.player);
        .legendary_unit.Select(.player);        

} else {
        _pr("train.vs: This building ("+.class+") doesn't have a valid rally_object");
}

.is_legendary_training = 0;