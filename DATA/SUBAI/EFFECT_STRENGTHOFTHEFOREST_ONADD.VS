// void, Unit this, int param1, int param2

int b, h;

b = GetClassInt("Forester_Townhall", "strength_of_the_forest_bonus"); 
h = .maxhealth * b / 100;
.SetMaxHealth(.GetMaxHealth() + h);
.damage = .damage + .initial_damage * b / 100;
