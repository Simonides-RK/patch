// void, Obj this

int nAnimTime, nSleep, nTime;

nAnimTime = .GetAnimDuration(AnimSpecial4);
nSleep = 5;

while(1)
{
        if(.die_asap == 1)
        {
                .DropDead();
                return;
        }
        .StartAnim(AnimSpecial4);
        for(nTime = 0; nTime < nAnimTime / 2; nTime += nSleep)
        {
                .the_hero.SetLayersZOffset(.hero_z_on_top + (.hero_z_on_bottom - .hero_z_on_top) * 2 * nTime / nAnimTime);
                Sleep(nSleep);
        }
        for(nTime = 0; nTime < nAnimTime / 2; nTime += nSleep)
        {
                .the_hero.SetLayersZOffset(.hero_z_on_bottom + (.hero_z_on_top - .hero_z_on_bottom) * 2 * nTime / nAnimTime);
                Sleep(nSleep);
        }       
if (.the_hero.health+2 < .the_hero.GetMaxHealth()) {.the_hero.SetHealth(.the_hero.health + 2);
}else{
if (.the_hero.health < .the_hero.GetMaxHealth()) .the_hero.SetHealth(.the_hero.GetMaxHealth());
}
}