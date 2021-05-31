// void, int nPlayer, Obj oColony
Building this;
Obj oTarget;
Gaika gaika;
int i, j;
bool bDeveloped;
StrArray strSkills;
str strDev;
bool bChosen;

this = oColony.AsBuilding;
gaika = GetGaika(oColony.pos);

strSkills[0] = "Spirit_Of_Creation";
strSkills[1] = "Spring_Of_Life";
//strSkills[2] = "Magic_Market";

bChosen = false;
while ( oColony.IsAlive() ) {

	for ( i = 0; i < 3; i += 1 ) {
		if ( .IsSkillDeveloped(strSkills[i]) ) {
			strDev = strSkills[i];
			break;
		}
	}
	if ( i == 0 ) {			// spirit of creation
		if ( .IsSkillReady(strDev) && !.legendary_unit.IsAlive ) {
			AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
		}
	} else if ( i == 1 ) {	// spring of life
		if ( .IsSkillReady(strDev) ) {
			AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
		}
	} else if ( i == 2 ) {	// magic market
		return;
	} else if ( !bChosen ) {	// no skill developed, develop one now
		j = rand(1);
		for ( i = 0; i < 3; i += 1 ) {
			strDev = "Develop_" + strSkills[(i + j) % 3];
			if (.GetCmdEnable(strDev)) {
				bChosen = true;
				.ExecCmd(strDev, true);
				
				//AIStartBuildlist(strDev, this, AIPriorityColonySpecial);
				break;
			}
		}
	} // otherwise, the skill is currently waiting or being developed now
	Sleep(3000);
}