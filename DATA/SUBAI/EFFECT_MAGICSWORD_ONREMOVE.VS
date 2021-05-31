// void, Unit this, int param1, int param2

//_pr("effect_magicswords::remove");

if ( !.IsAlive() ) return;
.damage = .damage - (.initial_damage * param1)/100 - (.initial_damage * param2)/100;
.SetDisableRangedAttack(true);
.SetRange(GetClassInt("Unit", "range"));
.ClearCustomAttackAnim();