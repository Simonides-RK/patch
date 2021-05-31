//void, Obj me

Unit this;
int NewHealth;
//_pr("werewolf::turn_big");
this = me.AsUnit();
//Sleep(.TimeToAnimFinish());
while(!.Stop(200));
.werewolf_state = 2;
NewHealth=.state_big_max_health;
if(IsUpgradeAvailable(.player, "upgrade_Ferocity")) NewHealth += 300;
//if (IsUpgradeAvailable(.player, "upgrade_StrengthOfTheForest")) NewHealth = NewHealth+NewHealth/100*15;
if (IsUpgradeAvailable(.player, "upgrade_Lycanthropy")) {
        NewHealth = NewHealth*115/100;
        if (!.ExistEffect("Lycanthropy")) .AddEffect("Lycanthropy", 1, 15);
}
.SetMaxHealth(NewHealth);
.SetWalkAnim(AnimWalk2);
.SetUnitSounds(true);

.SetBlockCommand(true);
.PlayAnim(AnimSpecial1, .exact_pos);            
.SetBlockCommand(false);
