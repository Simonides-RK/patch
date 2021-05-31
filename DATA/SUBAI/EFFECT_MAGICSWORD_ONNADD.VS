// void, Unit this, int param1, int param2

//_pr("effect_magicswords::onadd");
.damage = .damage + (.initial_damage * param1)/100 + (.initial_damage * param2)/100;
.SetDisableRangedAttack(false);
.SetRange(.range);
if(.class == "Human_Swordsman" || .class == "Human_Paladin")
        .SetCustomAttackAnim(AnimSpecial1);