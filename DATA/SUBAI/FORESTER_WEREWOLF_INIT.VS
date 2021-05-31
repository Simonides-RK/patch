//void, Obj me

Unit this;this=me.AsUnit(); .regeneration_started = true;
.werewolf_state = 2;
.SetMaxHealth(.state_big_max_health);
.SetWalkAnim(AnimWalk2);

if(IsUpgradeAvailable(.player, "upgrade_Ferocity")) .armor += GetClassInt("Forester_Werewolf", "ferocity_armor_bonus");

