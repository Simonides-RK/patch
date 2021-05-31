// void, Obj This, Obj target
Hero this;
int i;
Obj wolf;
point pt;
str cmdname;
int new_mana;

this = This.AsHero();
if(.number_wolves == -1)	// initialize 
	.number_wolves = 0;
if(!target.IsEnemy(this))
	return;
if(!target.IsRevealed(.player))
	{
		UserNotification("common", Translate("[[10982986]]Can't target invisible units[[]]"), Point(-1, -1), .player);
		return;
	}

while(!.Goto(target.pos, 300, 500, false, 500));
.Face(target);

if(!target.IsRevealed(.player))
	{
		UserNotification("common", Translate("[[10982986]]Can't target invisible units[[]]"), Point(-1, -1), .player);
		return;
	}
	
if(target.AsUnit.IsValid)
	pt = GetSummonPt("Forester_WhiteWolf", target.AsUnit.last_passable_pos, 200, .player);
else
	pt = GetSummonPt("Forester_WhiteWolf", target.pos, 200, .player);
if (pt.x < 0 || pt.y < 0)
{
	UserNotification("common", Translate("[[25064470]]Can't summon Assassin Wolves, not enough space[[]]"), Point(-1, -1), .player);
	return;
}

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);
//-------------MANA COST------------------
//----------------------------------------
cmdname = "Assassin_Wolves";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana >= 0)
{
	.SetMana(cmdname, new_mana);
} 
else
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}
//----------SPECIAL ACTION-----------------
//-----------------------------------------
	if(.queen_state == 1)
	{
		.StartAnim(AnimSpecial6);
		if(.GetAnim())
		{
			Sleep(.TimeToActionMoment());
		}
	}
	for(i = 0; i < 2; i +=1)
	{
		CreateFeedback("Data/Particles/summon.part.xml", pt, 1000);

		wolf = Place("Forester_WhiteWolf", pt, .player);
		wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .GetEffectParam("item_assasin_bonus", 1));
		wolf.queen_of_the_wolves = this;
		wolf.AsUnit().SetUncontrollableFlag(true);
		wolf.SetCommand("attack", target);
		if (.IsSkillAvailable("Assassin_Wolves"))
											{
											wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .assassin_wolves_health_bonus);
											}
		if(.IsSkillAvailable("Ghost_Wolves"))
		{
			wolf.SetVisible(false);
			wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .GetEffectParam("item_assasin_bonus", 1)+.ghost_wolves_health_bonus);
			if (.IsSkillAvailable("Assassin_Wolves"))
											{
											wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1)+.ghost_wolves_health_bonus + .assassin_wolves_health_bonus);
											}
		}
		.number_wolves += 1;
		pt = GetSummonPt("Forester_WhiteWolf", target.AsUnit.last_passable_pos, 200, .player);
		if (pt.x < 0 || pt.y < 0)
			break;
	}

	if(.queen_state == 1 && .GetAnim() != 0)
	{
		Sleep(.TimeToAnimFinish);
	}
//-----------------------------------------
//-----------------------------------------
