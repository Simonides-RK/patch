// void, Obj This

Hero this;
str cmdname;
int new_mana;
Unit u;
ObjList ol;
int i;

this = This.AsHero();

//_pr("battleangel::magicswords");

cmdname = "MagicSwords";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

ol = Intersect(Union(ObjsInSight(this, "Human_Paladin", false), ObjsInSight(this, "Human_Swordsman", false)), FriendlyObjs(.player, "Unit", true)).GetObjList();

if( ol.count == 0)
{
        UserNotification("common", Translate("[[25104181]]No Swordsmen or Paladins found for Magic Swords[[]]"), Point(-1, -1), .player);
}
else
{
        for(i = 0; i < ol.count; i += 1)
        {
                u = ol[i].AsUnit();
                if(u.IsValid())
                {
                  if (.IsSkillDeveloped("MagicExposure")) u.AddEffectTimeout("magicsword", .GetEffectParam("item_magicsword_bonus", 1), 50, .magicsword_duration); else u.AddEffectTimeout("magicsword", .GetEffectParam("item_magicsword_bonus", 1), 0, .magicsword_duration);
                }
        }
        .SetMana(cmdname, new_mana);
}

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
