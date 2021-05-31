// void, Obj This

Unit newunit;
Building this;
point ptExit;
int SupportCost;
int d, speedup;

this = This.AsBuilding();

d = .cmddelay;
if ( IsUpgradeAvailable(.player, "upgrade_WeaponMarkets") ) {
        speedup = GetClassInt("Human_Townhall", "weaponmarket_speedup");
        d = d * (100 - speedup) / 100;
}

.Progress(d);

if(.rally_object.IsValid) {
        ptExit = .GetExitPoint(.rally_object.pos);
        newunit = BuildUnit(cmdparam, ptExit, this.player);
        newunit.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), true);
        SupportCost = GetCost(newunit.cost, ResSupport);
        IncRes(.player, ResSupport, SupportCost); // Because the unit will take it back in its 'init' script
        
        newunit.SetNoRandomItemFlag(false); // set the flag first, so the init script can give a random item to the unit
        
        if(newunit.HasCommand("spawn"))
        {
                newunit.InsertCommand("spawn");
        }
        
        Sleep(1); // wait for the init scripts to run

        
} else {
        _pr("train.vs: This building ("+.class+") doesn't have a valid rally_object");
}

