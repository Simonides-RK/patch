// str OUT, ObjList objs, point OUT pos

str sArea;
Obj oExecutor;

oExecutor = objs[0];
sArea = EnvReadString(oExecutor, "build_area");

if (oExecutor.IsHeirOf("BaseTownhall"))
	if (oExecutor.DistTo(pos)>GetConst("BuildDistance")) {
		bool b;
		b = true;
		if (sArea == "") b = false;
		else if (!IsPointInArea(pos, sArea)) b = false;
		if (!b)
			return Translate("[[10597618]]Can not build there. Please select a place closer to the Town Hall.[[]]");
	}

if (!IsPassableToPlaceByMovingUnits(cmdparam, pos, oExecutor.player))
	return Translate("[[10602254]]Can not build there. Please select empty terrain.[[]]");
	
if (oExecutor.is_haunted == 1) {
		return Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
		
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
