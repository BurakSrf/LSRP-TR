/*
Server:OnWeaponsUpdate()
{
	foreach(new i : Player)
	{
		if(!pLoggedIn[i]) continue;
		if(!Player_HasWeapons(i)) continue;
		if(NetStats_GetConnectedTime(i) - PlayerConnectionTick[i] < 300) continue;
		if(gettime() - PlayerData[i][pPauseWepAC] < 4 && PlayerData[i][pPauseWepAC] != 0) continue;
			
		for (new w = 0; w < 4; w++)
		{
			new idx = Weapon_GetSlotID(PlayerData[i][pWeapons][w]); 
			if(PlayerData[i][pWeapons][w] != 0 && PlayerData[i][pWeaponsAmmo][w] > 0)
			{
				AntiCheatGetWeaponData(i, idx, PlayerData[i][pWeapons][w], PlayerData[i][pWeaponsAmmo][w]); 
			}
			
			if(PlayerData[i][pWeapons][w] != 0 && PlayerData[i][pWeaponsAmmo][w] <= 0)
			{
				PlayerData[i][pWeapons][w] = PlayerData[i][pWeaponsAmmo][w] = 0;
				SetPlayerArmedWeapon(i, 0);
			}
		}
			
		return 1;
	}
	return 1;
}
*/
Weapon_GetSlotID(weaponid)
{
	switch(weaponid)
	{
		case 1..10: return 0;
		case 11..18, 41, 43: return 1;
		case 22..24: return 2;
		case 25..34: return 3;
	}
	return -1;
}

Player_RemoveWeapon(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return 1;

	new saveweapon[13], saveammo[13];
	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
	
	ResetPlayerWeapons(playerid);
	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;

		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	GivePlayerWeapon(playerid, 0, 1);
	return 1;
}

Player_HasWeapon(playerid, weaponid)
{
	new
		index;

	index = Weapon_GetSlotID(weaponid);
	if(index == -1) return 0;

	if(PlayerData[playerid][pWeapons][index] == weaponid)
		return 1;

	return 0;
}

Player_HasWeapons(playerid)
{
	new weap_count = 0;
	
	for(new i = 0; i < 4; i ++)
	{
		if(PlayerData[playerid][pWeapons][i] != 0) weap_count++;
	}

	if(!weap_count) return 0;
	return 1;
}

Weapons_Show(playerid, slotid)
{
	new returnStr[60];
	
	switch(slotid)
	{
		case 1:
		{
			new str_1slot[60];
			
			if(!PlayerData[playerid][pWeapons][0])
				str_1slot = "Yok"; 
				
			else
				format(str_1slot, 60, "%s", ReturnWeaponName(PlayerData[playerid][pWeapons][0]));
				
			returnStr = str_1slot;
		}
		case 2:
		{
			new str_2slot[60];
			
			if(!PlayerData[playerid][pWeapons][1])
				str_2slot = "Yok"; 
				
			else
				format(str_2slot, 60, "%s", ReturnWeaponName(PlayerData[playerid][pWeapons][1]));
				
			returnStr = str_2slot;
		}
		case 3:
		{
			new str_3slot[60];
			
			if(!PlayerData[playerid][pWeapons][2])
				str_3slot = "Yok"; 
				
			else
				format(str_3slot, 60, "%s", ReturnWeaponName(PlayerData[playerid][pWeapons][2]));
				
			returnStr = str_3slot;
		}
		case 4:
		{
			new str_4slot[60];
			
			if(!PlayerData[playerid][pWeapons][3])
				str_4slot = "Yok"; 
				
			else
				format(str_4slot, 60, "%s", ReturnWeaponName(PlayerData[playerid][pWeapons][3]));
				
			returnStr = str_4slot;
		}
	}
	return returnStr;
}

ReturnPlayerGuns(playerid)
{
	for(new i = 0; i < 4; i++) if(PlayerData[playerid][pWeaponsAmmo][i]) {
		GivePlayerWeapon(playerid, PlayerData[playerid][pWeapons][i], PlayerData[playerid][pWeaponsAmmo][i]); 
	}
	return 1; 
}

TakePlayerGuns(playerid)
{
	for(new i = 0; i < 4; i++) if(PlayerData[playerid][pWeaponsAmmo][i]) {
		PlayerData[playerid][pWeapons][i] = 0, PlayerData[playerid][pWeaponsAmmo][i] = 0; 
	}
		
	ResetPlayerWeapons(playerid); 
	return 1;
}

ReturnWeaponsModel(weaponid)
{
    new WeaponModels[] =
    {
        0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
        325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
        353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
        367, 368, 368, 371
    };
    return WeaponModels[weaponid];
}

Weapon_ResetPositions(playerid)
{
    for (new i; i < 17; i++)
    {
    	WeaponSettings[playerid][i][WeaponBone] = 1;
        WeaponSettings[playerid][i][WeaponHidden] = false;
        WeaponSettings[playerid][i][WeaponPos][0] = -0.116;
        WeaponSettings[playerid][i][WeaponPos][1] = 0.189;
        WeaponSettings[playerid][i][WeaponPos][2] = 0.088;
        WeaponSettings[playerid][i][WeaponPos][3] = 0.0;
        WeaponSettings[playerid][i][WeaponPos][4] = 44.5;
        WeaponSettings[playerid][i][WeaponPos][5] = 0.0;
    }
   	
   	PlayerConnectionTick[playerid] = 0;
	EditingDisplay[playerid] = false;
	return 1;
}

Weapon_SlotName(playerid, weaponid)
{
	switch(weaponid)
	{
		case 1..18: SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Yakýn dövüþ silahý] Artýk %s ile oyuna baþlayacaksýn.", ReturnWeaponName(weaponid));
		case 22..24: SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Ýkincil silah] Artýk %s ile oyuna baþlayacaksýn.", ReturnWeaponName(weaponid));
		case 25, 27..34: SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Birincil silah] Artýk %s ile oyuna baþlayacaksýn.", ReturnWeaponName(weaponid));

	}
	return 1;
}

stock ReturnWeaponType(id)
{
	new weapon[22];
    switch(id)
    {
        case 0 .. 24: weapon = "Yakýn dövüþ silahý";
        default: weapon = "Aðýr silah";
    }
    return weapon;
}

GetWeaponObjectSlot(weaponid)
{
	switch(weaponid)
	{
		case 1..10: return 5;
		case 11..18, 41, 43: return 6;
		case 22..24: return 7;
		case 25..34: return 8;
	}
	return -1;
}

IsWeaponWearable(weaponid)
    return (weaponid >= 22 && weaponid <= 34);

IsWeaponHideable(weaponid)
    return (weaponid >= 22 && weaponid <= 24 || weaponid == 28 || weaponid == 32);

/*

Server:OnPlayerPurchaseWeapon(playerid, response, weaponid, ammo, price)
{
	if( response ) {

		if(IsPlayerInBusiness(playerid))
		{
			BusinessData[IsPlayerInBusiness(playerid)][BusinessCashbox]+= price;
		}

		GiveMoney(playerid, -price);
		GivePlayerWeaponEx(playerid, weaponid, ammo, WEAPON_AMMUNATION_GIVEN);

		new
			string[128]
		;

		format(string, sizeof(string), "Bought %s (%d) for $%s", ReturnWeaponName(weaponid), ammo, MoneyFormat(price));
		LogPlayerAction(playerid, string);

		format(string, sizeof(string), "%s bought %s and %d ammo", ReturnName(playerid, 1), ReturnWeaponName(weaponid), ammo);
		adminWarn(1, string);

		//WriteLog("weapon_logs/ammunation/buygun.txt", "[%s] %s bought %s and %d ammo", ReturnDate(), ReturnName(playerid, 1), ReturnWeaponName(weaponid), ammo);
	}
	else return SendClientMessage(playerid, COLOR_DARKGREEN, "You cancelled your purchase!");
	return true;
}

Server:OnPlayerPurchaseArmor(playerid, response, price)
{
	if( response ){
		if(IsPlayerInBusiness(playerid))
		{
			BusinessData[IsPlayerInBusiness(playerid)][BusinessCashbox]+= price;
		}

		GiveMoney(playerid, -price);
		SetPlayerArmour(playerid, 50);
		new
			string[128]
		;

		format(string, sizeof(string), "Bought Armor $%s", MoneyFormat(price));
		LogPlayerAction(playerid, string);

		format(string, sizeof(string), "%s bought Armor for $%s", ReturnName(playerid, 1), MoneyFormat(price));
		adminWarn(1, string);

		//WriteLog("weapon_logs/ammunation/buykevlar_log.txt", "[%s] %s bought Armor for $%s", ReturnDate(), ReturnName(playerid, 1), MoneyFormat(price));
	}
	else return SendClientMessage(playerid, COLOR_DARKGREEN, "You cancelled your purchase!");
	return true;
}

Server:OnPlayerPurchaseAmmo(playerid, response, weaponid, ammo, price)
{
	if ( response ) {

		new currAmmo;

		SendClientMessage(playerid, COLOR_DARKGREEN, "You bought ammo. Enjoy your purchase!");

		if ( weaponid == WEAPON_COLT45 ) {
			currAmmo = ReturnWeaponAmmo(playerid, WEAPON_COLT45);
			GiveMoney(playerid, -price);

			SetPlayerAmmo(playerid, WEAPON_COLT45, ammo + currAmmo);
		}
		else if ( weaponid == WEAPON_DEAGLE ) {

			currAmmo = ReturnWeaponAmmo(playerid, WEAPON_DEAGLE);
			GiveMoney(playerid, -price);

			SetPlayerAmmo(playerid, WEAPON_DEAGLE, ammo + currAmmo);
		}
		else if ( weaponid == WEAPON_SHOTGUN ) {
			currAmmo = ReturnWeaponAmmo(playerid, WEAPON_SHOTGUN);
			GiveMoney(playerid, -price);

			SetPlayerAmmo(playerid, WEAPON_SHOTGUN, ammo + currAmmo);
		}
		else if ( weaponid == WEAPON_RIFLE ) {
			currAmmo = ReturnWeaponAmmo(playerid, WEAPON_RIFLE);
			GiveMoney(playerid, -price);

			SetPlayerAmmo(playerid, WEAPON_RIFLE, ammo + currAmmo);
		}

		new string[128];

		format(string, sizeof(string), "Bought %d Ammo for %s (%d) for $%s", ammo, ReturnWeaponName(weaponid), currAmmo, MoneyFormat(price));
		LogPlayerAction(playerid, string);

		//WriteLog("weapon_logs/ammunation/buyammo_log.txt", "[%s] %s bought %d Ammo for %s [Price: $%s]", ReturnDate(), ReturnName(playerid), ammo, ReturnWeaponName(weaponid), MoneyFormat(price));
	}
	else return SendClientMessage(playerid, COLOR_DARKGREEN, "You cancelled your purchase!");
	return true;
}
*/