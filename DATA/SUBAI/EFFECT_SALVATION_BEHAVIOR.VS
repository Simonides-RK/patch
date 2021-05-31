// void, Unit this, int param1, int param2, Obj oParam

while ( 1 ) {
	if ( !.salvation_owner.IsValid() ) break;
	if ( !.salvation_owner.salvation_altar.IsAlive() ) break;
	
	Sleep(1000);
}

.RemoveEffect("salvation", param1, param2);
.salvation_owner.Clear();