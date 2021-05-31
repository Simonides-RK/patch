// void, Obj this

Query target;
int time_left;
int i;
Unit u;
.PlayAnim(AnimSpecial2);
target = EnemyObjsInRange(this, "Unit", .range, false);

if ( target.GetObjList().count > 0 ) {
        for(i = target.count() - 1; i >= 0; i -= 1){
                u = target[i].AsUnit();
                if(u.IsAlive())
                {
                if (u.flying==1) target.Remove(target[i]);
                if (u.class=="Human_WitchQueen" ) if (u.IsInAir()) target.Remove(target[i]);
                if (u.class=="Forester_Shaman") if (u.in_air==1) target.Remove(target[i]);
                
        
        }
}

time_left = .time_placed + .caltrop_duration - GetTime();
WaitNonEmptyQuery(target, time_left);

.PlayAnim(AnimSpecial3);
Sleep(500);

// play it here so if a dying sound occurs it will override it
PlaySound(.pos, "assets/sounds/HeroSkills/Human WindRider/WindRider_CaltropsExplosion.wav");

.StartAnim(AnimSpecial1);
Sleep(.TimeToActionMoment);

if ( target.GetObjList().count > 0 ) {
        target.GetObjList()[0].DamageWithNoAttacker(.caltrop_damage);
}

Sleep(.TimeToAnimFinish);

.Erase;
