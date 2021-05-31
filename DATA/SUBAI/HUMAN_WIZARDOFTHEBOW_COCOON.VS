// void, Obj This

Hero this;
str cmdname;
int new_mana;

this = This.AsHero();

//_pr("wizard_of_the_bow::cocoon");

cmdname = "ElectrostaticCocoon";

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

if (.ExistEffect("electro_cocoon"))
{
	UserNotification("common", "Skill already applied", Point(-1, -1), .player);
	return;
}


SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
	Sleep(.TimeToActionMoment());
}

.AddEffectTimeout("electro_cocoon", 0, 0, .electrostatic_duration);

if(.GetAnim())
{
	Sleep(.TimeToAnimFinish());
}

if(.on_crystal_tower == 1 && .next_command != "reequip" && .next_command != "teleport" && .next_command != "flare" && .next_command != "starstorm" && .next_command != "cocoon"  && .next_command != "set_the_target" && .next_command != "build_far_from_townhall")
{
	.ClearCommands();
	.SetCommand("idle");
}
