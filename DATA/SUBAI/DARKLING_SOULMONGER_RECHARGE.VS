// void, Obj This

Hero this, h;
str cmdname, skill;
int new_mana, i, s;
ObjList ol;
bool bCharged;
int mana_add;
this = This.AsHero();

cmdname = "Recharge";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);


ol = Intersect(ObjsInSight(this, "Hero", false), FriendlyObjs(.player, "Hero", false)).GetObjList(); 

ol.Add(this);

for(i = 0; i < ol.count; i += 1)
{
        h = ol[i].AsHero();
        bCharged = false;

        if ( h.IsValid() && !h.IsGhost() ) {
                mana_add=0;
                for ( s = 0; s < 4; s += 1 ) { // don't use "GetSkillNumber" to handle case when only one 1st-level and a 2nd-level skills are developed 
                        skill = h.SkillName(s + 1);
                        if ( skill == "Recharge" ) continue; //Władysław Ańtian: Impossible to do it endlessly
                        if ( (h != this) || (skill != cmdname) ) {
                                mana_add=mana_add+(h.GetMaxMana(skill)-h.GetMana(skill));
                                h.SetMana(skill, h.GetMaxMana(skill));
                                bCharged = true;
                        }
                        h.SetHealth(h.GetMaxHealth);
                        if (mana_add>0) FloatingText(mana_add + Translate("[[ManaBurnPlus]] mana recovered[[]]") , h.pos, 0x66FFFF, 0);
                }
        }
        if ( bCharged ) {
                CreateFeedback("data/particles/Recharge.part.xml", h.pos, 1000);
                PlaySound(h.pos, "assets/sounds/HeroSkills/Darkling Soulmonger/Soulmonger_EnergyTide.wav");
        }
}
.SetMana(cmdname, new_mana);
.PlayAnim(AnimSpecial1);