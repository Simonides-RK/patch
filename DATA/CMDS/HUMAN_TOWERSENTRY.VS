// void, Obj this

ParticleSystem ps;
Building b;

b = .AsBuilding();
if ( !b.IsValid() ) return;
if ( !b.IsAlive() ) return;

.SetRevealer(true);
.SetSight(.sight+300);
.SetRange(.range+100);
ps = CreateParticleSystem("AllSeeingEye_Building", this);
ps.SetHeight(-210);

b.sentry_ps = ps;
