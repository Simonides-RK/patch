// void, Obj This, Obj building

Hero this;
Obj haunt;
str cmdname, cmd;
int new_mana;

this = This.AsHero();
cmdname = "HauntBuilding";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
} 

while ( !.Goto(building, .sight, 500, false, 500) );
if ( .IsInAir() ) {
	.StartAnim(AnimSpecial6);
} else {
	.StartAnim(AnimSpecial1);
}

if(.GetAnim())
{
	Sleep(.TimeToActionMoment());
}

if(building.IsAlive())
{
	PlaySound(building.pos, "assets/sounds/HeroSkills/Human WitchQueen/WitchQueen_HauntBuilding.wav");
	haunt = Place("BuildingHauntDummy", building.pos, .player);
	haunt.target_building = building;
	haunt.reserved_obj0 = this;		// reserved_obj0 for hauntbuilding is the witchqueen itself
	.SetMana(cmdname, new_mana);
}

if(.GetAnim())
{
	Sleep(.TimeToAnimFinish());
}