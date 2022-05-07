CMD:cezalarim(playerid, params[])
{
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet sýnavýndayken bu komutu kullanamazsýn.");
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi sýnavýndayken bu komutu kullanamazsýn.");

	new id;
	if(sscanf(params, "U(-1)", id)) return 1;
	if(id != -1) {
		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
		if(!GetDistanceBetweenPlayers(playerid, id, 5.0)) return SendErrorMessage(playerid, "Belirttiðiniz kiþiye yakýn deðilsin.");
	}

	Player_ShowFines(playerid, id != -1 ? !IsPoliceFaction(playerid) ? playerid : id : playerid);
	return 1;
}

Player_ShowFines(receiver, viewing)
{
	new
		caption[90], primary_str[800], sub_str[128], has_fines;

	CheckingPlayerFine[receiver] = viewing;

    format(primary_str, sizeof(primary_str), "Ceza Numarasý\tCeza Miktarý\n");
	
	for (new i = 0; i < MAX_FINES; i++)
	{
		if(!Fines[viewing][i][fine_id]) continue;
		format(sub_str, sizeof(sub_str), "{ADC3E7}Ceza [%i]{FFFFFF}\t$%s\n", Fines[viewing][i][fine_id], MoneyFormat(Fines[viewing][i][fine_amount]));
		strcat(primary_str, sub_str);
		has_fines++;
	}

	format(caption, sizeof(caption), "{ADC3E7}%s adlý kiþinin cezalarý:", ReturnName(viewing, 1));

	if(!has_fines)
	{
		strcat(primary_str, "Listelenecek bir cezan yok.\n");
		return Dialog_Show(receiver, FINE_LIST, DIALOG_STYLE_TABLIST_HEADERS, caption, primary_str, ">>", "<<");
	}

	Dialog_Show(receiver, FINE_LIST, DIALOG_STYLE_TABLIST_HEADERS, caption, primary_str, "Seç", "<<");
	return 1;
}

Vehicle_ShowFines(vehicleid, receiver, viewing)
{
	new
		caption[90], primary_str[800], sub_str[128], has_fines;

	CheckingPlayerFine[receiver] = viewing;

    format(primary_str, sizeof(primary_str), "#\tMiktar\tLokasyon\n");
	for (new i = 0; i < MAX_FINES; i++)
	{
		if(!VehicleFines[vehicleid][i][fine_id]) continue;
		format(sub_str, sizeof(sub_str), "{ADC3E7}Ceza [%i]{FFFFFF}\t$%s\n", VehicleFines[vehicleid][i][fine_id], MoneyFormat(VehicleFines[vehicleid][i][fine_amount]), GetZoneName(VehicleFines[vehicleid][i][fine_x], VehicleFines[vehicleid][i][fine_y], VehicleFines[vehicleid][i][fine_z]));
		strcat(primary_str, sub_str);
		has_fines++;
	}

	format(caption, sizeof(caption), "{ADC3E7}%s(%s) Cezalarý:", ReturnVehicleName(vehicleid), CarData[vehicleid][carPlates]);

	if(!has_fines)
	{
		strcat(primary_str, "Listelenecek bir cezan yok.\n");
		return Dialog_Show(receiver, VEHICLE_FINE_LIST, DIALOG_STYLE_TABLIST_HEADERS, caption, primary_str, ">>", "<<");
	}

	Dialog_Show(receiver, VEHICLE_FINE_LIST, DIALOG_STYLE_TABLIST_HEADERS, caption, primary_str, "Seç", "<<");
	return 1;
}

Dialog:VEHICLE_FINE_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{

		new 
			primary_str[800], sub_str[128], id;

		id = CheckingPlayerFine[playerid];

		format(sub_str, sizeof(sub_str), "Birlik:\t%s\n", FactionData[VehicleFines[id][listitem][fine_faction]][FactionName]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Cezayý Yiyen:\t%s\n", ReturnName(playerid, 0));
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Cezayý Kesen:\t%s\n\n", VehicleFines[id][listitem][fine_issuer]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Miktarý:\t$%s\n", MoneyFormat(VehicleFines[id][listitem][fine_amount]));
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Sebebi:\t%s\n", VehicleFines[id][listitem][fine_reason]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Tarihi:\t%s\n\n", GetFullTime(VehicleFines[id][listitem][fine_date]));
		strcat(primary_str, sub_str);

		strcat(primary_str, "Bu cezayý teslim aldýktan sonra 72 saate\nkadar ödemek zorundasýnýz.");

		Dialog_Show(playerid, FINE_PAY, DIALOG_STYLE_MSGBOX, "Ceza Detayý", primary_str, "Öde", "Kapat");
		return 1;
	}
	return 1;
}

Dialog:FINE_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!strcmp(inputtext, "** Cezayý silmek için týkla."))
		{
			if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
				return Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_LIST, "Ceza Temizle:", "Rütben cezalarý temizlemek için yetersiz.", ">>", "<<");

			return Dialog_Show(playerid, FINE_DELETE, DIALOG_STYLE_INPUT, "Ceza Temizle:", "Cezanýn numarasýný girerek temizleyebilirsin.", "Temizle", "Kapat");
		}

		new 
			primary_str[800], sub_str[128], id;

		id = CheckingPlayerFine[playerid];

		format(sub_str, sizeof(sub_str), "Birlik:\t%s\n", FactionData[Fines[id][listitem][fine_faction]][FactionName]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Cezayý Yiyen:\t%s\n", ReturnName(playerid, 0));
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Cezayý Kesen:\t%s\n\n", Fines[id][listitem][fine_issuer]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Miktarý:\t$%s\n", MoneyFormat(Fines[id][listitem][fine_amount]));
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Sebebi:\t%s\n", Fines[id][listitem][fine_reason]);
		strcat(primary_str, sub_str);

		format(sub_str, sizeof(sub_str), "Ceza Tarihi:\t%s\n\n", GetFullTime(Fines[id][listitem][fine_date]));
		strcat(primary_str, sub_str);

		strcat(primary_str, "Bu cezayý teslim aldýktan sonra 72 saate\nkadar ödemek zorundasýnýz.");

		Dialog_Show(playerid, FINE_PAY, DIALOG_STYLE_MSGBOX, "Ceza Detayý", primary_str, "Öde", "Kapat");
		return 1;
	}
	return 1;
}

Dialog:FINE_PAY(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		new id = -1;
		foreach(new i : Properties)
		{
			if(PropertyData[i][PropertyFaction] == -1) continue;
			if(!FactionData[PropertyData[i][PropertyFaction]][FactionCopPerms]) continue;

			id = i;
			break;
		}

		if(id == -1) return 1;

		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Central büro haritanýzda iþaretlendi.");
		SetPlayerCheckpoint(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2], 5.0);
	}
	return 1;
}

CMD:cezaode(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) == -1) 
	{
		if(PropertyData[h][PropertyFaction] != -1)
		{
			if(FactionData[PropertyData[h][PropertyFaction]][FactionCopPerms])
			{
				new bool: has_fines = false;
				for(new i = 0; i < MAX_FINES; i++)
				{
					if(!Fines[playerid][i][fine_id]) continue;
					has_fines = true;
				}

				if(!has_fines) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Ödeyecek herhangi bir cezan yok.");

				new
					f_id, index,
					bool:fine_exists = false;

				if(sscanf(params, "i", f_id)) {
					return SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /cezaode [ceza ID] (IDleri /cezalarim yazarak görebilirsin.)");
				}

				for(new i = 0; i < MAX_FINES; i++)
				{
					if(!Fines[playerid][i][fine_id]) continue;

					if(Fines[playerid][i][fine_id] == f_id)
					{
						fine_exists = true;
						index = i;
					}
				}

				if(!fine_exists) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Böyle bir numaralý cezan bulunmuyor.");
				ConfirmDialog(playerid, "Onay", sprintf("{ADC3E7}Ceza #%i {FFFFFF}numaralý cezayý ödemek üzeresin.\nCeza Tutarý: {ADC3E7}$%s.", f_id, MoneyFormat(Fines[playerid][index][fine_amount])), "OnPlayerPayFine", index);
			}
		}	
	}

	SendServerMessage(playerid, "Yakýnýnda ceza ödeyebileceðin bir nokta bulunmuyor.");
	return 1;
}

Server:OnPlayerPayFine(playerid, response, index)
{
	if(response)
	{
		if(PlayerData[playerid][pMoney] < Fines[playerid][index][fine_amount]) {
			return SendErrorMessage(playerid, "Bu cezayý ödemek için yeterli paran yok.");
		}

		new query[50];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM player_fines WHERE id = %i", Fines[playerid][index][fine_id]);
		new Cache: cache = mysql_query(m_Handle, query); GiveMoney(playerid, -Fines[playerid][index][fine_amount]);
		SendClientMessageEx(playerid, COLOR_ADM, "SERVER: %s tarihi itibariyle $%s miktarýnda ceza ödedin.", GetFullTime(Time()), MoneyFormat(Fines[playerid][index][fine_amount]));
		FactionData[Fines[playerid][index][fine_faction]][FactionBank]+= Fines[playerid][index][fine_amount];
		Fines[playerid][index][fine_faction] = 0;
		Fines[playerid][index][fine_amount] = 0;
		Fines[playerid][index][fine_id] = 0;
		cache_delete(cache);
	}
	return 1;
}

CountVehicleFines(vehicleid)
{
	new fine_count = 0;
	for(new i = 0; i < MAX_FINES; i++) if(VehicleFines[vehicleid][i][fine_id]) fine_count++;
	return fine_count;
}

CountVehicleFinesTotal(vehicleid)
{
	new
		totalCount;

	for(new i = 0; i < MAX_FINES; i++) if(VehicleFines[vehicleid][i][fine_id])
		totalCount += VehicleFines[vehicleid][i][fine_amount];

	return totalCount;
}

stock ClearVehicleFines(vehicleid)
{
	new
		clearQuery[128];

	mysql_format(m_Handle, clearQuery, sizeof(clearQuery), "DELETE FROM vehicle_fines WHERE vehicle_dbid = %i", CarData[vehicleid][carID]);
	mysql_tquery(m_Handle, clearQuery, "OnVehicleFinesCleared", "i", vehicleid);
	return 1;
}

Server:OnVehicleFinesCleared(vehicleid)
{
	for(new i = 0; i < MAX_FINES; i++) if(VehicleFines[vehicleid][i][fine_id])
		FactionData[VehicleFines[vehicleid][i][fine_faction]][FactionBank]+= VehicleFines[vehicleid][i][fine_amount];

	for(new i = 0; i < MAX_FINES; i++) if(VehicleFines[vehicleid][i][fine_id])
	{
		VehicleFines[vehicleid][i][fine_id] = 0;
		VehicleFines[vehicleid][i][fine_amount] = 0;
		VehicleFines[vehicleid][i][fine_faction] = 0;
	}
	return 1;
}