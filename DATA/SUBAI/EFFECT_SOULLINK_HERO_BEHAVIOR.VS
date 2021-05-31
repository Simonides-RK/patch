// void, Unit this, int param1, int param2, Obj oParam

Unit u;
ParticleSystem psChain;
int time, speed, total_time, change_description_back_time;
rect map_rect;
map_rect = GetMapRect;
u = oParam.AsUnit();
change_description_back_time = -1;

if ( !u.IsValid() ) {
        _pr("SoulLink_hero behavior: invalid parameter");
        return;
}

psChain = CreateParticleSystem("data/particles/SoulLinkOnDamage.part.xml");
psChain.SetCommand("selfdestruct", this);
psChain.Chain(this);
psChain.SetHeight(-45);
change_description_back_time = GetTime + 100;
.reserved_int8=1;
while ( u.IsAlive() && .reserved_int8==1) 
{
        if(.IsDead)
                break;
        if(!.pos.InRect(map_rect))
                break;
        if(!u.pos.InRect(map_rect))
                break;
        if(.DistTo(u.pos) > .sight)
                break; 
        if(.health < .GetMaxHealth() * .soullink_minhealth / 100)
                break;
        if(.reserved_obj4 == u)
        {
                change_description_back_time = GetTime + 100;
                psChain.SetPartDesc("data/particles/SoulLinkOnDamage.part.xml");
                .reserved_obj4 = invalid_obj;
        } else
        if(change_description_back_time != -1 && GetTime > change_description_back_time)
        {
                psChain.SetPartDesc("data/particles/SoulLink.part.xml");
                change_description_back_time = -1;
        }               
        psChain.SetPos(u.exact_pos);
        Sleep(50);
}
psChain.Erase();
if ( oParam.AsUnit.IsAlive() ) {
        if ( oParam.AsUnit.ExistEffect("soullink", this) ) {
                oParam.AsUnit.RemoveEffect("soullink", param1, param2, this);
        }

        if (.AsUnit.ExistEffect("soullink_hero", oParam))  .AsUnit.RemoveEffect("soullink_hero", param1, param2, oParam);

}
