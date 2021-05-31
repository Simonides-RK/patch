// void, Obj This, point pt

Hero this;
Obj altar;
str cmdname;
int new_mana;

this = This.AsHero();

//_pr("battleangel::AltarOfHealing");

cmdname = "AltarOfHealing";

pt = PassablePointNear(pt, .altar_place_radius * 2, .altar_place_tries, true);
if ( !pt.InRect(GetMapRect()) ) return;

new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}

if (.DistTo(pt)>.sight) // Please don't move to a lockable place if already in range
	while(!.Goto(pt, .sight, 500, false, 500));
.Face(pt);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
	Sleep(.TimeToActionMoment);
}
PlaySound(pt, "assets/sounds/HeroSkills/Human BattleAngel/BattleAngel_Altar.wav");
altar = Place("Human_AltarOfHealing", pt, .player);
altar.SetMaxHealth(altar.health + .GetEffectParam("item_altar_bonus", 1)*0012);
if(.GetAnim())
{
	Sleep(.TimeToAnimFinish);
}

// finally:
.SetMana(cmdname, new_mana);
