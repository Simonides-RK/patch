// void, Obj This

int i;
Unit this;
bool InDen;
Query q;

InDen = false;

this = This.AsUnit();


if (IsUpgradeAvailable(.player, "upgrade_Lycanthropy")) {
.SetMaxHealth(.GetMaxHealth() + .GetMaxHealth()/100*15);
.AddEffect("Lycanthropy", 1, 15);
}
.scout_charges = 1;

if ( !.ExistEffect("illusion") ) {

        q = Intersect(ObjsInCircle(.pos, 50, "Forester_Den", false), ClassPlayerObjs("Forester_Den", .player, false));
        if (q.count > 0)
                InDen = true;

        if(.wm_wolf1.IsDead())
        {
                if (InDen)
                        .wm_wolf1 = Place("Forester_GrayWolf", .pos, .player).AsUnit;
                else
                        .wm_wolf1 = Summon("Forester_GrayWolf", 1, .pos, .sight/2, .player)[0].AsUnit;
                if(.wm_wolf1.IsAlive())
                {               
                        .wm_wolf1.wolf_master = this;
                        .wm_wolf1.AsUnit().SetUncontrollableFlag(true);
                }
        }
        if(.wm_wolf2.IsDead())
        {
                if (InDen)
                        .wm_wolf2 = Place("Forester_GrayWolf", .pos, .player).AsUnit;
                else
                        .wm_wolf2 = Summon("Forester_GrayWolf", 1, .pos, .sight/2, .player)[0].AsUnit;
                if(.wm_wolf2.IsAlive())
                {
                        .wm_wolf2.wolf_master = this;
                        .wm_wolf2.AsUnit().SetUncontrollableFlag(true);
                }
        }
        if(.wm_wolf3.IsDead())
        {
                if (InDen)
                        .wm_wolf3 = Place("Forester_GrayWolf", .pos, .player).AsUnit;
                else
                        .wm_wolf3 = Summon("Forester_GrayWolf", 1, .pos, .sight/2, .player)[0].AsUnit;
                if(.wm_wolf3.IsAlive())
                {
                        .wm_wolf3.wolf_master = this;
                        .wm_wolf3.AsUnit().SetUncontrollableFlag(true);
                }
        }

}

if(IsUpgradeAvailable(.player, "upgrade_KnifeThrowing"))
{
        .SetCustomAttackAnim(AnimAttack2);
}
else
{
        .SetRange(.init_close_combat_range);
        .SetDisableRangedAttack(true);
        .SetCustomAttackAnim(AnimAttack1);
}

if(IsUpgradeAvailable(.player, "upgrade_Bloodlust")) .SetAttackSpeedFactor(.attack_speed_factor + .attack_speed_factor/4);
