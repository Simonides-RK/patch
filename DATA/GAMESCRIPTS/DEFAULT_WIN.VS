//void, int player
int i;

Sleep(3000);

while(1)
{
	if (ClassPlayerObjs("BaseTownhall", player, false).IsEmpty)
	{
		break;
	}
	Sleep(3000);
}
EndGame(player, true);
for(i = 1; i <= 8; i+=1)
{
DiplShareView(player,i,false);
}
SetNoFog(player, true);
ExploreAll(player);


