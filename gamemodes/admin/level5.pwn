CMD:givegun(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5) return UnAuthMessage(playerid);

	new id, weaponid, ammo;
	if(sscanf(params, "uii", id, weaponid, ammo)) {
		SendUsageMessage(playerid, "/givegun [oyuncu ID/ad�] [silah ID] [mermi]");
		SendInfoMessage(playerid, "Verece�in bu silah ki�ide kay�tl� kalacakt�r.");
		return 1;
	}

	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");

	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "Hatal� silah ID girdiniz.");

	if(Player_HasWeapon(id, weaponid)) return SendErrorMessage(playerid, "Belirtti�iniz ki�ide bu silah bulunuyor.");
	if(ammo < 1) return SendErrorMessage(playerid, "Hatal� mermi miktar� girdiniz.");

	adminWarn(1, sprintf("%s isimli y�netici %s isimli oyuncuya %d mermili %s verdi.", ReturnName(playerid, 1), ReturnName(id, 1), ammo, ReturnWeaponName(weaponid)));
	if(!IsLAWFaction(id)) Weapon_SlotName(id, weaponid);
	GivePlayerWeapon(id, weaponid, ammo);
	return 1;
}

CMD:givedrug(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5) return UnAuthMessage(playerid);

	new id, type, boy, Float: amount, quality, drugname[64];
	if(sscanf(params, "uiifis[64]", id, type, boy, amount, quality, drugname))
	{
		SendUsageMessage(playerid, "/givedrug [oyuncu ID/ad�] [uyu�turucu tipi] [boy] [gram] [kalite] [�zel isim]");
		SendClientMessage(playerid, COLOR_GRAD2, "Tipler: 1. Marijuana, 2. Crack, 3. Cocaine, 4. Ecstasy, 5. LSD, 6. Meth, 7. PCP");
		SendClientMessage(playerid, COLOR_GRAD1, "Tipler: 8. Heroin, 9. Aspirin, 10. Haloperidol, 11. Morphine, 12. Xanax, 13. MDMA");
		SendClientMessage(playerid, COLOR_GRAD2, "Tipler: 14. Phenetole, 15. Steroids, 16. Mescalin, 17. Quaaludes, 18. Peyote");
		return 1;
	}

	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(type < 1 || type > 18) return SendErrorMessage(playerid, "Hatal� uyu�turucu tipi girdin. (1 - 18)");
	switch(boy)
	{
		case 1: if(amount < 0.1 || amount > 7.0) return SendClientMessage(playerid, COLOR_ADM, "Hatal� k���k boy uyu�turucu miktar� girdin. (0.1 - 7.0)");
		case 2: if(amount < 7.0|| amount > 14.0) return SendClientMessage(playerid, COLOR_ADM, "Hatal� orta boy uyu�turucu miktar� girdin. (7.0 - 14.0)");
		case 3: if(amount < 14.0 || amount > 21.0) return SendClientMessage(playerid, COLOR_ADM, "Hatal� b�y�k boy uyu�turucu miktar� girdin. (14.0 - 21.0)");
		default: return SendClientMessage(playerid, COLOR_ADM, "Hatal� uyu�turucu paket boyu girdin. (1 - 3)");
	}
	if(quality < 1 || quality > 100) return SendClientMessage(playerid, COLOR_ADM, "Hatal� uyu�turucu kalitesi girdin. (1 - 100)");


	new free_slot = Drug_GetPlayerNextSlot(id);
	if(free_slot == -1) return SendErrorMessage(playerid, "%s(ID: %i) �st�nde daha fazla uyu�turucu bulunduramaz.", ReturnName(id, 1), id);

	new drug_query[512];
	mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", PlayerData[id][pSQLID], drugname, type, amount, quality, boy);
	new Cache:cache = mysql_query(m_Handle, drug_query);

	player_drug_data[id][free_slot][data_id] = cache_insert_id();
	player_drug_data[id][free_slot][drug_id] = type;
	format(player_drug_data[id][free_slot][drug_name], 64, "%s", drugname);
	player_drug_data[id][free_slot][drug_amount] = amount;
	player_drug_data[id][free_slot][drug_quality] = quality;
	player_drug_data[id][free_slot][drug_size] = boy;
	player_drug_data[id][free_slot][is_exist] = true;

	cache_delete(cache);

	SendClientMessageEx(playerid, COLOR_YELLOW, "%s adl� ki�iye %s - %s (%s) verdin.", ReturnName(id, 0), player_drug_data[id][free_slot][drug_name], Drug_GetName(player_drug_data[id][free_slot][drug_id]), Drug_GetType(player_drug_data[id][free_slot][drug_size]));
	SendClientMessageEx(id, COLOR_YELLOW, "%s sana %s - %s (%s) verdi.", ReturnName(playerid, 0), player_drug_data[id][free_slot][drug_name], Drug_GetName(player_drug_data[id][free_slot][drug_id]), Drug_GetType(player_drug_data[id][free_slot][drug_size]));
	return 1;
}