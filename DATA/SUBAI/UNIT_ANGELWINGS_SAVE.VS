// void, Obj This

Unit this;
Hero h;
point pt;
int time, heal;

this = This.AsUnit;

//_pr("Unit::AngelWings_save");

h = .salvation_owner.AsHero();

pt = GetSummonPt(.class, h.salvation_altar.pos, 150, .player);
if ( !pt.InRect(GetMapRect()) ) return;

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetEnemyCannotTargetFlag(true);
.SetNoselectFlag(true);

time = GetClassInt("Human_BattleAngel", "angelwings_anim_time");
CreateFeedback("data/particles/PainChannelingFairy.part.xml", this, time, true);
CreateFeedback("data/particles/PainChannelingFairy.part.xml", pt, time);
heal = .GetMaxHealth() * GetClassInt("Human_BattleAngel", "salvation_heal_percent") / 100;
        if (.reserved_obj6.IsAlive()) {
        .reserved_obj6.SetCommand("wait_for_death", this);
        .SetCantBeHealed(false);
        }
.SetHealth(heal);
Sleep(time);
.SetPos(pt);


.RemoveEffect("angelwings", 0, 0);

.SetCommand("stand_position");
