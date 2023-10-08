// void, Obj me, Obj u

Unit this;
ParticleSystem ps;
ObjList ol;
int i;
Hero h;

this = me.AsUnit();
h = u.AsHero();

if ( !h.IsValid() ) {
	_pr("Disintegrate: invalid ObjParam!");
	return;
}

.SetBlockCommand(true); // no need to unblock it, as the unit dies anyways

ps = CreateParticleSystem("DisintegrationExplosion", this);
Sleep(200); // wait the ps to start anim
PlaySound(.pos, "assets/sounds/HeroSkills/Darkling Empath/Empath_FerventExplosion.wav");

.SetNoselectFlag(true); // Make it unselected
for ( i = 49; i >= 0; i -= 2 ) {
	.SetTranslucency(i*2);
	Sleep(8); // 400 ms for fade
}

Sleep(500);

ol = ObjsInCircle(.exact_pos, h.disintegration_range, "BaseGameObject", true).GetObjList();
ol.Remove(this);
for( i = 0; i < ol.count; i += 1 )
{
	if(ol[i].AsBuilding().IsAlive() || ol[i].flying == .flying)
	if (!ol[i].IsEnemy(h)) continue;
	{
		ol[i].Damage(h, h.disintegration_damage, false);
	}
}

	.Erase();