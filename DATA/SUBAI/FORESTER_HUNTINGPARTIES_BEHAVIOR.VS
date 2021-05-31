// void, Obj This

int amount, last, count;
ObjList ol;

amount = GetConst("ForesterHuntingPartiesBonus");

last = 0;

while ( 1 ) {
	if ( IsUpgradeAvailable(This.player, "upgrade_HuntingParties") ) {
		ol = ClassPlayerObjs("Independent_Settlement", This.player, true).GetObjList();
		count = ol.count + 1; // add main settlement
		count -= last;
		last += count;
		count = count * amount;
		if ( count > 0 ) {
			SetResLimit(This.player, ResSupport, GetResLimit(This.player, ResSupport) + count);
			IncRes(This.player, ResSupport, count);
		} else if ( count < 0 ) {
			IncRes(This.player, ResSupport, count);
			SetResLimit(This.player, ResSupport, GetResLimit(This.player, ResSupport) + count);
		}
	}
	Sleep(1000);
}