// void, Obj This, point pt

Unit this;
Obj o;
str id, cur;
int nLen, i;
point tmpPt, ptVector;

this = This.AsUnit();
if (!IsPassable(.pos)) if (.flying!=1){
ptVector=.pos-pt; nLen = ptVector.Len();
        for (i=10; i<=nLen; i+=10){
                ptVector.SetLen(i);
                tmpPt=PassablePointNear(.pos-ptVector, 80, 3, true);
                if(tmpPt.x != -1 && tmpPt.y != -1) {.GotoStraight(tmpPt, true); break;}}}
i = .collector_id;
id = "/_CollectedSouls_" + i;

while (!.GotoForm(pt, 0, 1000, false))
{
        if(.souls_collected >= .max_souls)
                continue;
        o = SearchCorpse(.pos, .sight, -1);
        if(o.IsValid)
        {
                cur = EnvReadString(id);
                if(cur == "")
                        EnvWriteString(id, o.class);
                else
                        EnvWriteString(id, cur + "," + o.class);
                .souls_collected += 1;
                o.Erase;
                
                // Ivko: This code stinks. And it prinks, ermm, prints! I removed it because it will 
                // be changed anyway when the souls start to creepily crawls towards the Soul Collector...
                /*.SetBlockCommand(true);
                .SetWalkAnim(AnimSpecial2);
                if(.GotoForm(pt, 0, .TimeToAnimFinish, false))
                {
                        .SetBlockCommand(false);
                        return;
                }
                .SetWalkAnim(AnimWalk1);
                .SetBlockCommand(false);*/
        }
}
