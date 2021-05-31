// void, Obj this

DecRes(.player, ResSupport, GetCost(.cost, ResSupport));
.stand_pos_end_time = -1;
.recharge_bonus = 0;


if (IsUpgradeAvailable(.player, "upgrade_StrengthOfTheForest")){ 
	if ( !this.IsPlayableRace()  && !this.AsUnit().IsIndependentGuardian() ) {  
				.AsUnit().AddEffect("strength_of_the_forest", 0, 0);  
	}
}
if (IsUpgradeAvailable(.player, "upgrade_PrimalFury")){ 
	if ( .race == Race_Foresters && .class != "Forester_QueenOfTheWolves" && .class != "Forester_Sharpshooter" && .class != "Forester_Stalker" && .class != "Forester_Fairy" && .class != "Forester_Worker") {  
				.AsUnit().AddEffect("primal_fury", 0, 0);  
	}
}