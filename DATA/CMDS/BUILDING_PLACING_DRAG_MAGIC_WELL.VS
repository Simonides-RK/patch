// str OUT, ObjList objs, point OUT pos

ObjList gemdeposits;
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
	
if(oExecutor.class == "Forester_TradePost")	
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
	
if (!IsPassableToPlaceByMovingUnits(cmdparam, pos, oExecutor.player))
	return Translate("[[10602254]]Can not build there. Please select empty terrain.[[]]");

gemdeposits = GetObjsInCircle(pos, GetConst("ForesterMagicWellRange"), "BaseGemsDeposit");
if (gemdeposits.count==0)
	return Translate("[[10702655]]A Magic Well must be built near a gems deposit[[]]");
if (gemdeposits[0].DistTo(pos)<GetConst("ForesterMagicWellForbiddenRange"))
	return Translate("[[10602254]]Can not build there. Please select empty terrain.[[]]");

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
