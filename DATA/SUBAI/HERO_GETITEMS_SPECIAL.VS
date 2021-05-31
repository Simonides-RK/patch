// void, Obj This, Obj other

Unit this;
point pt;
Item item;

int i, gl;

//_pr("getitems_special");

this = This.AsUnit();

if(.AsHero.IsValid)
if(.AsHero.IsGhost)
{
        UserNotification("common", Translate("[[25091305]]Can't pick up items from the ground when ghost[[]]"), Point(-1, -1), .player);
        return;
}

if ( other.item_count == 0 ) return;

if (other.IsAlive())
{
        //while (!.Goto(other,GetConst("GiveDistance"),5000,true,5000));
        
        pt = other.GetEntityPointByIndex(1, 0);
        while ( !.GotoEnter(pt, 0, 2000, false, -1) );
        
        if (other.IsAlive())
        {
                int newly_picked, items;

                items = other.item_count;
                newly_picked = .GetAllItemsFrom(other);
                
                if (newly_picked)
                        if (EnvReadInt(.player, "Race_Elves") > 0)
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
                else {
                        other.SetLayerTrans(2, 0);
                }
        }
}
