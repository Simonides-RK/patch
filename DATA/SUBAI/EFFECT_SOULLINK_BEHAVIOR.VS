// void, Unit this, int param1, int param2, Obj oParam

Hero h;
rect map_rect;

map_rect = GetMapRect;

h = oParam.AsHero();

if ( !h.IsValid() ) {
        _pr("SoulLink_behavior: invalid parameter");
        return;
}

while ( oParam.IsAlive()) {
        if(!oParam.pos.InRect(map_rect))
                break;
        if(.DistTo(oParam) > h.sight)
                break;
        Sleep(321);
}

.RemoveEffect("soullink", param1, 0, oParam);

