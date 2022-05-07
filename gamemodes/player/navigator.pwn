CMD:samaps(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Arka koltukta bu komutu kullanamazsýn.");
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet sýnavýndayken bu komutu kullanamazsýn."); 
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi sýnavýndayken bu komutu kullanamazsýn."); 

	new primary_str[200];
	strcat(primary_str, "Sokak Bul\n");
	strcat(primary_str, "Ev Bul\n");
	strcat(primary_str, "En Yakýn Benzin Ýstasyonu\n");
	strcat(primary_str, "En Yakýn 24/7\n");
	strcat(primary_str, "En Yakýn Bar/Kulüp\n");
	strcat(primary_str, "En Yakýn Restaurant\n");
	strcat(primary_str, "Tüm Ýþyerleri\n");
	strcat(primary_str, "Önemli Noktalar\n");
	Dialog_Show(playerid, GPS_MAIN, DIALOG_STYLE_LIST, "SA Maps - Ana Menü", primary_str, "Ýleri", "Kapat");
	return 1;
}

Dialog:GPS_MAIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		ShowNavigatorSys(playerid, listitem);
		return 1;
	}
	return 1;
}

ShowNavigatorSys(playerid, panel, error[] = "")
{
	new
		string[330];

	switch(panel)
	{
		case 0: //sokak
		{
			if(isnull(error)) string = "Bulmaya çalýþtýðýnýz sokaðýn adýný girin.";
			else format(string, sizeof(string), "%s\n\nBulmaya çalýþtýðýnýz sokaðýn adýný girin.", error);
			Dialog_Show(playerid, GPS_STREET, DIALOG_STYLE_INPUT, "SA Maps - Sokak Bul", string, "Ýleri", "Geri");
		}
		case 1: //ev kapý no
		{
			if(isnull(error)) format(string, sizeof(string), "Bulmaya çalýþtýðýnýz evin kapý numarasýný girin. (örneðin: %i)", randomEx(1, 2000));
			else format(string, sizeof(string), "%s\n\nBulmaya çalýþtýðýnýz evin kapý numarasýný girin. (örneðin: %i)", error, strlen(PropertyNameHolder[playerid]) > 0 ? strval(PropertyNameHolder[playerid]) : randomEx(1, 2000));
			Dialog_Show(playerid, GPS_PROPERTY_NO, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", string, "Ýleri", "Geri");
		}
		case 2: // benzinlik
		{
			new id = Business_Closest(playerid, BUSINESS_GASSTATION);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnýzda benzinlik bulunamadý.");
		}
		case 3: // 24/7
		{
			new id = Business_Closest(playerid, BUSINESS_STORE || BUSINESS_GENERAL);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnýzda 24/7 bulunamadý.");
		}
		case 4: // Bar/Kulüp
		{
			new id = Business_Closest(playerid, BUSINESS_CLUB);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnýzda bar/kulüp bulunamadý.");
		}
		case 5: // Restaurant
		{
			new id = Business_Closest(playerid, BUSINESS_RESTAURANT);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnýzda restaurant bulunamadý.");
		}
		case 6: // tüm iþyerleri 200mt
		{
			new sira, primary_str[750], sub_str[75];
			strcat(primary_str, "#\tÝþyeri Adý\n");

			foreach(new i : Businesses)
			{
				if(!IsPlayerInRangeOfPoint(playerid, 200.0, BusinessData[i][EnterPos][0], BusinessData[i][EnterPos][1], BusinessData[i][EnterPos][2])) continue;

				format(sub_str, sizeof(sub_str), "%i\t%s\n", i, BusinessData[i][BusinessName]);
				strcat(primary_str, sub_str);
				sira++;

				if(sira > 10) break;
			}

			if(!sira) strcat(primary_str, "Hiç iþyeri yok.");

			Dialog_Show(playerid, GPS_BUSINESS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "SA Maps - Tüm Ýþyerleri", primary_str, "Ýþaretle", "Geri");

		}
	}
	return 1;
}

Dialog:GPS_STREET(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	new bool: found, id;
	foreach (new i : Streets)
	{
		if(strfind(StreetData[i][StreetName], inputtext, true) != -1)
		{
			found = true;
			id = i;
			break;
		}
	}

	if(!found) {
		ShowNavigatorSys(playerid, 0, "Hiç sonuç bulunamadý.");
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", StreetData[id][StreetName]);
	SetPlayerCheckpoint(playerid, StreetData[id][StreetX], StreetData[id][StreetY], 0.0, 5.0);
	return 1;
}

Dialog:GPS_PROPERTY_NO(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	if(!IsNumeric(inputtext)) {
		return ShowNavigatorSys(playerid, 1, "Girdiðin kapý numarasý sayýsal bir deðer olmalýdýr.");
	}

	if(strval(inputtext) < 0 || strval(inputtext) > 10000) {
		return ShowNavigatorSys(playerid, 1, "Girdiðin kapý numarasý 0 ile 10000 arasýnda olmalýdýr.");
	}

	strcat(PropertyNameHolder[playerid], inputtext);
	Dialog_Show(playerid, GPS_PROPERTY_STREET, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", "Evin bulunduðu sokaðýn adý nedir? (örneðin: Ferndale Avenue)", "Ýleri", "Geri");
	return 1;
}

Dialog:GPS_PROPERTY_STREET(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	if(strlen(inputtext) < 1) {
		Dialog_Show(playerid, GPS_PROPERTY_STREET, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", "Evin bulunduðu sokaðýn adý nedir? (örneðin: Ferndale Avenue)", "Ýleri", "Geri");
		return 1;
	}

	format(PropertyNameHolder[playerid], 35, "%s %s", PropertyNameHolder[playerid], inputtext); 

	new bool: found, id;
	foreach(new i : Properties)
	{
		if(strfind(PropertyData[i][PropertyAddress], PropertyNameHolder[playerid], true) != -1)
		{
			found = true;
			id = i;
			break;
		}
	}

	if(!found) {
		ShowNavigatorSys(playerid, 1, "Hiç sonuç bulunamadý.");
		return 1;
	}

	SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Ev haritanýzda iþaretlendi.");
	SetPlayerCheckpoint(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2], 3.0);
	return 1;
}

Dialog:GPS_BUSINESS_LIST(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		return cmd_samaps(playerid, "");
	}

	new id;
	sscanf(inputtext, "i", id);
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritanýzda iþaretlendi.", BusinessData[id][BusinessName]);
	SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
	return 1;
}