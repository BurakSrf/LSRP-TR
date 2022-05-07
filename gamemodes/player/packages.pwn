Player_ListPackages(playerid, id)
{
	new drug_count, drug_str[128];
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(!player_package_data[playerid][i][is_exist]) continue;
		format(drug_str, sizeof(drug_str), "[ {FFFFFF}%i. %s - (%i/500) {FF6347}]", i, ReturnWeaponName(player_package_data[playerid][i][weapon_id]), player_package_data[playerid][i][weapon_ammo]);
		SendClientMessage(id, COLOR_ADM, drug_str);
		drug_count++;
	}

	if(!drug_count) SendClientMessage(id, COLOR_WHITE, "Gösterilebilecek silah paketi yok.");
	return 1;
}

Package_DefaultValues(playerid, slot = -1)
{
	if(slot == -1)
	{
		for(new i = 1; i < MAX_PACK_SLOT; i++)
		{
			player_package_data[playerid][i][weapon_id] = 0;
			player_package_data[playerid][i][weapon_ammo] = 0;
			player_package_data[playerid][i][is_exist] = false;
			player_package_data[playerid][i][player_dbid] = 0;
			player_package_data[playerid][i][data_id] = 0;
		}
	} else {
		new query[64];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM player_packages WHERE id = %i", player_package_data[playerid][slot][data_id]);
		mysql_tquery(m_Handle, query);

		player_package_data[playerid][slot][weapon_id] = 0;
		player_package_data[playerid][slot][weapon_ammo] = 0;
		player_package_data[playerid][slot][is_exist] = false;
		player_package_data[playerid][slot][player_dbid] = 0;
		player_package_data[playerid][slot][data_id] = 0;
	}
	return 1;
}