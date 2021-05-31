// void, Obj me, point pt

Hero this;
str cmdname;
int new_mana;
int time_started;

this = me.AsHero();

//_pr("wizard_of_the_bow::starstorm");

cmdname = "StarStorm";

if(.DistTo(pt) > .starstorm_cast_range && .on_crystal_tower != 1)
{
        while(!.Goto(pt, .starstorm_cast_range, 500, false, 500));
}

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

time_started = GetTime();
PlaySound(pt, "assets/sounds/HeroSkills/Human WizardOfTheBow/WizardOfTheBow_Hailstorm.wav");
.starstorm = Place("Human_WizardOfTheBow_StarStorm", pt, .player);
.starstorm.starstorm_owner = this;
.starstorm.my_lifetime = .starstorm_lifetime;
.starstorm.SetCommand("selfdestruct");
if (.on_crystal_tower != 1) me.AsUnit().AddEffectTimeout("shadeblurred", 0, 0 , .starstorm_lifetime-1);
while(.starstorm.IsAlive())
{
        if(.on_crystal_tower == 1 && (.next_command == "reequip" || .next_command == "teleport" || .next_command == "flare" || .next_command == "starstorm" || .next_command == "cocoon"  || .next_command == "set_the_target" || .next_command == "build_far_from_townhall"))
        {
                if(.starstorm.IsAlive())
                {
                        .starstorm.my_lifetime = 1;
                        .starstorm.SetCommand("selfdestruct");
                }               
                break;
        }
        .Face(pt);
        .PlayAnim(AnimSpecial1);
}
if (me.AsUnit().ExistEffect("shadeblurred")) me.AsUnit().RemoveEffect("shadeblurred",0,0);
if(.on_crystal_tower == 1 && .next_command != "reequip" && .next_command != "teleport" && .next_command != "flare" && .next_command != "starstorm" && .next_command != "cocoon"  && .next_command != "set_the_target" && .next_command != "build_far_from_townhall")
{
        .ClearCommands();
        .SetCommand("idle");
}

