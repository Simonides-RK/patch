// void, Obj This, ObjList ol

int i;
Unit u;
point pt;
Obj spirit;
Hero this;
int dmg; 
//_pr("fairy::onexit");
this = This.AsHero();
if(!(.IsSkillAvailable("Spiritualize") || .IsSkillAvailable("Forced_Empathy") || .IsSkillAvailable("Mind_Blend")) || .IsGhost())
{
        //_pr("fairy::onexit - spiritualization not active");
        return;
}

for(i = 0; i < ol.count; i += 1)
{
        u = ol[i].AsUnit();
        if(u.IsValid() && u.IsDead())
        {
                if(!.IsEnemy(u))
                {
                        if(.IsSkillAvailable("Spiritualize"))
                        if(u.class != "Forester_Spirit")
                        {
                                if ( !u.IsUncontrollable()) {
                                        .valid_for_spiritualization += .spiritualize_unit_value;
                                        if ( .ExistEffect("item_spirits_bonus") ) {
                                                .valid_for_spiritualization += .GetEffectParam("item_spirits_bonus", 1);
                                        }
                                        if(.valid_for_spiritualization >= .spiritualize_units_quota)
                                        {
                                                .valid_for_spiritualization -= .spiritualize_units_quota;
                                                pt = u.pos;
                                                if ( u.flying == 1 ) {
                                                        pt = PassablePointNear(u.pos, 300, 20, true);
                                                }
                                                if ( pt.InRect(GetMapRect()) ) {
                                                        spirit = Place("Forester_Spirit", pt, .player);
                                                } else {
                                                        .valid_for_spiritualization += .spiritualize_units_quota - .spiritualize_unit_value;
                                                }
                                        }
                                } else {
                                        .valid_for_spiritualization_uncontrollable += .spiritualize_unit_value;
                                        if ( .ExistEffect("item_spirits_bonus") ) {
                                                .valid_for_spiritualization_uncontrollable += .GetEffectParam("item_spirits_bonus", 1);
                                        }
                                        if(.valid_for_spiritualization_uncontrollable >= .spiritualize_units_quota_uncontrollable)
                                        {
                                                .valid_for_spiritualization_uncontrollable -= .spiritualize_units_quota_uncontrollable;
                                                pt = u.pos;
                                                if ( u.flying == 1 ) {
                                                        pt = PassablePointNear(u.pos, 300, 20, true);
                                                }
                                                if ( pt.InRect(GetMapRect()) ) {
                                                        spirit = Place("Forester_Spirit", pt, .player);
                                                } else {
                                                        .valid_for_spiritualization_uncontrollable += .spiritualize_units_quota_uncontrollable - .spiritualize_unit_value;
                                                }
                                        }
                                }
                                if ( spirit.IsValid() ) {
                                        if ( IsUpgradeAvailable(.player, "upgrade_SpiritInvisibility") ) {
                                                spirit.SetVisible(false);
                                        }
                                }
                        }
                        if(.IsSkillAvailable("Forced_Empathy") && u.killer.IsAlive())
                        {
                                //_pr("fairy::onexit - candidate for forced empathy");
                                PlaySound(u.killer.pos, "assets/sounds/HeroSkills/Forester Fairy/Fairy_Forced_Empathy.wav");
                                if(u.killer.AsUnit().IsValid())
                                {
                                        // feedback on units only
                                        CreateFeedback("ForcedEmpathy", u.killer.AsUnit(), .forced_empathy_duration, true);
                                dmg=.forced_empathy_damage;
                                if (.ExistEffect("item_forced_empathy_bonus")) dmg=dmg + .GetEffectParam("item_forced_empathy_bonus", 1);
                                 if(u.killer.AsHero().IsValid()) dmg=.forced_empathy_damage/3;
if (dmg>=u.killer.health) dmg=u.killer.health-1;
if (dmg>0) u.killer.Damage(this, dmg, false);}}
                                
                }
        }
        
        if ( u.IsValid() ) {
                if ( u.IsAlive() && .IsEnemy(u) ) {
                        if ( (.has_mind_blend != 0) && u.ExistEffect("mind_blend", this) ) {
                                u.RemoveEffect("mind_blend", 0, 0, this);
                        }
                }
        }
}
