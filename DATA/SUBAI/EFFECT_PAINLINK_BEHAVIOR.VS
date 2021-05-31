// void, Unit this, int param1, int param2, Obj oParam

Hero h, me;
ParticleSystem ps1, ps2;
int time;

h = oParam.AsHero();
me = .AsHero();

//_pr("PainLink_behavior");

if ( !h.IsValid() ) {
	_pr("PainLink_behavior: invalid parameter");
	return;
}

if ( Darkling_NightAssassin.IsValid() ) {
	_pr("PainLink_behavior: invalid parameter");
	return;
}

ps1 = CreateParticleSystem("data/particles/PainLink.part.xml");
ps1.SetHeight(-40);
ps1.Chain(oParam);

while ( !me.IsGhost() && !h.IsGhost() && (.pos.Dist(oParam.pos) <= h.sight) && me.IsSkillAvailable("PainLink") ) {
	ps1.SetPos(.exact_pos);
	Sleep(50);
}

//_pr("PainLink_behavior: exit");

ps1.StopEmitters();
ps1.Erase();

.RemoveEffect("painlink", 0, 0, oParam);