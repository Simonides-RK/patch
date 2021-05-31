// void, Obj this

/* Add here in the derived classes any code that must be executed at the time the building is completed */
ParticleSystem ps;
Building b;
b = this.AsBuilding();
.IsConstructed=1;
if (.class=="Darkling_TempleOfNightfall" ) {
if (IsUpgradeAvailable(.player, "upgrade_Nightfall")) {
        ps = CreateParticleSystem("Data/Particles/Heal.part.xml");
        ps.SetPos(b.pos);
        ps.SetHeight(b.nightfall_ps_height);
        b.nightfall_ps = ps;
}
}