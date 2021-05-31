// void, Obj This

int amount, delay;

amount = GetConst("ColonyGoldAmount");
delay = GetConst("ColonyGoldDelay");

while (1) {
        Sleep(delay);
        if (This.player!=15 && amount!=0)
                {
                        SetResLimit(This.player, ResGold, 5000);
                        IncRes(This.player, ResGold, amount);
                        SetResLimit(This.player, ResGold, 3000);
                        FloatingText(Translate("[[]]+[[]]") + amount, This.pos, GetConst("GoldResColor"), This.player);
                }
}
