// void, Unit this

int j, slot, slot_count, cost, max_slots;
int cost_min, cost_delta;
str strSlotType;
Hero h;

slot_count = 4;
max_slots = 7;
cost_min = GetConst("HumanChampionEquipmentItemCostMin");
cost_delta = GetConst("HumanChampionEquipmentItemCostMax") - cost_min;

h = .AsHero();


if (h.IsValid())
{

while (h.IsGhost)
{
Sleep(500);
}
	
Sleep(100);

    slot = rand(slot_count);
    for ( j = 0; j < slot_count; j += 1 ) {
		slot = (slot + j) % slot_count;
		if ( !h.GetItem(slot).IsValid() ) break;
    }
    if ( j >= slot_count ) {
		for ( j = slot_count; j < max_slots; j += 1 ) {
			if ( !h.GetItem(j).IsValid() ) break;
		}
    } else {
		j = slot;
    }
    if ( j < max_slots ) {
		strSlotType = h.GetSlotType(slot);
		cost = cost_min + rand(cost_delta);
		h.CreateRandomItem(cost, j, strSlotType, "", "");
    }

}