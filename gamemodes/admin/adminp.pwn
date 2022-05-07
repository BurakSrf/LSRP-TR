CMD:mobilyap(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	Furniture_AList(playerid);
	return 1;
}

Furniture_AList(playerid, page = 0)
{
	SetPVarInt(playerid, "furniture_aidx", page);

    new query[82];
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, ObjName, ObjPrice FROM furniture_lists LIMIT %d, 25", page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_FurnitureAList", "ii", playerid, page);
	return 1;
}

Server:SQL_FurnitureAList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç mobilya verisi eklenmemiþ.");
    }

	new 
		id, obj_price, obj_name[64], primary_str[1490];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "ObjName", obj_name, 64);
        cache_get_value_name_int(i, "ObjPrice", obj_price);

		format(primary_str, sizeof(primary_str), "%s[%i] {AFAFAF}%s - $%s\n", primary_str, id, obj_name, MoneyFormat(obj_price));
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, FURNITURE_ALIST, DIALOG_STYLE_LIST, "LS-RP: Mobilya Listesi", primary_str, "Düzenle", "<< Kapat");
	return 1;
}

Dialog:FURNITURE_ALIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "furniture_aidx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Furniture_AList(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Furniture_AList(playerid, page+1);
		
		new id;
        sscanf(inputtext[0], "P<[]>{s[2]}i", id);
        SetPVarInt(playerid, "selected_afurniture_idx", id);
		Furniture_ShowDialog(playerid, id);
		return 1;
	}
    return 1;
}

Furniture_AGetName(id)
{
	new query[129], objname[64];
	mysql_format(m_Handle, query, sizeof(query), "SELECT ObjName FROM furniture_lists WHERE id = %i", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, "ObjName", objname, sizeof(objname));
	cache_delete(cache);
	return objname;
}

Furniture_AGetPrice(id)
{
	new query[129], price;
	mysql_format(m_Handle, query, sizeof(query), "SELECT ObjPrice FROM furniture_lists WHERE id = %i", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "ObjPrice", price);
	cache_delete(cache);
	return price;
}

Furniture_ShowDialog(playerid, id, error[] = "")
{
	new
		string[300];

	if(isnull(error)) format(string, sizeof(string), "[%i] {AFAFAF}%s - $%s\nMobilyasýnýn yeni fiyatýný giriniz.", id, Furniture_AGetName(id), MoneyFormat(Furniture_AGetPrice(id)));
	else format(string, sizeof(string), "[%i] {AFAFAF}%s - $%s\nAracýnýn yeni fiyatýný giriniz.\n\n%s", id, Furniture_AGetName(id), MoneyFormat(Furniture_AGetPrice(id)), error);
	Dialog_Show(playerid, FURNITURE_ALIST_PRICE, DIALOG_STYLE_INPUT, "LS-RP: Mobilya Listesi", string, "Düzenle", "<< Kapat");
	return 1;
}

Dialog:FURNITURE_ALIST_PRICE(playerid, response, listitem, inputtext[])
{
	if(!response) return Furniture_AList(playerid, GetPVarInt(playerid, "furniture_aidx"));

	new id = GetPVarInt(playerid, "selected_afurniture_idx");

	if(!IsNumeric(inputtext)) {
		Furniture_ShowDialog(playerid, id, "Mobilya fiyatý sayýsal deðer olmalýdýr.");
		return 1;
	}

	if(strval(inputtext) < 1 || strval(inputtext) > 5000000) {
		Furniture_ShowDialog(playerid, id, "Mobilya fiyatý en az $1 en fazla $5.000,000 olabilir.");
		return 1;
	}

	new query[75];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE furniture_lists SET ObjPrice = %i WHERE id = %i", strval(inputtext), id);
	mysql_tquery(m_Handle, query);

	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s adlý mobilyanýn fiyatý $%s olarak güncellendi.", Furniture_AGetName(id), MoneyFormat(strval(inputtext)));
	return 1;
}

CMD:galerip(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	Vehicle_List(playerid);
	return 1;
}

Vehicle_List(playerid, page = 0)
{
	SetPVarInt(playerid, "vehicle_idx", page);

    new query[82];
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, VehicleName, VehiclePrice FROM dealerships LIMIT %d, 25", page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_DealershipList", "ii", playerid, page);
	return 1;
}

Server:SQL_DealershipList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hiç araç verisi eklenmemiþ.");
    }

	new 
		id, vehicle_price, vehicle_name[45], primary_str[1024];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "VehicleName", vehicle_name, 45);
        cache_get_value_name_int(i, "VehiclePrice", vehicle_price);

		format(primary_str, sizeof(primary_str), "%s[%i] {AFAFAF}%s - $%s\n", primary_str, id, vehicle_name, MoneyFormat(vehicle_price));
	}

	if(page != 0) strcat(primary_str, "{FFFF00}Önceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, VEHICLE_LIST, DIALOG_STYLE_LIST, "LS-RP: Araç Listesi", primary_str, "Düzenle", "<< Kapat");
	return 1;
}

Dialog:VEHICLE_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "vehicle_idx");
		if(!strcmp(inputtext, "Önceki Sayfa <<")) return Vehicle_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Vehicle_List(playerid, page+1);
		
		new id;
        sscanf(inputtext[0], "P<[]>{s[2]}i", id);
        SetPVarInt(playerid, "selected_veh_idx", id);

		/*SendPlayer(playerid, floatstr(Teleport_GetPosition(id, "TeleportX")), floatstr(Teleport_GetPosition(id, "TeleportY")), floatstr(Teleport_GetPosition(id, "TeleportZ")), floatstr(Teleport_GetPosition(id, "TeleportA")), Teleport_GetInt(id, "TeleportInterior"), Teleport_GetInt(id, "TeleportWorld"));
		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli noktaya ýþýnlandýn.", Teleport_GetName(id));
		ResetHouseVar(playerid);*/

		Vehicle_ShowDialog(playerid, id);
		return 1;
	}
    return 1;
}

Vehicle_ShowDialog(playerid, id, error[] = "")
{
	new
		string[300];

	if(isnull(error)) format(string, sizeof(string), "[%i] {AFAFAF}%s - $%s\nAracýnýn yeni fiyatýný giriniz.", DealershipData[id-1][DealershipID], DealershipData[id-1][DealershipModelName], MoneyFormat(DealershipData[id-1][DealershipPrice]));
	else format(string, sizeof(string), "[%i] {AFAFAF}%s - $%s\nAracýnýn yeni fiyatýný giriniz.\n\n%s", DealershipData[id-1][DealershipID], DealershipData[id-1][DealershipModelName], MoneyFormat(DealershipData[id-1][DealershipPrice]), error);
	Dialog_Show(playerid, VEHICLE_LIST_PRICE, DIALOG_STYLE_INPUT, "LS-RP: Araç Listesi", string, "Düzenle", "<< Kapat");
	return 1;
}

Dialog:VEHICLE_LIST_PRICE(playerid, response, listitem, inputtext[])
{
	if(!response) return Vehicle_List(playerid, GetPVarInt(playerid, "vehicle_idx"));

	new id = GetPVarInt(playerid, "selected_veh_idx");

	if(!IsNumeric(inputtext)) {
		Vehicle_ShowDialog(playerid, id, "Aracýn fiyatý sayýsal deðer olmalýdýr.");
		return 1;
	}

	if(strval(inputtext) < 1 || strval(inputtext) > 5000000) {
		Vehicle_ShowDialog(playerid, id, "Aracýn fiyatý en az $1 en fazla $5.000,000 olabilir.");
		return 1;
	}

	new query[75];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE dealerships SET VehiclePrice = %i WHERE id = %i", strval(inputtext), id);
	mysql_tquery(m_Handle, query);

	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s model aracýn fiyatý $%s olarak güncellendi.", DealershipData[id-1][DealershipModelName], MoneyFormat(strval(inputtext)));

	//
	mysql_tquery(m_Handle, "SELECT * FROM dealerships", "SQL_LoadDealerships");
	return 1;
}

CMD:adminp(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	ShowAdminPanel(playerid);
	return 1;
}

ShowAdminPanel(playerid)
{
	new list[350];
	strcat(list, "1.\tYasakla (OFFLINE)\n");
	strcat(list, "2.\tHapise At (OFFLINE)\n");
	strcat(list, "3.\tYasak Kaldýr\n");
	strcat(list, "4.\tHapis Kayýtlarý\n");
	strcat(list, "5.\tAtýlma Kayýtlarý\n");
	strcat(list, "6.\tYasaklanma Kayýtlarý\n");
	strcat(list, "7.\tMaskeli Bul\n");
	strcat(list, "8.\tMaskeli Listesi\n");
	strcat(list, "9.\tKýyafete göre oyuncu ara\n");
	strcat(list, "10.\tAdmin Notes Lookup\n");
	strcat(list, "11.\tAdmin Notes Edit\n");
	strcat(list, "12.\tAdmin Notes Add\n");
	strcat(list, "13.\tAdmin Notes Delete\n");
	Dialog_Show(playerid, ASYS, DIALOG_STYLE_LIST, "Yönetici Paneli", list, "Seç", "<<");
	return 1;
}

ShowAdminSys(playerid, panel, error[] = "")
{
	new
		string[330];

	switch(panel)
	{
		case 0: //offline ban
		{
			if(isnull(error)) string = "Yasaklamak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nYasaklamak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_OFFLINEBAN, DIALOG_STYLE_INPUT, "Yönetici Paneli: Yasakla (OFFLINE)", string, "Ýleri", "<<");
			return 1;
		}
		case 1: //offline ajail
		{
			if(isnull(error)) string = "Hapise atmak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nHapise atmak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_OFFLINEAJAIL, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapise At (OFFLINE)", string, "Ýleri", "<<");
			return 1;
		}
		case 2: //unban
		{
			if(isnull(error))string = "Yasaðýný kaldýrmak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nYasaðýný kaldýrmak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_UNBAN, DIALOG_STYLE_INPUT, "Yönetici Paneli: Yasak Kaldýr", string, "Ýleri", "<<");
			return 1;
		}
		case 3: //ajail lookup
		{
			if(isnull(error)) string = "Hapis kayýtlarýna bakmak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nHapis kayýtlarýna bakmak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_LOOKUP_JAILS, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapis Kayýtlarý", string, "Ýleri", "<<");
			return 1;
		}
		case 4: //kick lookup
		{
			if(isnull(error))string = "Atýlma kayýtlarýna bakmak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nAtýlma kayýtlarýna bakmak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_LOOKUP_KICKS, DIALOG_STYLE_INPUT, "Yönetici Paneli: Atýlma Kayýtlarý", string, "Ýleri", "<<");
			return 1;
		}
		case 5: //ban lookup
		{
			if(isnull(error)) string = "Yasaklanma kayýtlarýna bakmak istediðin oyuncunun adýný gir:";
			else format(string, sizeof(string), "%s\n\nYasaklanma kayýtlarýna bakmak istediðin oyuncunun adýný gir:", error);
			Dialog_Show(playerid, ASYS_LOOKUP_BANS, DIALOG_STYLE_INPUT, "Yönetici Paneli: Yasaklanma Kayýtlarý", string, "Ýleri", "<<");
			return 1;
		}
		case 6: //mask decrypt
		{
			if(isnull(error)) string = "Bilgilerine bakmak istediðiniz maskelinin numarasýný giriniz(bknz: 100000_00):";
			else format(string, sizeof(string), "%s\n\nBilgilerine bakmak istediðiniz maskelinin numarasýný giriniz(bknz: 100000_00):", error);
			Dialog_Show(playerid, ASYS_DECRYPTMASK, DIALOG_STYLE_INPUT, "Yönetici Paneli: Maskeli Bul", string, "Ýleri", "<<");
			return 1;
		}
		case 7: //find mask
		{
			new
				primary_str[800], sub_str[45],
				count;

			strcat(primary_str, "Aktif Maskeliler:\n\n");

			foreach(new i : Player) if(PlayerData[i][pMaskOn])
			{
				format(sub_str, sizeof(sub_str), "\t%s (ID: %i) - %s\n", ReturnName(i), i, ReturnPlayerMask(i));
				strcat(primary_str, sub_str);
				count++;
			}

			Dialog_Show(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Maskeli Listesi", !count ? "Sunucuda maskeli kimse yok." : primary_str, "Tamamdýr!", "");
			return 1;
		}
		case 8: //skin search
		{
			if(isnull(error)) string = "Input the Skin ID you want to search for:";
			else format(string, sizeof(string), "%s\n\nInput the Skin ID you want to search for:", error);
			ShowPlayerDialog(playerid, DIALOG_SKINSEARCH, DIALOG_STYLE_INPUT, "Los Santos Roleplay: Yönetim Sistemi", string, "Ýleri", "<<");
			return 1;
		}
		case 9: // admin note lookup
		{
			if(isnull(error))
				string = "Input the players name to lookup their admin notes:";

			else format(string, sizeof(string), "%s\n\nInput the players name to lookup their admin notes:", error);

			ShowPlayerDialog(playerid, DIALOG_ANOTE_LOOKUP, DIALOG_STYLE_INPUT, "Los Santos Roleplay: Yönetim Sistemi", string, "Ýleri", "<<");
			return 1;
		}
		case 10: // admin note edit
		{
			if(isnull(error))
				string = "Input the players name to edit their admin notes:";

			else format(string, sizeof(string), "%s\n\nInput the players name to edit their admin notes:", error);

			ShowPlayerDialog(playerid, DIALOG_ANOTE_EDIT, DIALOG_STYLE_INPUT, "Los Santos Roleplay: Yönetim Sistemi", string, "Ýleri", "<<");
			return 1;
		}
		case 11: // admin note add
		{
			if(isnull(error))
				string = "Input the players name to add a new admin note:";

			else format(string, sizeof(string), "%s\n\nInput the players name to add a new admin note:", error);

			ShowPlayerDialog(playerid, DIALOG_ANOTE_ADD, DIALOG_STYLE_INPUT, "Los Santos Roleplay: Yönetim Sistemi", string, "Ýleri", "<<");
			return 1;
		}
		case 12: // admin note delete
		{
			if(isnull(error))
				string = "Input the players name to delete an admin note:";

			else format(string, sizeof(string), "%s\n\nInput the players name to delete an admin note:", error);

			ShowPlayerDialog(playerid, DIALOG_ANOTE_DELETE, DIALOG_STYLE_INPUT, "Los Santos Roleplay: Yönetim Sistemi", string, "Ýleri", "<<");
			return 1;
		}
	}
	return 1;
}

Dialog:ASYS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		ShowAdminSys(playerid, listitem);
		return 1;
	}
	return 1;
}

Dialog:ASYS_OFFLINEBAN(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 0, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 0, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	if(IsUserBanned(inputtext)) {
		ShowAdminSys(playerid, 0, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" zaten sunucudan yasaklý gözüküyor.", inputtext));
		return 1;
	}

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), inputtext, true))
		{
			ShowAdminSys(playerid, 0, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s(ID: %i){ADC3E7}\" þuan oyunda gözüküyor.", inputtext, i));
			return 1;
		}
	}

	new strin[128];
	format(OfflineBanName[playerid], 128, "%s", inputtext);
	format(strin, 128, "\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun yasaklanma sebebini giriniz:", inputtext);
	Dialog_Show(playerid, ASYS_OFFLINEBAN_REASON, DIALOG_STYLE_INPUT, "Yönetici Paneli: Yasakla (OFFLINE)", strin, "Ýleri", "<<");
	return 1;
}

Dialog:ASYS_OFFLINEBAN_REASON(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(strlen(inputtext) < 3) {
		new strin[128];
		format(strin, 128, "\"{A52A2A}%s{ADC3E7}\" isimli oyuncunun yasaklanma sebebini giriniz:", OfflineBanName[playerid]);
		Dialog_Show(playerid, ASYS_OFFLINEBAN_REASON, DIALOG_STYLE_INPUT, "Yönetici Paneli: Yasakla (OFFLINE)", strin, "Seç", "<<");
		return 1;
	}

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), OfflineBanName[playerid], true))
		{
			SendClientMessage(playerid, COLOR_ADM, "Bir hata oluþtu... Yasaklamaya çalýþtýðýn oyuncu þuan da giriþ yaptý.");
			SendClientMessageEx(playerid, COLOR_WHITE, "ID: %i", i);
			return 1;
		}
	}

	new 
		sql_id, admin_level, last_ip[16];

	new secure[94];
	mysql_format(m_Handle, secure, sizeof(secure), "SELECT id, AdminLevel, LastIP FROM players WHERE Name = '%e'", OfflineBanName[playerid]);
	new Cache: cache = mysql_query(m_Handle, secure);
	
	cache_get_value_name_int(0, "id", sql_id);
	cache_get_value_name_int(0, "AdminLevel", admin_level);
	cache_get_value_name(0, "IP", last_ip, sizeof(last_ip));
	
	cache_delete(cache);

	if(admin_level > PlayerData[playerid][pAdmin])
	{
		Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Yasakla (OFFLINE)", "Belirtilen oyuncu senin tarafýndan yasaklanamaz.", "Tamamdýr!", "");
		return 1;
	}

	new
		ban_query[300], string[128];

	mysql_format(m_Handle, ban_query, sizeof(ban_query), "INSERT INTO bans (active, ban_ip, ban_name, ban_regid, admin, admin_regid, reason, time) VALUES (1, '%e', '%e', %i, '%e', %i, '%e', %i)", last_ip, OfflineBanName[playerid], sql_id, ReturnName(playerid, 1), PlayerData[playerid][pSQLID], inputtext, Time());
	mysql_tquery(m_Handle, ban_query);

	format(string, sizeof(string), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncu baþarýyla yasaklandý.", OfflineBanName[playerid]);
	Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Oyuncu Yasakla (OFFLINE)", string, "Tamamdýr!", "");

	//format(string, sizeof(string), "%s was offline banned by %s for '%s'", OfflineBanName[playerid], ReturnName(playerid), inputtext);
	//adminWarn(1, string);

	//printf("[WARNING] AdmCmd: %s offline banned %s, reason: %s ", ReturnName(playerid, 1), OfflineBanName[playerid], inputtext);
	return 1;
}

Dialog:ASYS_OFFLINEAJAIL(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 1, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 1, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), inputtext, true))
		{
			ShowAdminSys(playerid, 1, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s(ID: %i){ADC3E7}\" þuan oyunda gözüküyor.", inputtext, i));
			return 1;
		}
	}

	new strin[128];
	format(OfflineJailName[playerid], 60, "%s", inputtext);
	format(strin, sizeof(strin), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun hapis süresini dakika cinsinden giriniz:", inputtext);
	Dialog_Show(playerid, ASYS_OFFLINEAJAIL_TIME, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapise At (OFFLINE)", strin, "Ýleri", "<<");
	return 1;
}

Dialog:ASYS_OFFLINEAJAIL_TIME(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	new
		strin[230];

	if(!IsNumeric(inputtext)) {
		format(strin, sizeof(strin), "Süre, dakika cinsinden sayýsal bir deðer olmalýdýr.\n\n\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun hapis süresini dakika cinsinden giriniz:", OfflineJailName[playerid]);
		Dialog_Show(playerid, ASYS_OFFLINEAJAIL_TIME, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapise At (OFFLINE)", strin, "Ýleri", "<<");
		return 1;
	}

	OfflineJailTime[playerid] = strval(inputtext);

	if(OfflineJailTime[playerid] < 1) {
		format(strin, sizeof(strin), "Süre, en az 1 dakika olabilir.\n\n\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun hapis süresini dakika cinsinden giriniz:", OfflineJailName[playerid]);
		ShowPlayerDialog(playerid, DIALOG_ASYS_OJAILTIME, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapise At (OFFLINE)", strin, "Ýleri", "<<");
		return 1;
	}

	format(strin, sizeof(strin), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun (%i) dakikalýk hapisinin sebebini giriniz:", OfflineJailName[playerid], OfflineJailTime[playerid]);
	Dialog_Show(playerid, ASYS_OFFLINEAJAIL_REASON, DIALOG_STYLE_INPUT, "Yönetici Paneli: Hapise At (OFFLINE)", strin, "Ýleri", "<<");
	return 1;
}

Dialog:ASYS_OFFLINEAJAIL_REASON(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), OfflineJailName[playerid], true))
		{
			ShowAdminSys(playerid, 1, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s(ID: %i){ADC3E7}\" þuan oyunda gözüküyor.", inputtext, i));
			return 1;
		}
	}

	new
		query[256],
		string[170];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE players SET OfflineAjail = %i, OfflineAjailReason = '%e' WHERE Name = '%e'", OfflineJailTime[playerid], inputtext, OfflineJailName[playerid]);
	mysql_tquery(m_Handle, query);

	format(string, sizeof(string), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncu baþarýyla yönetici hapisine gönderildi.", OfflineJailName[playerid]);
	Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Hapise At (OFFLINE)", string, "Tamamdýr!", "");

	//format(string, sizeof(string), "%s was offline jailed by %s for '%s'", OfflineJailName[playerid], ReturnName(playerid), inputtext);
	//adminWarn(1, string);
	return 1;
}

Dialog:ASYS_UNBAN(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 2, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 2, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	if(!IsUserBanned(inputtext)) {
		ShowAdminSys(playerid, 2, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" zaten sunucudan yasaklý gözükmüyor.", inputtext));
		return 1;
	}

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), inputtext, true))
		{
			ShowAdminSys(playerid, 2, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s(ID: %i){ADC3E7}\" þuan oyunda gözüküyor.", inputtext, i));
			return 1;
		}
	}

	new strin[128];
	format(AdminPanelName[playerid], 60, "%s", inputtext);
	format(strin, sizeof(strin), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun yasaðýný kaldýrmak konusunda emin misin?", inputtext);
	ConfirmDialog(playerid, "Yönetici Paneli: Yasak Kaldýr", strin, "OnPanelUnban");
	return 1;
}

Server:OnPanelUnban(playerid, response)
{
	if(!response) {
		ShowAdminPanel(playerid);
		return 1;
	}

	new
		string[128],
		query[256];

	//format(string, sizeof(string), "%s isimli oyuncunun yasaklamasý %s tarafýndan kaldýrýldý.", AdminPanelName[playerid], ReturnName(playerid));
	//adminWarn(1, string);

	format(string, sizeof(string), "\"{A52A2A}%s{ADC3E7}\" adlý oyuncunun yasaðý baþarýyla kaldýrýldý.", AdminPanelName[playerid]);
	ShowPlayerDialog(playerid, DIALOG_USE, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Yasak Kaldýr", string, "Tamamdýr!", "");

	mysql_format(m_Handle, query, sizeof(query), "UPDATE bans SET active = 0 WHERE ban_name = '%e'", AdminPanelName[playerid]);
	mysql_tquery(m_Handle, query);
	return 1;
}

Dialog:ASYS_LOOKUP_JAILS(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 3, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 3, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	/*new query[200];
	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM log_ajail WHERE Name = '%e' ORDER BY id DESC", inputtext);
	new Cache:cache = mysql_query(m_Handle, query);

	if(!cache_num_rows())
	{
		format(query, sizeof(query), "The user \"{A52A2A}%s{ADC3E7}\" has never been admin jailed.", inputtext);
		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", query, "Okay!", "");
		cache_delete(cache);
		return 1;
	}
	else
	{
		new Reason[128], By[60], jail_date, IP[90], jail_time;
		new PackerString[128], FullList[1100];

		strcat(FullList, "Hapise Atan - Tarih - Süre - Sebep - IP\n\n");

		for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name(i, "JailedBy", By, 60);
			cache_get_value_name(i, "Reason", Reason, 128);

			cache_get_value_name_int(i, "Date", jail_date);
			cache_get_value_name(i, "IP", IP, 90);

			cache_get_value_name_int(i, "Time", jail_time);

			format(PackerString, 128, "\t%s - %s - %i - %s - %s\n", By, GetFullTime(jail_date), jail_time, Reason, IP);
			strcat(FullList, PackerString);
		}

		Dialog_Show(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Yönetici Paneli: Hapis Kayýtlarý", FullList, "Tamamdýr!", "");
		cache_delete(cache);
	}*/
	return 1;
}

Dialog:ASYS_LOOKUP_KICKS(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 4, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 4, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	/*new
		query[200];

	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM log_kicks WHERE Name = '%e' ORDER BY id DESC", inputtext);
	new Cache:cache = mysql_query(m_Handle, query);

	if(!cache_num_rows())
	{
		format(query, sizeof(query), "The user \"{A52A2A}%s{ADC3E7}\" has never been kicked.", inputtext);
		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", query, "Okay!", "");

		cache_delete(cache);
		return 1;
	}
	else
	{
		new Reason[128], By[60], kick_date, IP[90];
		new PackerString[128], FullList[1100];

		strcat(FullList, "Oyundan Atan - Tarih - Sebep - IP\n\n");

		for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name(i, "KickedBy", By, 60);
			cache_get_value_name(i, "Reason", Reason, 128);

			cache_get_value_name_int(i, "Date", kick_date);
			cache_get_value_name(i, "IP", IP, 90);

			format(PackerString, 128, "\t%s - %s - %s - %s\n", By, GetFullTime(kick_date), Reason, IP);
			strcat(FullList, PackerString);
		}

		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", FullList, "Okay!", "");
		cache_delete(cache);
	}*/
	return 1;
}

Dialog:ASYS_LOOKUP_BANS(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(!IsValidRoleplayName(inputtext)) {
		return ShowAdminSys(playerid, 5, "Girdiðiniz oyuncu adý geçerli deðil. (bknz: Kevin_McCavish)");
	}

	if(!ReturnSQLFromName(inputtext)) {
		ShowAdminSys(playerid, 5, sprintf("{ADC3E7}Girdiðin oyuncu adý \"{A52A2A}%s{ADC3E7}\" veritabanýnda bulunamadý.", inputtext));
		return 1;
	}

	/*new
		query[200];

	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM log_bans WHERE Name = '%e' ORDER BY id DESC", inputtext);
	new Cache:cache = mysql_query(m_Handle, query);

	if(!cache_num_rows())
	{
		format(query, sizeof(query), "The user \"{A52A2A}%s{ADC3E7}\" has never been banned.", inputtext);
		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", query, "Okay!", "");

		cache_delete(cache);
		return 1;
	}
	else
	{
		new Reason[128], By[60], ban_date, IP[90];
		new PackerString[128], FullList[1100];

		strcat(FullList, "Banned by - Date - Reason - IP\n\n");

		for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_value_name(i, "BannedBy", By, 60);
			cache_get_value_name(i, "Reason", Reason, 128);

			cache_get_value_name_int(i, "Date", ban_date);
			cache_get_value_name(i, "IP", IP, 90);

			format(PackerString, 128, "\t%s - %s - %s - %s\n", By, GetFullTime(ban_date), Reason, IP);
			strcat(FullList, PackerString);
		}

		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", FullList, "Okay!", "");
		cache_delete(cache);
	}*/
	return 1;
}

Dialog:ASYS_DECRYPTMASK(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return ShowAdminPanel(playerid);
	}

	if(strlen(inputtext) > 9) {
		return ShowAdminSys(playerid, 6, "Hatalý maske numarasý girdiniz.");
	}

	new bool: is_valid = true;
	for (new i = 0, l = strlen(inputtext); i != l; i ++)
	{
		if (i == 6 && inputtext[6] == '_')
			continue;

		else if (inputtext[i] < '0' || inputtext[i] > '9')
			is_valid = false;
	}

	if(!is_valid) {
		return ShowAdminSys(playerid, 6, "Hatalý maske numarasý girdiniz. (2)");
	}

	new First,
		Second,
		FirstStr[30],
		SecondStr[30];

	strmid(FirstStr, inputtext, 0, 6);
	strmid(SecondStr, inputtext, 7, 9);

	First = strval(FirstStr);
	Second = strval(SecondStr);

	new
		string[128];

	new query[128];
	mysql_format(m_Handle, query, sizeof(query), "SELECT Name FROM players WHERE MaskID = %i AND MaskIDEx = %i", First, Second);
	new Cache:cache = mysql_query(m_Handle, query);

	if(!cache_num_rows())
	{
		format(string, sizeof(string), "No user has the Mask ID \"{A52A2A}[%d_%d]{ADC3E7}\".", First, Second);
		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", string, "Okay!", "");

		cache_delete(cache);
	}
	else
	{
		new Name[24];
		cache_get_value_name(0, "Name", Name, 24);

		format(string, sizeof(string), "Mask ID \"{A52A2A}[%d_%d]{ADC3E7}\" belongs to the user \"{A52A2A}%s{ADC3E7}\".", First, Second, Name);
		ShowPlayerDialog(playerid, DIALOG_APANEL, DIALOG_STYLE_MSGBOX, "Administration panel", string, "Okay!", "");

		cache_delete(cache);
	}

	return 1;
}