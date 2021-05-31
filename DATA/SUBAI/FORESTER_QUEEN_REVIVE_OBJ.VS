// void, Obj This, Obj target
Hero this;
int i;
str cmdname;
int new_mana;
point pt;
Obj wolf;
ObjList ol;

this = This.AsHero();
if(.number_wolves == -1)        // initialize 
        .number_wolves = 0;
if(target.IsEnemy(this))
        return;
if(target.class != "Forester_QueenOfTheWolves" && 
        target.class != "Forester_WolfMaster" &&
        target.class != "Forester_Werewolf")
        {
                .AddCommand(true, "revive_wolves", target.pos);
                return;
        }
if(target != this)
        while(!.Goto(target, 500, 1500, false, 500) && target.IsAlive);


if(target.IsValid)
{
        if(target.IsDead) // if target has died while we walked towards the target
        {
                .AddCommand(true, "revive_wolves", target.pos);
                return;
        }
} else
        return;

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);
//-------------MANA COST------------------
//----------------------------------------
cmdname = "Revive_Wolves";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname); 
if(new_mana < 0)
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
        if(target.class == "Forester_QueenOfTheWolves")
        {
                if(target.queen_state == 1 && target.number_wolves >= target.max_number_wolves)
                {
                        if(.GetAnim())
                        {
                                Sleep(.TimeToAnimFinish());
                        }
                        return;
                }
                if(target.queen_state == 2 && target.number_wolves >= target.max_number_wolves && target.health==target.GetMaxHealth())
                {
                        if(.GetAnim())
                        {
                                Sleep(.TimeToAnimFinish());
                        }
                        return;
                }
                .SetMana(cmdname, new_mana);

                if (target.queen_state == 2 && !target.AsUnit.CantBeHealed) {
                        target.Heal(target.GetMaxHealth()/2, "Heal_Sound_");
                        CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", target.AsUnit(), 400, true);
                }
                
                PlaySound(.pos, "assets/sounds/HeroSkills/Forester Queen/Forester_ReviveWolves.wav");
                ol = Summon("Forester_WhiteWolf", target.max_number_wolves - target.number_wolves, .pos, .sight/2, .player, "Data/Particles/summon.part.xml", 1500, "Summon_Sound_");

                for(i = 0; i < ol.count; i +=1)
                {
                        wolf = ol[i];
                        wolf.queen_of_the_wolves = target;
                        wolf.AsUnit().SetUncontrollableFlag(true);
                        wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1));
                        if(target.IsSkillAvailable("Ghost_Wolves"))
                        {
                                wolf.SetVisible(false);
                                wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .ghost_wolves_health_bonus);
                        }
                        target.number_wolves += 1;
                }
                //Sleep(9000);
                FinishSummon(ol);
        } else
        if(target.class == "Forester_WolfMaster")
        {
                if(target.maxhealth == target.health && target.wm_wolf1.IsAlive && target.wm_wolf2.IsAlive && target.wm_wolf3.IsAlive && target.wm_wolf4.IsAlive)
                {
                        if(.GetAnim())
                        {
                                Sleep(.TimeToAnimFinish());
                        }
                        return;
                }
                .SetMana(cmdname, new_mana);
                target.Heal(10000);
                PlaySound(target.pos, "assets/sounds/HeroSkills/Forester Queen/Forester_ReviveWolves.wav");
                if (!target.wm_wolf1.IsAlive)
                {
                        Unit wolf;
                        wolf = Summon("Forester_GrayWolf", 1, target.pos, .sight/2, .player)[0].AsUnit;
                        if(wolf.IsValid)
                        {
                                target.wm_wolf1 = wolf;
                                target.wm_wolf1.wolf_master = target;
                                target.wm_wolf1.AsUnit.SetUncontrollableFlag(true);
                        }
                }
                if (!target.wm_wolf2.IsAlive)
                {
                        Unit wolf;
                        wolf = Summon("Forester_GrayWolf", 1, target.pos, .sight/2, .player)[0].AsUnit;
                        if(wolf.IsValid)
                        {
                                target.wm_wolf2 = wolf;
                                target.wm_wolf2.wolf_master = target;
                                target.wm_wolf2.AsUnit.SetUncontrollableFlag(true);
                        }
                }
                if (!target.wm_wolf3.IsAlive)
                {
                        Unit wolf;
                        wolf = Summon("Forester_GrayWolf", 1, target.pos, .sight/2, .player)[0].AsUnit;
                        if(wolf.IsValid)
                        {
                                target.wm_wolf3 = wolf;
                                target.wm_wolf3.wolf_master = target;
                                target.wm_wolf3.AsUnit.SetUncontrollableFlag(true);
                        }
                }
                if (!target.wm_wolf4.IsAlive)
                {
                        Unit wolf;
                        wolf = Summon("Forester_GrayWolf", 1, target.pos, .sight/2, .player)[0].AsUnit;
                        if(wolf.IsValid)
                        {
                                target.wm_wolf4 = wolf;
                                target.wm_wolf4.wolf_master = target;
                                target.wm_wolf4.AsUnit.SetUncontrollableFlag(true);
                        }
                }
        } else
        if(target.class == "Forester_Werewolf")
        {
                .SetMana(cmdname, new_mana);
                target.Heal(target.GetMaxHealth()/3*2);
        }
        if(.queen_state == 1 && .GetAnim() != 0)
        {
                Sleep(.TimeToAnimFinish());
        }
//-----------------------------------------
//-----------------------------------------

