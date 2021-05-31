// void, Obj me
ParticleSystem ps;
ps = CreateParticleSystem("Data/Particles/Heal.part.xml");
ps.SetPlayer(me.player);
ps.SetPos(me.pos);
//while(me.mage_tower.magic_area_charge > 0 && me.mage_tower.magic_area == me)
while(me.magic_area_charge > 0)
{
        Sleep(1000);
        if(!me.mage_tower.IsAlive)
                break;
}
ps.StopEmitters;
Sleep(400);
ps.Erase;
me.Erase;