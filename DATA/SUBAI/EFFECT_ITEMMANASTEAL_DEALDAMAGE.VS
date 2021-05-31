// void, Unit this, Obj dest, int* damage, bool bDirectDamage, int param1, int param2, Obj oParam


Hero h;
int i;
Unit u; 
int diff;
u = dest.AsUnit(); 
if ( !u.IsAlive() || !bDirectDamage ) return;
if (!u.IsValid()) return;
if (!.IsEnemy(u)) return;
if (u.class=="Human_Shelter") return;
if(damage == 0) // we missed on invisible
        return;
if ( u.GetIllusionFlag() || (u.summoned_unit != 0) )  return;

h = .AsHero();
if ( h.IsValid() ) {
        for ( i = 0; i < .GetSkillNumber(); i += 1 ) {
                if (.GetMana(.SkillName(i + 1))>=.GetMaxMana(.SkillName(i + 1))) continue;
                .SetMana(.SkillName(i + 1), .GetMana(.SkillName(i + 1)) + param1);
                FloatingText(param1 + Translate("[[ManaBurnPlus]] Mana recovered[[]]") , .pos, 0x66FFFF, 0);
                break;
        }

}

if (rand(100)>50)
{
if ( u.AsHero().IsValid() ) {
u=u.AsHero();
        for ( i = 0; i < u.GetSkillNumber(); i += 1 ) {
                if (u.GetMana(u.SkillName(i + 1))< param1) continue;

                u.SetMana(u.SkillName(i + 1), u.GetMana(u.SkillName(i + 1)) - param1);
                FloatingText(diff + Translate("[[ManaBurnMinus]]Mana gained[[]]"), u.pos, GetConst("EnergyBurnDamageColor"), 0);
                break;
        }

} else {
if (u.AsUnit().IsValid) {
u=u.AsUnit();
        if (u.energy > param1) 
                diff = param1; 
        else 
                diff = u.energy; 
        if(diff > 1)
        {

                u.SetEnergy(u.energy - diff);
                FloatingText(diff + Translate("[[ManaBurnMinus]]Mana gained[[]]"), u.pos, GetConst("EnergyBurnDamageColor"), 0);
}}}}
