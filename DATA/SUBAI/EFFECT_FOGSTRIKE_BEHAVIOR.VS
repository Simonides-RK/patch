// void, Unit this, int param1, int param2, Obj oParam

while( 1 ) {
	if ( !oParam.IsValid() ) break;
	Sleep(1000);
}

.RemoveEffect("fog_strike", param1, param2, oParam);

Sleep(10000);

.RemoveEffect("fog_strike", 0, 0, this);