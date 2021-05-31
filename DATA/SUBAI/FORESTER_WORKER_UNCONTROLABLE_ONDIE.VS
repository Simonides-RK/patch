//void, Obj This , Obj oAttacker

Obj b;
int glory_to_return;
Unit this;

this = This.AsUnit();
b = .new_building;

if (b.IsValid() && !b.IsBuilt())
	{
	
	
	

	IncRes(.player, ResGold,    GetCost(b.cost, ResGold   ));
	IncRes(.player, ResGems,    GetCost(b.cost, ResGems   ));
	IncRes(.player, ResSupport, GetCost(b.cost, ResSupport));
	if( b.IsHeirOf("Forester_Mage_Tower"))
	{
		if(b.glory_cost > 0)
		{
			glory_to_return = EnvReadInt(.player, "Houses_Built") * ResGloryFactor;
	
			EnvWriteInt(.player, "Houses_Built", glory_to_return / ResGloryFactor - 1);
			IncRes(.player, ResGlory, glory_to_return);
		}
	}
	b.SetCommand("oncancelbuild");
}



