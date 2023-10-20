// void, int nPlayer, Obj oColony
Building this;
Obj oTarget;
Gaika gaika;
int i, j;
bool bDeveloped;
StrArray strSkills;
str strDev;
bool bChosen;

this = oColony.AsBuilding;
gaika = GetGaika(oColony.pos);

strSkills[0] = "Spirit_Of_Creation";
strSkills[1] = "Spring_Of_Life";
strSkills[2] = "Magic_Market";

bChosen = false;
while ( oColony.IsAlive() ) {

	for ( i = 0; i < 3; i += 1 ) {
		if ( .IsSkillDeveloped(strSkills[i]) ) {
			strDev = strSkills[i];
			break;
		}
	}
	if ( i == 0 ) {			// spirit of creation
		if ( .IsSkillReady(strDev) && !.legendary_unit.IsAlive ) {
			AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
		}
	} else if ( i == 1 ) {	// spring of life
		if ( .IsSkillReady(strDev) ) {
			AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
		}
	} else if ( i == 2 ) {	// magic market
		int itemcost_glory;
		Item item;
		Obj nearest_hero, nearest_market;
		nearest_hero = Intersect(ObjsInSight(this, "Unit", true), ClassPlayerObjs("Hero", .player, true)).GetObjList().FilterClosest(.pos, 1)[0];
		nearest_market = ClassPlayerObjs("Elves_MagicMarket", .player, true).GetObjList.FilterClosest(.pos, 1)[0];
		item = nearest_market.GetItem(0);		
		if ( (nearest_hero.IsValid()) && (!nearest_hero.AsHero.IsGhost) && (item.IsValid()) && (item.cost < GetRes(.player, ResGold)) ) {
			nearest_hero.AsHero().AIManageItems; // ypsilon: in case of full inventory
			DecRes(.player, ResGold, item.cost);
			SetItemCost(item, item.cost/2);  //ypsilon: 3/4 value refers to SubAI\Elves_MagicMarket_* //Simonides: item cost is 1/2 after buying it in magic market
			nearest_market.GiveItem(item, nearest_hero);
			nearest_market.ReorderItems();
			itemcost_glory = item.cost/2*EnvReadInt(.player, "Race_Elves"); //ypsilon: following values refers to SubAI\Hero_GetItems
			if ( itemcost_glory < 50 ) itemcost_glory = 50;
			else if ( itemcost_glory > 750 ) itemcost_glory = 750; 
			IncRes(.player, ResGlory, itemcost_glory); 
		}
	} else if ( !bChosen ) {	// no skill developed, develop one now
		j = rand(2);
		for ( i = 0; i < 3; i += 1 ) {
			strDev = "Develop_" + strSkills[(i + j) % 3];
			if (.GetCmdEnable(strDev)) {
				bChosen = true;
				.ExecCmd(strDev, true);
				
				//AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
				break;
			}
		}
	} // otherwise, the skill is currently waiting or being developed now
	Sleep(3000);
}