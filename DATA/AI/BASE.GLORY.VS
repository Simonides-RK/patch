//void, int nPlayer, Obj oBase

StrArray aHousesBuildlists, aHeroes, aHeroesBuildList;
int nHeroes, n;
Gaika gaika;
int nChoice, level, skill_cost;
int nHouses, nStartTime;
str hero_buildup_buildlist, skill;
Obj target_colony;
bool bQueen, bSeedkeeper;
Hero h;
ObjList heroes_list;
str house_class;
int next_hero_creation_time, next_hero_develop_time;
int goldAdd, gemAdd, gloryAdd;
int heroes, new_heroes_glory_spent, specials_glory_spent, houses_glory_spent;
int heroes_and_skills_glory_perc, hero_specials_glory_open, new_heroes_glory_spent_perc;
int heroes_glory;
int sleep_time;
int i, glory_spent_update_time;
nHeroes = 0;
if(oBase.class == "Darkling_Townhall")
{
        aHousesBuildlists[0]  = "";
        aHousesBuildlists[1]  = "upgrade_SoulBond";
        aHousesBuildlists[2]  = "upgrade_SoulBond";
        aHousesBuildlists[3]  = "upgrade_SoulBond";
        aHousesBuildlists[4]  = "upgrade_SoulBond";
        aHousesBuildlists[5]  = "upgrade_SoulBond";
        aHousesBuildlists[6]  = "upgrade_SoulBond";
        aHousesBuildlists[7]  = "upgrade_SoulBond";
        
        nHeroes = 4;
        aHeroes[0]                      = "Darkling_Axemaster";
        aHeroesBuildList[0] = "train_Axemaster";
        aHeroes[1]                      = "Darkling_Soulmonger";
        aHeroesBuildList[1] = "train_Soulmonger";
        aHeroes[2]                      = "Darkling_NightAssassin";
        aHeroesBuildList[2] = "train_NightAssassin";
        aHeroes[3]                      = "Darkling_Empath";
        aHeroesBuildList[3] = "train_Empath";

} else
if(oBase.class == "Human_Townhall")
{
        aHousesBuildlists[0]  = "";
        aHousesBuildlists[1]  = "human.start.1house.bl";
        aHousesBuildlists[2]  = "human.start.2houses.bl";
        aHousesBuildlists[3]  = "human.start.3houses.bl";
        aHousesBuildlists[4]  = "human.start.4houses.bl";
        aHousesBuildlists[5]  = "human.start.5houses.bl";
        aHousesBuildlists[6]  = "human.start.6houses.bl";
        aHousesBuildlists[7]  = "human.start.7houses.bl";
        house_class = "Human_SupportBuilding";
        
        nHeroes = 4;
        aHeroes[0]                      = "Human_BattleAngel";
        aHeroesBuildList[0] = "train_BattleAngel";
        aHeroes[1]                      = "Human_WizardOfTheBow";
        aHeroesBuildList[1] = "train_WizardOfTheBow";
        aHeroes[2]                      = "Human_WitchQueen";
        aHeroesBuildList[2] = "train_WitchQueen";
        aHeroes[3]                      = "Human_WindRider";
        aHeroesBuildList[3] = "train_WindRider";

} else
if(oBase.class == "Forester_Townhall")
{
        aHousesBuildlists[0]  = "";
        aHousesBuildlists[1]  = "forester.start.1house.bl";
        aHousesBuildlists[2]  = "forester.start.2houses.bl";
        aHousesBuildlists[3]  = "forester.start.3houses.bl";
        aHousesBuildlists[4]  = "forester.start.4houses.bl";
        aHousesBuildlists[5]  = "forester.start.5houses.bl";
        aHousesBuildlists[6]  = "forester.start.6houses.bl";
        aHousesBuildlists[7]  = "forester.start.7houses.bl";
        house_class = "Forester_Mage_Tower";
        
        nHeroes = 4;
        aHeroes[0]                      = "Forester_Fairy";
        aHeroesBuildList[0] = "train_Fairy";
        aHeroes[1]                      = "Forester_Stalker";
        aHeroesBuildList[1] = "train_Stalker";
        aHeroes[2]                      = "Forester_QueenOfTheWolves";
        aHeroesBuildList[2] = "train_Queen";
        aHeroes[3]                      = "Forester_Sharpshooter";
        aHeroesBuildList[3] = "train_Sharpshooter";
}

glory_spent_update_time = 0;
nStartTime = GetTime();
nHouses = 0;
heroes = 0;
new_heroes_glory_spent = 0;
specials_glory_spent = 0;
houses_glory_spent = 0;
bQueen = false;
bSeedkeeper = false;

sleep_time = AIGetConst(nPlayer, "GloryResponseTime");
heroes_and_skills_glory_perc = AIGetConst(nPlayer, "HeroesAndSkillGlorySpendPerc");
hero_specials_glory_open = AIGetConst(nPlayer, "HeroesGlorySpendOnOpen");
new_heroes_glory_spent_perc = AIGetConst(nPlayer, "NewHeroesGlorySpentPerc");

next_hero_develop_time = -1;
next_hero_creation_time = -1;
Sleep(5000);    

gloryAdd=AIGetConst(nPlayer, "GloryInMinute")/6;
goldAdd =AIGetConst(nPlayer, "GoldInMinute") /6;
gemAdd  =AIGetConst(nPlayer, "GemInMinute")  /6;

while (oBase.IsAlive()) {

IncRes(nPlayer, ResGlory, gloryAdd);
IncRes(nPlayer, ResGold, goldAdd);
IncRes(nPlayer, ResGems, gemAdd);
        Sleep(sleep_time);      

        if(GetTime() >= glory_spent_update_time) // see if we have new heroes or skills given by the higher power
        {
                n = AIHeroes(nPlayer, true).count*2;
                if(n > new_heroes_glory_spent)
                        new_heroes_glory_spent = n;
                n = AIHeroesSkillsCost(nPlayer, true);
                if(n > specials_glory_spent)
                        specials_glory_spent = n;
                if(oBase.class == "Darkling_Townhall")
                        n = EnvReadInt(nPlayer, "Max_Soulwatchers");
                else
                        n = ClassPlayerObjs(house_class, nPlayer, false).GetObjList.count;
                n = n * (n+1) / 2;
                if(n > houses_glory_spent)
                        houses_glory_spent = n;
                glory_spent_update_time = GetTime()+60000;
        }

        ailog("<yellow>heroes glory spent : <white>" + (new_heroes_glory_spent + specials_glory_spent), nPlayer);
        ailog("<yellow>houses glory spent : <white>" + houses_glory_spent, nPlayer);
        
        if(GetTime < next_hero_creation_time)   
        if(GetTime < next_hero_develop_time)    
        if(nHouses == 7)
        {
                Sleep(30000);
                ailog("<red>cant spent glory", nPlayer);
        }
        

        heroes_glory = new_heroes_glory_spent + specials_glory_spent - hero_specials_glory_open;
        // examine how much glory has been spent on houses and heroes
        if((nHouses == 7) || 
                (heroes_glory * (100 - heroes_and_skills_glory_perc) < houses_glory_spent * heroes_and_skills_glory_perc && (GetTime > next_hero_creation_time || GetTime > next_hero_develop_time)))
        {
        // its time to spent some glory on heroes
                heroes_list = AIHeroes(nPlayer, false);
                if((new_heroes_glory_spent * (100 - new_heroes_glory_spent_perc) <= specials_glory_spent * new_heroes_glory_spent_perc || GetTime < next_hero_develop_time) && GetTime > next_hero_creation_time)
                {
                        int unavailable_heroes;
                        unavailable_heroes = 0;
                        for(i = 0; i < nHeroes; i+=1)
                        {
                                if(heroes_list.FilterClass(aHeroes[i]).count != 0)              
                                        unavailable_heroes += 1;
                                if(IsCmdDisabled(aHeroesBuildList[i], nPlayer))
                                        unavailable_heroes += 1;
                        }
                        nChoice = rand(nHeroes-unavailable_heroes);
                        if(nHeroes > unavailable_heroes)
                        {
                                for(i = 0; i < nHeroes; i+=1)
                                {
                                        if(heroes_list.FilterClass(aHeroes[i]).count != 0)              
                                                continue;
                                        if(IsCmdDisabled(aHeroesBuildList[i], nPlayer))
                                                continue;
                                        if(nChoice == 0)
                                                break;

                                        nChoice -= 1;
                                }
                                while(GetRes(nPlayer, ResGlory) < 2000)
                                {
                                        ailog("waiting for new hero", nPlayer);
                                        if(oBase.class != "Darkling_Townhall")
                                        if(GetRes(nPlayer, ResSupport) <= 2)
                                                AIStartBuildlist(aHousesBuildlists[nHouses], oBase, AIPriorityHouseBuild);
                                                
                                        Sleep(sleep_time);
                                }
                                ailog("<yellow>i = <white>" + i, nPlayer);
                                new_heroes_glory_spent += 2;
                                AIStartBuildlist(aHeroesBuildList[i], oBase, AIPriorityHeroDevelop);
                                while(AIIsBuildlistRunning(aHeroesBuildList[i], oBase)) Sleep(sleep_time);
                                next_hero_develop_time = GetTime + 90000;
                        } else
                        {
                                ailog("<red>cannot train hero", nPlayer);
                        }
                        next_hero_creation_time = GetTime + 90000;  // wait 2 minutes before cheking again for new hero creation
                } else
                {
                        ailog("<yellow>develop hero", nPlayer);
                        skill = HeroesDevelopment("", nPlayer, h, level);
                        if(skill != "")
                        {
                                int resource_wait_time;
                                hero_buildup_buildlist = "Develop_" + skill;
                                if(level == 1)
                                        skill_cost = 1000;
                                if(level == 2)
                                        skill_cost = 3000;
                                if(level == 3)
                                        skill_cost = 4000;
                                while(GetRes(nPlayer, ResGlory) < skill_cost)
                                {
                                        ailog("waiting to develop skill", nPlayer);
                                        if(oBase.class != "Darkling_Townhall")
                                        if(GetRes(nPlayer, ResSupport) <= 0)
                                                AIStartBuildlist(aHousesBuildlists[nHouses], oBase, AIPriorityHouseBuild);

                                        Sleep(sleep_time);
                                }
                                specials_glory_spent += skill_cost/1000;
                                AIStartBuildlist(hero_buildup_buildlist, oBase, AIPriorityHeroDevelop, h);
                                while(AIIsBuildlistRunning(hero_buildup_buildlist, oBase)) Sleep(sleep_time);
                        } else
                        {
                                next_hero_develop_time = GetTime + 90000;
                                ailog("<red>cannot develop hero", nPlayer);
                        }
                }
                continue;
        } else
        {
                int recheck_state_time;
                recheck_state_time = GetTime + 60000;
                while(GetRes(nPlayer, ResGlory) < (nHouses+1)*1000)
                {
                        if(oBase.class != "Darkling_Townhall")
                        if(GetRes(nPlayer, ResSupport) <= 2)
                                AIStartBuildlist(aHousesBuildlists[nHouses], oBase, AIPriorityHouseBuild);
                        if(recheck_state_time < GetTime)
                                        break;
                        ailog("waiting to build new house", nPlayer);
                        Sleep(sleep_time);
                }
                if(recheck_state_time < GetTime)
                        continue;
                
                nHouses += 1;
                ailog("<yellow>houses : <white>" + nHouses, nPlayer);
                ailog("<blue>glory : <white>" + GetRes(nPlayer, ResGlory), nPlayer);
                AIStartBuildlist(aHousesBuildlists[nHouses], oBase, AIPriorityHouseBuild);
                while(AIIsBuildlistRunning(aHousesBuildlists[nHouses], oBase)) Sleep(2000);
                houses_glory_spent += nHouses;
        }
        
        if(oBase.class != "Darkling_Townhall")
        if(GetRes(nPlayer, ResSupport) <= 5)
                AIStartBuildlist(aHousesBuildlists[nHouses], oBase, AIPriorityHouseBuild);
}
