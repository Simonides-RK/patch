// void, Obj this

int nTime, nBuiltTime, nZOnTop, nZOffsetToReach, nSleep;

nBuiltTime = .GetAnimDuration(1);
nZOffsetToReach = 0;
nSleep = 25;
nZOnTop = GetClassInt("Human_WizardOfTheBow_CrystalTower", "hero_z_on_top");

.StartAnim(1);
if(.hero_of_the_dead.teleported_on_tower != 1)
{
	for(nTime = 0; nTime < nBuiltTime; nTime += nSleep )
	{
		.hero_of_the_dead.SetLayersZOffset(nZOnTop + (nZOffsetToReach - nZOnTop) * nTime / nBuiltTime);
		Sleep(nSleep);
	}
}
.hero_of_the_dead.SetLayersZOffset(nZOffsetToReach);

if(.hero_of_the_dead.IsValid())
{
	if(.hero_of_the_dead.on_crystal_tower == 1)
	{
		.hero_of_the_dead.AsUnit().SetCantAddEffect(false);
		if(.hero_of_the_dead.AsUnit().ExistEffect("absorb_damage"))
		{
			.hero_of_the_dead.AsUnit().RemoveEffect("absorb_damage", 100, 0);
			.hero_of_the_dead.AsUnit().RemoveEffect("wizard_on_crystal_tower", 0, 0); //Władysław Ańtian: remove stun
		}
		.hero_of_the_dead.on_crystal_tower = 0;
		.hero_of_the_dead.SetLayerTrans(GetClassInt("Human_WizardOfTheBow", "shadow_layer"), 100);
		if(.hero_of_the_dead.teleported_on_tower != 1)
		{
			.hero_of_the_dead.SetBlockCommand(false);
		}
		.hero_of_the_dead.teleported_on_tower = 0;
		SetFlag(.hero_of_the_dead.user_flags1, .hero_of_the_dead.cant_be_stunned, false);
		.hero_of_the_dead.SetRange(.hero_of_the_dead.GetRange() - .hero_of_the_dead.crystal_tower_range_inc);
		if(.hero_of_the_dead.AsHero().IsGhost())
		{
			.hero_of_the_dead.restore_sight_on_ressurect = 1;
		}
		else
		{
			.hero_of_the_dead.AsUnit().SetEnemyCannotTargetFlag(false);
			.hero_of_the_dead.restore_sight_on_ressurect = 0;
			.hero_of_the_dead.SetSight(.hero_of_the_dead.GetSight() - .hero_of_the_dead.crystal_tower_range_inc);
		}
		.hero_of_the_dead.SetMinRange(.hero_of_the_dead.min_range);
		.hero_of_the_dead.damage -= .hero_of_the_dead.crystal_tower_dmg_inc;
		.hero_of_the_dead.SetMana("Crystal_Tower", 0);
	}
}

if(.GetAnim())
{
	Sleep(.TimeToAnimFinish());
}

.Erase();