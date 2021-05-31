// void, Obj me, ObjList ol

int i, humancnt, dmg, player;
Unit u, this;

this = me.AsUnit();
player = .player;

humancnt = 0;
for ( i = 0; i < ol.count; i += 1 ) {
	u = ol[i].AsUnit();
	if (u.IsAlive()) 
		if (u.defence_type=="small" && !u.IsHeirOf("Peaceful") && u.player == player) {
			humancnt += 1;
		}
}

dmg = .nobility_bonus * humancnt;
.damage = .damage - .last_damagebonus + dmg;
.last_damagebonus = dmg;