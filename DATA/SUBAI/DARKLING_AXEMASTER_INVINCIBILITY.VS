// void, Obj This

Hero this;
str cmdname;
int new_mana;
ObjList ol;

this = This.AsHero();
cmdname = "Invincibility";

new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana >= 0)
{
	.SetMana(cmdname, new_mana);
} 
else
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

if(.ExistEffect("possessed"))
{
	ol = ObjsInRange(this, "Forester_Spirit", 3, true).GetObjList();
	if(ol.count() == 1)
	{
		ol[0].SetCommand("wait_for_death", this);
	}
	else
	{
		if(ol.count() > 1)
		{
			_pr("Impossible two sprites to infect a single unit");
		}
	}
}
PlaySound(.pos, "assets/sounds/HeroSkills/Darkling Axemaster/Axemaster_Invincibility.wav");
.AddEffectTimeout("invincibility_axemaster", -1, -1, .invincibility_timeout+.GetEffectParam("item_invincibility_bonus", 1)*1000);

