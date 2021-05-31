// str OUT, ObjList objs, point OUT pos

int i, nPoints, nPlayer;
point pt;
str sArea;
Obj oExecutor;

oExecutor = objs[0];
nPlayer = oExecutor.player;
sArea = EnvReadString(oExecutor, "build_area");


	if (oExecutor.DistTo(pos)>850) {
		bool b;
		b = true;
		if (sArea == "") b = false;
		else if (!IsPointInArea(pos, sArea)) b = false;
		if (!b)
			return Translate("Can not build there. Please select a place closer to the Trade Post.");
	}

if (!IsPassableToPlaceByMovingUnits(cmdparam, pos, nPlayer))
	return Translate("[[10602254]]Can not build there. Please select empty terrain.[[]]");
	
if (oExecutor.is_haunted == 1) {
		return Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
		
		}

//get number of \-oriented frameworks
nPoints = GetEntityPointsCount(cmdparam, EntityPointFramework1);
for (i=0; i<nPoints; i+=1) {
	pt = GetEntityPointByIndex(cmdparam, EntityPointFramework1, i, pos);
	if (!IsPassableToPlaceByMovingUnits("framework1", pt, nPlayer))
		return Translate("[[10626169]]No place for the framework there. Please select empty terrain.[[]]");
}


//get number of /-oriented frameworks
nPoints = GetEntityPointsCount(cmdparam, EntityPointFramework2);
for (i=0; i<nPoints; i+=1) {
	pt = GetEntityPointByIndex(cmdparam, EntityPointFramework2, i, pos);
	if (!IsPassableToPlaceByMovingUnits("framework2", pt, nPlayer))
		return Translate("[[10626169]]No place for the framework there. Please select empty terrain.[[]]");
}

//check if we're building too close to a gold deposit
{
	ObjList golds;
	int nRadius;
	
	nRadius = GetClassInt(cmdparam, "radius") + GetConst("GoldDepositBuildDistance");
	golds = GetObjsInCircle(pos, nRadius, "BaseGoldDeposit");
	if (golds.count > 0) {
		return Translate("[[10617758]]Can not build there. Please select a place away from the gold deposit[[]]");
	}	
}


return "";