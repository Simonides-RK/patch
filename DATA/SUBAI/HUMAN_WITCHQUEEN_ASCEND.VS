// void, Obj This

Hero this;
str cmdname;
int new_mana;
Unit u;
ObjList ol;
int iTime, iCurTime, iSleep, iZOffsetToReach;

this = This.AsHero();

if ( .IsInAir() != 0 ) return;

//_pr("witch queen::levitation");

cmdname = "Levitation";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}

.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);

.SetCantMove(true);
PlaySound(.pos, "assets/sounds/HeroSkills/Human WitchQueen/WitchQueen_Levitation.wav");

iZOffsetToReach = .addhealthbaroffset;
.StartAnim(AnimSpecial2);
if(.GetAnim())
{
	iSleep = 5;
	iTime = .TimeToAnimFinish();
	for(iCurTime = 0; iCurTime < iTime; iCurTime += iSleep)
	{
		if(.GetAnim() == 0)
		{
			break;
		}
		.SetAddHealthBarOffset(iZOffsetToReach * iCurTime / iTime);
		Sleep(iSleep);
	}
}
.SetAddHealthBarOffset(iZOffsetToReach);

.SetInAir(true);
.SetCustomAttackAnim(AnimSpecial5);
SetFlag(.user_flags1, .cant_be_stunned, true);
//.SetCantAddEffect(true);
.SetMana(cmdname, new_mana);