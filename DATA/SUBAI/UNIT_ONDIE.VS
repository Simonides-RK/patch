// void, Obj This, Obj oAttacker

Unit this;
int chance_to_drop, r;
ObjList heroes;
int unit_level, SupportCost, item_cost, random;
int chance_for_special_item_for_near_hero,
    chance_for_common_item_for_near_hero,
    chance_for_random_item;
int potion_type, potion, i, gl, charm_type, charm;
StrArray strPotions, strPotionConsts, strCharms, strCharmConsts;

//_pr("unit::ondie");
this = This.AsUnit();
if (.reserved_int7!=1){
chance_for_special_item_for_near_hero = GetConst("DropSpecialItemForHeroPromPerPop");
chance_for_common_item_for_near_hero = GetConst("DropCommonItemForHeroPromPerPop");
chance_for_random_item = GetConst("DropRandomItemPromPerPop");

.killer = oAttacker;
.die_pos = .pos;
if (oAttacker.IsValid()) oAttacker.kills += 1;

r=GetCost(.cost, ResSupport);
if (oAttacker.AsHero().IsValid() && oAttacker.IsEnemy(this) && r>0)
        if (!oAttacker.AsHero().IsGhost())
	if (rand(4)==1) {
        oAttacker.SetMaxHealth(oAttacker.GetMaxHealth() + r);
        FloatingText(Translate("[[25601940]]Health +[[]]")+r, oAttacker.pos, 0xCC3366, 0);
	}
if(!IsFlagSet(.user_flags1, .dont_return_population))
IncRes(.player, ResSupport, GetCost(.cost, ResSupport));
SetFlag(.user_flags1, .dont_return_population, true);

// If we're independent, give glory to the attacker's player
if (.IsIndependentGuardian()) {
        if (oAttacker.IsValid()) {
                if (oAttacker.IsEnemy(this)) {
                        bool bIndependent;
                        int bNomadGloryPath;
                        bIndependent = .player==15;
                        bNomadGloryPath = EnvReadInt(oAttacker.player, "Race_Nomads");
                        
                        if (bIndependent) {
                                int nCost;
                                if ( .class != "Rat" ) {
                                        nCost = (GetCost(.cost, ResGold) + GetCost(.cost, ResGems) * GetConst("GoldForOneGem")) * 20/100;
                                } else {
                                        nCost = .reserved_int2;
                                }
                                IncRes(oAttacker.player, ResGold, nCost);
                                FloatingText(Translate("[[]]+[[]]") + nCost, .pos, GetConst("GoldResColor"), oAttacker.player);
                        }

                        if (bIndependent || bNomadGloryPath>0) {
                                if (bNomadGloryPath>2)
                                IncRes(oAttacker.player, ResGlory, .independent_glory/2*bNomadGloryPath);
                                else IncRes(oAttacker.player, ResGlory, .independent_glory*85/100);
                                CreateFeedbackForPlayer("Coin", this, 1200, true, oAttacker.player);
                                CreateFeedbackForPlayer("CoinParticle", this, true, oAttacker.player);
                        }
                }
        }
}

if(.GetNoRandomItemFlag() == 0)
if(.item_count == 0) 
{
        SupportCost = GetCost(.cost, ResSupport);

        if(SupportCost > 0)
        {
                int custom_drop_chance;
                custom_drop_chance = EnvReadInt("/CustomItemSpawnRate");
                chance_for_common_item_for_near_hero = (100+custom_drop_chance)*chance_for_common_item_for_near_hero/100 * SupportCost;
                chance_for_special_item_for_near_hero = (100+custom_drop_chance)*chance_for_special_item_for_near_hero/100 * SupportCost;
                chance_for_random_item = (100+chance_for_random_item)/100 * SupportCost;
                item_cost = GetRandomItemCost(.player, SupportCost);
                heroes = ObjsInCircle(.pos, GetConst("ItemAppropriateHeroSearchRadius"), "Hero", true).GetObjList;
                chance_to_drop = chance_for_common_item_for_near_hero + chance_for_special_item_for_near_hero + chance_for_random_item;

                random = rand(1000);
                
                if(random < chance_to_drop - chance_for_random_item && 
                   heroes.count > 0 && item_cost > 50)
                {
                        if(random < chance_for_special_item_for_near_hero)
                                .CreateRandomItem(item_cost, 0, "", heroes[rand(heroes.count)].class, "");
                        else
                                .CreateRandomItem(item_cost, 0, heroes[rand(heroes.count)].GetSlotType(rand(4)), "CommonItem", "");
                } else
                if(random < chance_to_drop)
                {
                        .CreateRandomItem(item_cost, 0, "", "", "");
                } else 
                {
                        int custom_drop_chance;
                        int drop_chance;
                        custom_drop_chance = EnvReadInt("/CustomPotionSpawnRate")*SupportCost;
                        drop_chance = (100+custom_drop_chance)*GetConst("PotionDropPromPerPop")/100*SupportCost;
                                
                        if ( rand(1000) < drop_chance ) {       // additional small chance for dropping potions or charms

                                strPotions[0] = "potion_of_vitality";
                                strPotions[1] = "potion_of_inner_fire";
                                strPotions[2] = "potion_of_mental_energy";
                                strPotions[3] = "potion_of_swiftness";

                                strPotionConsts[0] = "PotionHealthPercent";
                                strPotionConsts[1] = "PotionDamagePercent";
                                strPotionConsts[2] = "PotionRechargePercent";
                                strPotionConsts[3] = "PotionArmorPercent";

                                potion_type = rand(100);
                                potion = 0;
                                for(i = 0; i < 4; i += 1) {
                                        potion += GetConst(strPotionConsts[i]);
                                        if ( potion_type <= potion ) {
                                                .SpawnItem(0, strPotions[i]);
                                                break;
                                        }
                                }
								strCharms[0] = "charm_lesser_healing";
                                strCharms[1] = "charm_healing";
                                strCharms[2] = "charm_greater_healing";
                                strCharms[3] = "charm_lesser_restoration";
								strCharms[4] = "charm_restoration";
								strCharms[5] = "charm_greater_restoration";
								strCharms[6] = "charm_mana";
								strCharms[7] = "charm_invulnerability";
								strCharms[8] = "charm_invisibility";

                                strCharmConsts[0] = "charm_lesser_healingPercent";
                                strCharmConsts[1] = "charm_healingPercent";
                                strCharmConsts[2] = "charm_greater_healingPercent";
                                strCharmConsts[3] = "charm_lesser_restorationPercent";
								strCharmConsts[4] = "charm_restorationPercent";
								strCharmConsts[5] = "charm_greater_restorationPercent";
								strCharmConsts[6] = "charm_manaPercent";
								strCharmConsts[7] = "charm_invulnerabilityPercent";
								strCharmConsts[8] = "charm_invisibilityPercent";
								
                                charm_type = rand(1000);
                                charm = 0;
                                for(i = 0; i < 9; i += 1) {
                                        charm += GetConst(strCharmConsts[i]);
                                        if ( charm_type <= charm ) {
                                                .SpawnItem(0, strCharms[i]);
                                                break;
                                        }
                                }								
                        }
                }
        }
} 

if (.GetNoRandomItemFlag() == 0)
if (.max_items == 1)
if (.item_count == 1)
{
        point pt;
        bool bDrop;
        
        bDrop = true;
        if(.class == "Trolls_SmallTroll")
        {
                if(.cannon != this)
                {
                        bDrop = false;
                }
        }
		
		if(.class == "Nomad_Spearman") 
			{
				if(.plundering == 1)
				{
				bDrop = false;
				}
			}
		
		if(.class == "Nomad_Cavalry")
		{
			if(.plundering == 1)
				{
				bDrop = false;
				}
		}
		
		if(.class == "Dragons_RedDragon")
		{
			if (.is_fury == 1)
			{
			bDrop = false;
			}
		}
		
        if(bDrop)
        {
                pt = .pos;
                if ( .flying == 1 ) {
                        pt = PassablePointNear(.pos, 200, 10, true);      
                }
                if(pt.InRect(GetMapRect()))
                {               
                        .DropItem(.GetItem(0), pt);
                }
        }
}

if(.legendary != 0)
{
        ObjList ol;
        int count;
        int i;
        ol = ObjsInRect(GetMapRect, "Independent_Settlement", false).GetObjList;
        count = ol.count;
        for(i = 0; i < count; i+=1)
        {
                Obj o;
                o = ol[i];
                if(ol[i].legendary_unit == this)
                {
                        if(o.GetSkillNumber > 0)
                        { 
                                str name; 
                                name = o.SkillName(4);
                                if(!o.IsRecharging(name))
                                        o.SetRecharging(name, true);
                        }
                }
        }
}

if (oAttacker.IsValid())
        if (oAttacker.IsEnemy(this))
                gl=EnvReadInt(oAttacker.player, "Race_Shades");
                if (gl > 0)
                        if (.class == "Forester_Worker" || .class == "Human_Worker" || .class=="Darkling_DarkMage")
                                {
                                        IncRes(oAttacker.player, ResGlory, GetConst("Glory_KillWorker")/2*gl);
                                        CreateFeedbackForPlayer("Coin", this, 1200, true, oAttacker.player);
                                        CreateFeedbackForPlayer("CoinParticle", this, true, oAttacker.player);
                                }
}