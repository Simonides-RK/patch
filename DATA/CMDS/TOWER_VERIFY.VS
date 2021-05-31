//bool, ObjList objs, int player, str rollover, str OUT disabled_reason_text
int towers;
Query q;
Query c;
int nSupport;
int ncolony;
int towerini;
int Supportparam;
int Colonyparam;

c = ClassPlayerObjs("Independent_Settlement", player, true);

q = ClassPlayerObjs("Forester_Mage_Tower,Human_SupportBuilding,Darkling_SoulWatcher", player, true);

towers = ClassPlayerObjs("Tower", player, true).count - ClassPlayerObjs("Darkling_TowerUpgrade_Crystal", player, true).count;

nSupport=q.count;
ncolony=c.count;
towerini = GetConst("towerini"); //innitial maximum of towers
Supportparam = GetConst("Supportparam"); //increase per house
Colonyparam = GetConst("Colonyparam"); //increase per Colony

if ( towers >= (towerini+nSupport*Supportparam+ncolony*Colonyparam) ) {
	disabled_reason_text = Translate("[[tower_verify]]Cannot build more Towers. Maximum number of Towers is 6 + 2 per House/Soulwatcher + 3 per Colony.[[]]");
	return false;
}

return true;