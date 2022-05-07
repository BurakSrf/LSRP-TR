Damages_Add(playerid, issuerid, weaponid, bodypart, Float:amount)
{
	new id;
	TotalDamages[playerid] ++; 
	
	for(new i = 0; i < MAX_DAMAGES; i++)
	{
		if(!DamageData[playerid][i][DamageTaken])
		{
			id = i;
			break;
		}
	}
	
	new Float: armor; GetPlayerArmour(playerid, armor);
	if(armor > 1 && bodypart == BODY_PART_CHEST) DamageData[playerid][id][DamageArmor] = 1;
	else DamageData[playerid][id][DamageArmor] = 0;
	
	format(DamageData[playerid][id][DamageBy], 25, "%s", ReturnName(issuerid, 1));
	DamageData[playerid][id][DamageTaken] = floatround(amount, floatround_round); 
	DamageData[playerid][id][DamageWeaponID] = weaponid;
	DamageData[playerid][id][DamageBodypart] = bodypart; 
	DamageData[playerid][id][DamageTime] = gettime();
	return 1; 
}

Damages_Clear(playerid)
{
	for(new i = 0; i < MAX_DAMAGES; i++)
	{
		if(DamageData[playerid][i][DamageTaken] != 0)
		{
			DamageData[playerid][i][DamageTaken] = 0;
			DamageData[playerid][i][DamageWeaponID] = 0;
			DamageData[playerid][i][DamageBodypart] = 0;
			DamageData[playerid][i][DamageArmor] = 0;
			DamageData[playerid][i][DamageTime] = 0;
			format(DamageData[playerid][i][DamageBy], 25, "Yok");
		}
	}

	TotalDamages[playerid] = 0;
	return 1;
}

Damages_Show(damageid, playerid, adminview)
{
	new
		caption[33], str[355], longstr[1200]; 
	
	format(caption, sizeof(caption), "%s", ReturnName(damageid));
	if(TotalDamages[damageid] < 1) return ShowPlayerDialog(playerid, DIALOG_USE, DIALOG_STYLE_LIST, caption, "Gösterilebilecek hasar yok.", "<<", ""); 

	switch(adminview)
	{
		case 0:
		{	
			//for(new i = 0; i < MAX_DAMAGES; i++) if(DamageData[damageid][i][DamageTaken])
			for(new i = MAX_DAMAGES-1; i >= 0; i--) if(DamageData[damageid][i][DamageTaken])
			{
				format(str, sizeof(str), "%s bölgesine %s ile %d hasar (Çelik yelek: %d) %d sn önce.\n", ReturnBodypartName(DamageData[damageid][i][DamageBodypart]), ReturnWeaponName(DamageData[damageid][i][DamageWeaponID]), DamageData[damageid][i][DamageTaken], DamageData[damageid][i][DamageArmor], gettime() - DamageData[damageid][i][DamageTime]);
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
		case 1:
		{
			for(new i = MAX_DAMAGES-1; i >= 0; i--) if(DamageData[damageid][i][DamageTaken])
			{
				format(str, sizeof(str), "%s bölgesine %s ile %d hasar (Çelik yelek: %d) %d sn önce. {FF6346}(%s)\n", ReturnBodypartName(DamageData[damageid][i][DamageBodypart]), ReturnWeaponName(DamageData[damageid][i][DamageWeaponID]), DamageData[damageid][i][DamageTaken], DamageData[damageid][i][DamageArmor], gettime() - DamageData[damageid][i][DamageTime], DamageData[damageid][i][DamageBy]);
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
	}
	return 1;
}