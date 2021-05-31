// str OUT, ObjList objs, point OUT pos

if (objs[0].DistTo(pos) > GetClassInt(GetFromStr(cmdparam, "MagicAreaClass"), "place_distance"))
	return Translate("[[10698137]]Can not cast the spell there. Please select a place closer to the building.[[]]");
	
if (objs[0].is_haunted == 1) {
		return Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
		
		}

return "";
