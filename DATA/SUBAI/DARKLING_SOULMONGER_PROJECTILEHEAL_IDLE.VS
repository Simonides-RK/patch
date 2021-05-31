// void, Obj me

ParticleSystem this;

this = me.AsParticleSystem();
Sleep(.proj_time);
.StopEmitters();
Sleep(2000);
.Erase();