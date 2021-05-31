// void, Obj this

point pt;
int i;
Obj wolf;

.number_wolves = .max_number_wolves;
for(i = 0; i < .number_wolves; i += 1)
{
        pt = GetSummonPt("Forester_WhiteWolf", .pos, 200, .player);
        wolf = Place("Forester_WhiteWolf", pt, .player);
        CreateFeedback("data/particles/summon.part.xml", wolf, 1000, true);
        wolf.SetMaxHealth(wolf.maxhealth + .AsUnit().GetEffectParam("item_moon_bonus", 1));
        wolf.queen_of_the_wolves = this;
        wolf.AsUnit().SetUncontrollableFlag(true);
        if(.IsSkillAvailable("Ghost_Wolves"))
        {
                wolf.SetVisible(false);
                wolf.SetMaxHealth(wolf.maxhealth + .AsUnit().GetEffectParam("item_moon_bonus", 1) + .ghost_wolves_health_bonus);
        }
}

