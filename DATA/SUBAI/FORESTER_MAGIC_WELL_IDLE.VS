// void, Obj this

int amount, delay;

amount = GetConst("ForesterMagicWellGemsAmount");
delay = GetConst("ForesterMagicWellGemsDelay");

while (1) {
	Sleep(delay);
	IncRes(.player, ResGems, amount);
	FloatingText(Translate("[[]]+[[]]") + amount, .pos, GetConst("GemsResColor"), .player);
}
