//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

//Hero this;
//str dest, specname;
//int gold, gems, support, glory;
int i;
for (i = objs.count - 1; i >= 0; i -= 1){
if ((objs[i].IsHeirOf("Military")) && !objs[i].AsHero().IsValid) {return true; break;}
if (objs[i].AsHero().IsValid) if (!objs[i].AsHero.IsGhost) {return true; break;}
if (objs[i].class=="Darkling_Meteor") {return true; break;}
}
disabled_reason_text = rollover + "<color 255 64 64>\n\n" + Translate("[[10815281]]The Champion is in ghost form and cannot use skills[[]]");
return false;