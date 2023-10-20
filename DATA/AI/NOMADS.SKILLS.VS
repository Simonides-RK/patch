// void, int nPlayer, Obj oColony
Building this;
Obj oTarget;
ObjList ol;
Gaika gaika;
int i, j;
bool bDeveloped;
StrArray strSkills;
str strDev;
bool bChosen;
point pt;
int x, y;
rect r;

this = oColony.AsBuilding;
gaika = GetGaika(oColony.pos);

strSkills[0] = "Restoration";
strSkills[1] = "Plunder";
strSkills[2] = "Bazaar";

bChosen = false;
while ( oColony.IsAlive() ) {

	for ( i = 0; i < 3; i += 1 ) {
		if ( .IsSkillDeveloped(strSkills[i]) ) {
			strDev = strSkills[i];
			break;
		}
	}

	if ( i == 0 ) {			// restoration
		if ( .IsSkillReady(strDev) ) {
			r = GetMapRect;
			ol = Union( Union( Union (ObjsInRect(r,"Trolls_Settlement_Die", true), ObjsInRect(r,"Nomad_TownHall_Die", true)), Union (ObjsInRect(r,"Elves_Settlement_Die", true),  ObjsInRect(r,"Shades_Settlement_Die", true)) ), ObjsInRect(r,"Dragons_Townhall_Die", true) ).GetObjList();
			oTarget.Clear();
			if (ol.count > 0) {
				for ( i = 0; i < ol.count; i += 1 ) {
					if ( !ol[i].IsValid() ) continue;
					///if ( ol[i].IsAlive() ) continue;
					oTarget = ol[i];
					break;
				}
			}
			if ( oTarget.IsValid() ) {
				.ExecCmd(strDev, oTarget.pos, true);
			}
		}
	} else if ( i == 1 ) {	// plunder
		if ( .IsSkillReady(strDev) ) {
			x = EnvReadInt(nPlayer, "ColonySpecialX");
			y = EnvReadInt(nPlayer, "ColonySpecialY");
			pt = Point(x, y);
			if ( pt.InRect(GetMapRect()) ) {
				.ExecCmd(strDev, pt, true);
			}
		}
	} else if ( i == 2 ) {	// bazaar
		return; 
	} else if ( !bChosen ) {	// no skill developed, develop one now
		j = rand(2);
		for ( i = 0; i < 3; i += 1 ) {
			strDev = "Develop_" + strSkills[(i + j) % 3];
			if ( .GetCmdEnable(strDev)) {
				bChosen = true;
				.ExecCmd(strDev, true);
				// AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
				break;
			}
		}
	} // otherwise, the skill is currently waiting or being developed now
	Sleep(3000);
}