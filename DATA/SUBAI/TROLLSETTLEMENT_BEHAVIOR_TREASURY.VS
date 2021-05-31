// void, Obj This
Obj this;
int reslimit;
this = This;

while(!.IsSkillDeveloped("Deep_Gold_Mine"))
	Sleep(10000);

while(1)
{
	while(.GetMana("Deep_Gold_Mine") < .GetManaCost("Deep_Gold_Mine")) Sleep(3000);
	.SetMana("Deep_Gold_Mine", .GetMana("Deep_Gold_Mine") - .GetManaCost("Deep_Gold_Mine"));
	
	PlaySound(.pos, "assets/sounds/IndependentRaceSpecials/Trolls/Troll_treasury.wav");
	reslimit = GetResLimit(.player, ResGold);
	SetResLimit(.player, ResGold, 8000);
	SetRes(.player, ResGold, GetRes(.player, ResGold)*(100+.gold_mine_percent)/100);
	SetResLimit(.player, ResGold, reslimit);
}