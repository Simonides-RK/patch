// void, Obj This

Hero this;

this = This.AsHero();

.ClearCustomAttackAnim();
.activated_glow = 0;
.activated_bash = -1;
.activated_death_blow = -1;
.glow_trans = 0;
.SetLayerTrans(2, 0);
if(.in_shelter.IsAlive())
{
	// restore the effect if we died in the shelter
	.AddEffect("unit_in_shelter", 0, 0);
}
.AddCommand(true, "fall");

if(.IsSkillAvailable("Revenge"))
	.AddCommand(true, "revenge_shockwave");
