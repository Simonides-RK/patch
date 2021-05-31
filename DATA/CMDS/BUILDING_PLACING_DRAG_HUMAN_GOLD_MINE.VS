// str OUT, ObjList objs, point OUT pos

ObjList golds;
Obj gold;
point pt, v, ptSrc, ptDest;
int x, y;
str sArea;
Obj oExecutor;

oExecutor = objs[0];
sArea = EnvReadString(oExecutor, "build_area");

if (oExecutor.IsHeirOf("BaseTownhall"))
	if (oExecutor.DistTo(pos)>GetConst("BuildDistance")){
		bool b;
		b = true;
		if (sArea == "") b = false;
		else if (!IsPointInArea(pos, sArea)) b = false;
		if (!b)
			return Translate("[[10597618]]Can not build there. Please select a place closer to the Town Hall.[[]]");
	}
			
if(oExecutor.class == "Human_TradePost")	
		if (oExecutor.DistTo(pos)>GetConst("TradePostBuildDistance")){
		bool b;
		b = true;
		if (sArea == "") b = false;
		else if (!IsPointInArea(pos, sArea)) b = false;
		if (!b)
			return Translate("[[10633262]]Can not build there. Please select a place closer to the Trade Post.[[]]");
	}
if (oExecutor.is_haunted == 1) {
		return Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
		
		}
	
x = EnvReadInt(oExecutor.player, "/HumanGoldMineEntity_X");
y = EnvReadInt(oExecutor.player, "/HumanGoldMineEntity_Y");
pt = Point(x, y);

if ( pt.x == 0 && pt.y == 0 ) {
	ptSrc = GetEntityPointByIndex("Human_GoldMine", EntityPointSettlementSpecial1, 0, pos);
	pt = ptSrc - pos;
	EnvWriteInt(oExecutor.player, "/HumanGoldMineEntity_X", pt.x);
	EnvWriteInt(oExecutor.player, "/HumanGoldMineEntity_Y", pt.y);
} else {
	ptSrc = pos + pt;
}

golds = GetObjsInCircle(pos, 120, "BaseGoldDeposit");
if (golds.count!=0)
	{
		gold = golds.FilterClosest(pos, 1)[0];
		ptDest = golds[0].GetNearestEntityPoint(EntityPointEnter, pos);
		
		v = ptDest - ptSrc;

		pos = pos + v;
		
		if (!IsPassableToPlaceByMovingUnits(cmdparam, pos, oExecutor.player))
			return Translate("[[10602254]]Can not build there. Please select empty terrain.[[]]");
		if (GetObjsInCircle(pos, 75, "Building").count)
			return Translate("[[10674008]]Can not build there, building in the way.[[]]");
	}
else
	return Translate("[[10684925]]A Gold Mine must be built over a gold deposit[[]]");

v = pos - ptDest;

return "";
