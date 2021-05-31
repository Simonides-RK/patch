//bool, Obj this, Obj other
if(other.IsValid())
{
if(.modal_button != .mb_channeling) if (other.class=="Human_Shelter") return false;
if(.modal_button == .mb_vitalize)
        {
                return !.IsEnemy(other) && other.energy < other.GetMaxEnergy() && other.class != "Forester_Shaman" && !IsFlagSet(other.user_flags1, other.to_be_vitalized);
        }
        if(.modal_button == .mb_fatigue)
        {
                return  .IsEnemy(other) && .IsValidTarget(other) && other.energy > 0 && !IsFlagSet(other.user_flags1, other.to_be_fatigued);
        }
        if(.modal_button == .mb_channeling)
        {
                return .IsEnemy(other) && .IsValidTarget(other);
        }
}
                 
return false;
