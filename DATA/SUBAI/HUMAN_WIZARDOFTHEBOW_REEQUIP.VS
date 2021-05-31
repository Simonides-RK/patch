// void, Obj me, Obj target

ObjList ol;
Hero this;
Unit u;
str cmdname;
int new_mana;
ObjList ol1;
int count, i;
bool bClass1ToClass2;
Obj empty;
str new_class;

this = me.AsHero();
u = target.AsUnit();
empty.Clear();

//_pr("wizard_of_the_bow::reequip");

cmdname = "Reequip";

if(.on_crystal_tower != 1)
{
        while(!.Goto(u, .reequip_min_dist_to_cast, 500, false, 500));
}
.Face(u);

if(!u.IsValid())
{
        UserNotification("Invalid target", "", Point(-1, -1), .player);
        return;
}

bClass1ToClass2 = u.class == .reequip_class1;
if(bClass1ToClass2)
{
        ol = Intersect(ObjsInRange(u, .reequip_class1, .reequip_range, false), FriendlyObjs(.player, .reequip_class1, false)).GetObjList();
}
else
{
        ol = Intersect(ObjsInRange(u, .reequip_class2, .reequip_range, false), FriendlyObjs(.player, .reequip_class2, false)).GetObjList();
}
for (i=0; i<ol.count; i+=1)
        if (ol[i].AsUnit().IsUncontrollable())
                { ol.Remove(ol[i]); i-=1; }
ol = ol.FilterClosest(.pos, .reequip_count-1);
ol.Add(u);
ol.ClearDead();
count = ol.count();
if(count <= 0)
{
        UserNotification("No units to cast on", "", Point(-1, -1), .player);
        return;
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

if(.on_crystal_tower != 1)
{
        SetFlag(.user_flags1, .cant_be_stunned, true);
        .SetBlockCommand(true);
}
.StartAnim(AnimSpecial1);
for(i = 0; i < count; i += 1)
{
        u = ol[i].AsUnit();
        if(u.IsValid())
        {
        if(u.ExistEffect("possessed"))
        {
                // find the sprite tha
//                ol1 = EnemyObjsInRange(u, "Forester_Spirit", 10, true).GetObjList();
//                ol1 = ol1.FilterClosest(u.pos, 1);
//                if(ol1.count == 1)
//                {
                        u.reserved_obj6.DropDead();u.SetCantBeHealed(false);
//                }
        }


                CreateFeedback("data/particles/Summon.part.xml", u, .reequip_feedback_time, true);
        }
}
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}
PlaySound(.pos, "assets/sounds/HeroSkills/Human WizardOfTheBow/WizardOfTheBow_Reequip.wav");
Sleep(100);
for(i = 0; i < count; i += 1)
{
        u = ol[i].AsUnit();
        if(!u.IsAlive())
        {
                continue;
        }
u.SetNoselectFlag(true);
u.SetEnemyCannotTargetFlag(true);

}


Sleep(300);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

for(i = 0; i < count; i += 1)
{
        u = ol[i].AsUnit();
        if(!u.IsAlive()) continue;
        new_class=.reequip_class1;
        if(bClass1ToClass2) new_class=.reequip_class2;

        u.ChangeScriptClass(new_class, false, true);

}
Sleep(500);
for(i = 0; i < count; i += 1)
{
        u = ol[i].AsUnit();
        if(!u.IsAlive()) continue;
        u.SetNoselectFlag(false);
        u.SetEnemyCannotTargetFlag(false);
}


if(.on_crystal_tower == 1 && .next_command != "reequip" && .next_command != "teleport" && .next_command != "flare" && .next_command != "starstorm" && .next_command != "cocoon"  && .next_command != "set_the_target"  && .next_command != "build_far_from_townhall")
{
        .ClearCommands();
        .SetCommand("idle");
}
