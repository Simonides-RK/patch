//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Hero this;
str dest, specname;
int gold, gems, support, glory;

this = objs[0].AsHero();

if(.IsGhost)
{
	disabled_reason_text = rollover + "<color 255 64 64>\n\n" + Translate("[[10815281]]The Champion is in ghost form and cannot use skills[[]]");
	return false;
}

if (.ExistEffect("electro_cocoon"))
{
	disabled_reason_text = rollover + "<color 255 64 64>\n\n" + Translate("[[doubletime]]Skill already in use[[]]");
	return false;
}

return true;