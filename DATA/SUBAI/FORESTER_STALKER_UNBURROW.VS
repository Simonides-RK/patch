// void, Obj this

.SetMana("Burrow", 0);
SetFlag(.user_flags1, .cant_be_stunned, true);
.SetVisible(true);
.burrowed = 0;
.SetBlockCommand(true);
.PlayAnim(AnimSpecial2);
.SetDeadAnim(AnimDie);
.SetSight(.sight);

