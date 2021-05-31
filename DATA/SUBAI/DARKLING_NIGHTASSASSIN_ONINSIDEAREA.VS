// void, Obj me, ObjList ol

Hero this, h;
int i;
Unit u; 

this = me.AsHero();

// following prevents from double-marking units, which entered area around the
// hero just when the skill was developed:
if ( .cloudofdarkness_justdeveloped == 0 ) return;

for ( i = 0; i < ol.count; i += 1)
{
        u = ol[i].AsUnit();
        if( u.IsAlive() )
        {
                if ( .IsSkillAvailable("Cloud_of_Darkness") ) 
                        if (!u.ExistEffect("Cloud_of_Darkness") && u.class!="Darkling_AngelOfDeath") u.AddEffect("Cloud_of_Darkness",50,0);
        }
        h = u.AsHero();
        if(h.IsValid())
        {
                if(h.IsGhost())
                {
                        // missed as unit because ghost is not alive anymore
                        if(.IsSkillAvailable("Cloud_of_Darkness"))
                        {
                                if (!h.ExistEffect("Cloud_of_Darkness")) h.AddEffect("Cloud_of_Darkness",50,0);
                        }
                        else
                        {
                                if (!h.ExistEffect("Cloud_of_Darkness")) h.RemoveEffect("Cloud_of_Darkness",50,0);
                        }
                }
        }
}

.cloudofdarkness_justdeveloped = 0;