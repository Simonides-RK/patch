// void, Obj This
int slot_to_spawn, i, j;
Item item;
IntArray arrItems;
StrArray strRaces;
Obj this;
ObjList ol;
str strRace, strTypes, strType;

this = This;

strRace = "";
strTypes = "CommonItem";

arrItems.resize(3);
strRaces[0] = "Race_Humans";
strRaces[1] = "Race_Foresters";
strRaces[2] = "Race_Darklings";

ol = Union(ClassPlayerObjs("BaseTownhall", .player, true), ClassPlayerObjs("Hero", .player, true)).GetObjList();
for ( i = 0; i < ol.count; i += 1 ) {
	strRace = ol[i].race_str;
	for ( j = 0; j < 3; j += 1 ) {
		if ( strRace == strRaces[j] ) {
			if ( arrItems[j] == 0 ) {
				arrItems[j] = 1;
				if ( j == 0 ) {
					strTypes = strTypes + ",CommonItem,CommonItem,Human_BattleAngel,Human_WizardOfTheBow,Human_WitchQueen";	// ,Human_WindRider
				} else if ( j == 1 ) {
					strTypes = strTypes + ",CommonItem,CommonItem,Forester_QueenOfTheWolves,Forester_Stalker,Forester_Fairy"; // ,Forester_Sharpshooter
				} else {	// j == 2
					strTypes = strTypes + ",CommonItem,CommonItem,Darkling_Soulmonger,Darkling_NightAssassin,Darkling_Axemaster,Darkling_Empath";
				}
			}
		}
	}
}

for(i = 0; i < .max_items; i += 1)
{
	item = .CreateRandomItem(250+rand(750)+1500/(rand(15)+1), i, "", ChooseRandom(strTypes), "");
	SetItemCost(item, item.cost);
}

while(1)
{
	Sleep(60000);
	if(.item_count == .max_items)
	{
		.RemoveItem(0);
		.ReorderItems();
	}
	slot_to_spawn = .item_count;
	strType = ChooseRandom(strTypes);
	item = .CreateRandomItem(250+rand(750)+1500/(rand(15)+1), slot_to_spawn, "", strType, "");
	SetItemCost(item, item.cost);
	
}