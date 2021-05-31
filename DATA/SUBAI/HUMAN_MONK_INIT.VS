//void, Obj this

.promotion_canceled = 0;
.heal_return_to_pos = 0;
.SetModalButton(.mb_heal);
.reserved_int0 = -1;

if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) .AsUnit().AddEffect("spiritual_blessing_effect", 0, 0);