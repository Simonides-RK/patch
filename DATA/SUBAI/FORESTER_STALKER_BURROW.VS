// void, Obj This

Hero this;
str cmd;
int new_mana;

this = This.AsHero();

//_pr("stalker::burrow");

cmd = "Burrow";
new_mana = .GetMana(cmd) - .GetManaCost(cmd);
if(new_mana >= 0)
{
        .SetMana(cmd, new_mana);
} 
else
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);
.PlayAnim(AnimSpecial3);
.burrowed = 1;
.SetDeadAnim(AnimNoAnim);
                   
.SetSight(.burrowed_sight);
.SetVisible(false);
// copy paster from special_onfinish script 
// because of the bug that ClearCommands() doesn'w work fron onfinish script
cmd = .next_command;
if(cmd != "plantbeast" && cmd != "teleport" && cmd != "setburrowtarget" && cmd != "thorns" && cmd != "plantcactustrap" && cmd != "forester_overlord")
{
        .ClearCommands();
}
