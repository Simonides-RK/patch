// void, Obj This

Unit unitforchange;
unitforchange=This.reserved_obj0.AsUnit;
unitforchange.SetBlockCommand(true);
This.AsUnit.SetNoselectFlag(true);
This.AsUnit.SetEnemyCannotTargetFlag(true);
unitforchange.SetHidden(true);
Sleep(300);
if (unitforchange.AsUnit().IsAlive()){
	//spiritual blessing
if ( IsUpgradeAvailable(This.player, "upgrade_SpiritualBlessing") && This.AsUnit.ExistEffect("spiritual_blessing_effect")) {
        This.AsUnit.RemoveEffect("spiritual_blessing_effect", 0, 0);
		unitforchange.RemoveEffect("spiritual_blessing_effect", 0, 0);
}

if (This.reserved_int9==1){
        unitforchange.ChangeScriptClass(EnvReadString(This.AsUnit(), "NewClass"), true, false);
        } else {
        unitforchange.ChangeScriptClass(EnvReadString(This.AsUnit(), "NewClass"), true, true);
        }
if (unitforchange.class=="Human_HeavyCavalry") IncRes(This.player, ResSupport, GetCost(GetClassStr("Human_HeavyCavalry", "cost"), ResSupport) - GetCost(GetClassStr("Human_Cavalry", "cost"), ResSupport));

if (IsUpgradeAvailable(unitforchange.player, "upgrade_GoldenShield")) {
	unitforchange.SetGoldenFX(true);
	}

Sleep(300);
if (unitforchange.AsUnit().IsAlive()){
unitforchange.SetHidden(false);
unitforchange.SetBlockCommand(false);
}
}
This.AsUnit.SetEnemyCannotTargetFlag(false);
This.AsUnit.SetNoselectFlag(false);
This.AsUnit.DropDead;
