// void, Obj me, Obj target

Hero this;
Unit u;
Item item;
str cmdname;
int new_mana, i, slot;
point ptdir;

this = me.AsHero();
u = target.AsUnit();

if ( !u.IsValid() ) {
	_pr("mindblaze: selectverify selected invalid target!");
	return;
}

cmdname = "MindBlaze";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
} 

if ( .DistTo(u) > .sight ) {
	while ( !.Goto(u, .sight, 500, false, 500) );
}
.Face(target);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
	Sleep(.TimeToActionMoment());
}

if(u.IsAlive())
{
	CreateFeedback("MindBlaze", u, 1000, true);
	PlaySound(u.pos, "assets/sounds/HeroSkills/Darkling Empath/Empath_MindBlaze.wav");
	if ( u.item_count > 0 && rand(100) < .mindblaze_drop_chance) {
		ptdir = Point(50, 0);
		ptdir.Rot(rand(360));
		slot = rand(u.max_items);
		for ( i = 0; i < u.max_items; i +=1 ) {
			item = u.GetItem((slot + i) % u.max_items);
			if(item.IsValid() && !u.GetNoRandomItemFlag() )
			{
				point pt;
				
				pt = PassablePointNear(u.pos + ptdir, 100, 10, true);
				if(pt.x != -1 && pt.y != -1)
				{
					u.DropItem(item, pt);
					break;
				}
			}
		}
	}
	u.InsertCommand("stun");
	if (u.AsHero().IsValid())
		{
		u.Damage(this, u.GetMaxHealth() * .mindblaze_damage_hero / 100), false);
		} else {
		u.Damage(this, u.GetMaxHealth() * .mindblaze_damage / 100), false);
		}
}

if(.GetAnim())
{
	Sleep(.TimeToAnimFinish());
}

// finally:
if(rand(100) > .GetEffectParam("item_mind_blaze_bonus", 1))
{	
	.SetMana(cmdname, new_mana);
}
