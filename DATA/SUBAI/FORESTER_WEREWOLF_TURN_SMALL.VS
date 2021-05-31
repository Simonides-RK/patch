//void, Obj me

Unit this;
int NewHealth;
//_pr("werewolf::turn_small");
this = me.AsUnit();
//Sleep(.TimeToAnimFinish());
if (.ExistEffect("Lycanthropy")) .RemoveEffect("Lycanthropy",1,15);
while(!.Stop(200));
.werewolf_state = 1;
.regeneration_started = false;
NewHealth=.state_small_max_health;
if (IsUpgradeAvailable(.player, "upgrade_Ferocity")) NewHealth += 300;
//if (IsUpgradeAvailable(.player, "upgrade_StrengthOfTheForest")) NewHealth = NewHealth*115/100;
if (IsUpgradeAvailable(.player, "upgrade_Lycanthropy")) NewHealth = NewHealth*115/100;
.SetMaxHealth(NewHealth);

.SetWalkAnim(AnimWalk1);
.SetUnitSounds(false);

.SetBlockCommand(true);
.PlayAnim(AnimSpecial4, .exact_pos);            
.SetBlockCommand(false);
