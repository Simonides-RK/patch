// void, Obj This

ParticleSystem this;
Unit u;
int i, nInterval, nIntervalDist, nCurrentDist;
point ptVector, ptDest, ptOriginalVector;
point pt1, pt2, pt3;
int nDist1, nDist2, nDist3;

this = This.AsParticleSystem();

if(.fired_by_projectile != 1)
{
	if(.proj_owner.IsDead() || .proj_target.IsDead())
	{
		.Erase();
		return;
	}
	.target_to_heal = .proj_target;
	.damage_to_heal = GetClassInt("Human_Monk", "heal_amount");		
}


nInterval = 100;
nIntervalDist = .speed*nInterval/1000; //distance we must cover in one interval
ptOriginalVector = .target_to_heal.exact_pos - .exact_pos;


while (.stolen_status != 1) { //1 = stolen, must change direction
	if(!.target_to_heal.IsAlive())
	{
		// take care of the infinite loops when target is dead
		break;
	}
	nCurrentDist = .exact_pos.Dist(.target_to_heal.pos);
	if (nCurrentDist > nIntervalDist) {
		ptVector = .target_to_heal.pos - .exact_pos;
		ptVector.SetLen(nIntervalDist);
		.Goto(.exact_pos + ptVector, nInterval);
		Sleep(nInterval);
	} else { //the last interval
		nInterval = 1000 * nCurrentDist / .speed;
		.Goto(.target_to_heal.pos, nInterval);
		Sleep(nInterval);
		break;
	}
}

if (.stolen_status == 1 && .target_to_heal.IsAlive()) {//1 = stolen, must change direction
	//1. Turn
		nInterval = 50;
		nIntervalDist = .speed*nInterval/1000; //distance we must cover in one interval
		
		for (i=0; i<20 && .exact_pos.Dist(.target_to_heal.pos) > 50; i+=1) { //no more than 20 turns, we don't want to simulate orbits :)
			//slightly randomize 'original' vector to avoid running straight away from the target
			ptOriginalVector.Rot(3 - rand(6));
			//choose a direction to turn
			ptVector = ptOriginalVector;
			ptVector.SetLen(nIntervalDist);
			pt1 = .exact_pos + ptVector; //1 - go straight
			ptVector.Rot(6);
			pt2 = .exact_pos + ptVector; //2 - turn 6 degrees
			ptVector.Rot(-12);
			pt3 = .exact_pos + ptVector; //3 - turn -6 degrees
			nDist1 = .target_to_heal.pos.Dist(pt1);
			nDist2 = .target_to_heal.pos.Dist(pt2);
			nDist3 = .target_to_heal.pos.Dist(pt3);
			if (nDist1 < nDist2) {
				if (nDist1 < nDist3) {
					ptDest = pt1;
				} else {
					ptDest = pt3;
					ptOriginalVector.Rot(-6);
				}
			} else {
				if (nDist2 < nDist3) {
					ptDest = pt2;
					ptOriginalVector.Rot(6);
				} else {
					ptDest = pt3;
					ptOriginalVector.Rot(-6);			
				}
			}
			
			.Goto(ptDest, nInterval);
			Sleep(nInterval);
			if(!.target_to_heal.IsAlive())
			{
				break;
			}
		}

		
	//2. Continue to the new unit
	nInterval = 100;
	nIntervalDist = .speed*nInterval/1000; //distance we must cover in one interval
	while (1) {
		if(!.target_to_heal.IsAlive())
		{
			break;
		}
		ptOriginalVector = .target_to_heal.exact_pos - .exact_pos;	
		nCurrentDist = .exact_pos.Dist(.target_to_heal.exact_pos);
		if (nCurrentDist > nIntervalDist) {
			ptVector = ptOriginalVector;
			ptVector.SetLen(nIntervalDist);
			.Goto(.exact_pos + ptVector, nInterval);
			Sleep(nInterval);
		} else { //the last interval
			nInterval = 1000 * nCurrentDist / .speed;
			.Goto(.target_to_heal.exact_pos, nInterval);
			Sleep(nInterval);
			break;
		}
	}	
}




u = .target_to_heal.AsUnit();
if(u.IsAlive())
{	
	if(!u.CantBeHealed())
	{
		CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", .target_to_heal.AsUnit, 400, true);
		.target_to_heal.Heal(.damage_to_heal, "Heal_Sound_");
	}
}
.StopEmitters();
Sleep(1000);
.Erase();
