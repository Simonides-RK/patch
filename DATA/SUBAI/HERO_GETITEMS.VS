// void, Obj This, Obj other

Hero this;
Item item;

int i, gl;

this = This.AsHero();

if ( !other.IsValid() ) return;

if(other.IsAlive())
{
        if(!.IsGhost())
        {
                while (!.Goto(other,GetConst("GiveDistance"),5000,true,5000));
        }
        else
        {
                if(.DistTo(other) > 500)
                {
                        while(!.GotoForm(other, 250, 2000, true));
                }
        }
        
        if(!.IsGhost() && other.IsAlive())
        {
                int newly_picked, items;

                items = other.item_count;
                newly_picked = .GetAllItemsFrom(other);
                if (newly_picked)
gl=EnvReadInt(.player, "Race_Elves");
                        if (gl > 0)
                                {


for(i = other.max_items - 1; i >= 0; i -= 1)
{
        item = other.GetItem(i);
        if(item.IsValid())
        {
                if(item.IsCharm())
                {
                       break;
                }               
        }
}

//                                        IncRes(.player, ResGlory, GetConst("Glory_PickItem")*newly_picked);
//FloatingText(item.cost,.pos,0xFFFFFF,0);
gl=EnvReadInt(.player, "Race_Elves");
gl=item.cost/2*gl;
if (gl<50) gl=50;
if (gl>750) gl=750;
                                          IncRes(.player, ResGlory, gl);

                                        CreateFeedbackForPlayer("Coin", other.pos, 1200, .player);
                                        CreateFeedbackForPlayer("CoinParticle", other.pos, .player);
                                }
                if (items == other.item_count) // Nothing picked up
                        UserNotification("Inventory full", "", Point(-1, -1), .player);
        }
}
