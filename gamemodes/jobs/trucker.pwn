CMD:tpda(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != TRUCKER_JOB && PlayerData[playerid][pJob] != TRUCKER_JOB) 
		return SendClientMessage(playerid, COLOR_ADM, "SERVER: Kamyon þoförü deðilsin.");

 	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Herhangi bir araçta deðilsin.");
	Dialog_Show(playerid, PDA_MAIN, DIALOG_STYLE_LIST, "Trucker PDA", "{FFFFFF}Tüm fabrikalarý {AFAFAF}göster\n{FFFFFF}Kargo kabul eden iþyerlerini {AFAFAF}göster\n{FFFFFF}Gemi bilgisini {AFAFAF}göster", "Seç", "Kapat");
	return 1;
}

CMD:endustri(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != TRUCKER_JOB && PlayerData[playerid][pJob] != TRUCKER_JOB) 
		return SendClientMessage(playerid, COLOR_ADM, "SERVER: Kamyon þoförü deðilsin.");

	new id = -1;
	if((id = Industry_Nearest(playerid, 10.0)) == -1)
		return SendErrorMessage(playerid, "Yakýnýnda endüstri yok.");

    Industry_Show(playerid, id);
	return 1;
}

Dialog:PDA_MAIN(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;

	switch(listitem)
	{
	    case 0:
	    {
			new count,
			    mes[1512];

	        foreach(new i : Trucker)
		    {
      			PlayerData[playerid][pPDAListed][i] = -1;

				if(TruckerData[i][tType] == 2 || TruckerData[i][tType] == 3 || TruckerData[i][tGps] == 0)
				    continue;

                PlayerData[playerid][pPDAListed][count] = i;
				format(mes, sizeof(mes), "%s\n%s (%s, {9ACD32}%s{FFFFFF})", mes, TruckerData[i][tName], TruckerData_type[TruckerData[i][tType]], TruckerData[i][tLocked] == 0 ? "açýk" : "kapalý");
				count++;
			}

			if(count)
				Dialog_Show(playerid, PDA_MAIN_INDUSTRY, DIALOG_STYLE_LIST, "Trucker PDA - Fabrikalar", mes, "Seç", "Geri");
			else
			    Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "Trucker PDA - Fabrikalar", "Hiç fabrika yok.", "Kapat", "");
		}
	    case 1:
	    {
	        Business_Industry(playerid, 0);
	        return 1;
	    }
	    case 2:
	    {
	        new mes[1024],
	    		str_len;

		    format(mes, sizeof(mes), "{9ACD32}Gemi{FFFFFF}'ye hoþgeldin!\n\n\
		    	{FFFFFF}Gemi þuan {9ACD32}%s.\n\n\
		    	{FFFFFF}Aþaðýdaki zaman dilimleri kesin deðildir, yaklaþýktýr.\n\n\
		    	Geliþ Saati:\t\t%s\nKalkýþ Saati:\t\t%s\nDönüþ Saati:\t\t%s\n\n\
		    	{9ACD32}Satýlan:\n{808080}Bu gemi hiç bir þey satmýyor, sadece San Andreas'tan kargo alýyor.\n\n\
		    	{9ACD32}Alýnan:\n{808080}Ürün\t\t\tFiyat\t\tStok (depo boyutu){FFFFFF}",
			ship_docked == 1 ? "limanda" : "limanda deðil", GetShipHour(ship_arrived), GetShipHour(ship_depart), GetShipHour(ship_next));

			foreach(new i : Trucker)
		    {
				if(TruckerData[i][tType] != 2)
				    continue;

				TruckerData_product[TruckerData[i][tProductID]][0] = toupper(TruckerData_product[TruckerData[i][tProductID]][0]);
	            str_len = strlen(TruckerData_product[TruckerData[i][tProductID]]);
	            format(mes, sizeof(mes), "%s\n%s%s\t\t$%i\t\t\t%i %s {808080}(%i){FFFFFF}", mes, TruckerData_product[TruckerData[i][tProductID]], str_len < 6 ? "\t" : "",
				TruckerData[i][tPrice], TruckerData[i][tStorage], Trucker_GetType(TruckerData[i][tProductID]), TruckerData[i][tStorageSize]);
		    }

		    Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "Gemi", mes, "Kapat", "");
	    }
	}
	return 1;
}

Dialog:PDA_MAIN_INDUSTRY(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		cmd_tpda(playerid, "");
		return 1;
	}

	listitem = PlayerData[playerid][pPDAListed][listitem];

    if(listitem == -1)
		return 1;

    Industry_Show(playerid, listitem, 1);
	return 1;
}

Industry_Update(id)
{
	UpdateDynamic3DTextLabelText(TruckerData[id][tLabel], -1, sprintf("[{FFFF00}%s{FFFFFF}]\nStok: %i / %i\nFiyat: $%i / birim baþý", TruckerData_product[TruckerData[id][tProductID]], TruckerData[id][tStorage], TruckerData[id][tStorageSize], TruckerData[id][tPrice])); 
	return 1;
}

Industry_Refresh(id)
{
	if(IsValidDynamic3DTextLabel(TruckerData[id][tLabel])) DestroyDynamic3DTextLabel(TruckerData[id][tLabel]);
    if(IsValidDynamicPickup(TruckerData[id][tPickup])) DestroyDynamicPickup(TruckerData[id][tPickup]);

	TruckerData[id][tLabel] = CreateDynamic3DTextLabel(sprintf("[{FFFF00}%s{FFFFFF}]\nStok: %i / %i\nFiyat: $%i / birim baþýna", TruckerData_product[TruckerData[id][tProductID]], TruckerData[id][tStorage], TruckerData[id][tStorageSize], TruckerData[id][tPrice]), 0xFFFFFFFF, TruckerData[id][tPosX], TruckerData[id][tPosY], TruckerData[id][tPosZ]+0.8, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    TruckerData[id][tPickup] = CreateDynamicPickup(1318, 1, TruckerData[id][tPosX], TruckerData[id][tPosY], TruckerData[id][tPosZ], 0, 0, -1, 100.0);
	return 1;
}

Industry_Save(id)
{
	new
	    query[254];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE truck_cargo SET type = %i, name = '%e', storage = %i, storage_size = %i, price = %i, product_id = %i WHERE id = %i",
		TruckerData[id][tType],
		TruckerData[id][tName],
		TruckerData[id][tStorage],
		TruckerData[id][tStorageSize],
		TruckerData[id][tPrice],
		TruckerData[id][tProductID],
		TruckerData[id][tID]);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE truck_cargo SET product_amount = %i, pack = %i, x = %f, y = %f, z = %f, locked = %i, gps = %i WHERE id = %i",
		TruckerData[id][tProductAmount],
		TruckerData[id][tPack],
		TruckerData[id][tPosX],
		TruckerData[id][tPosY],
		TruckerData[id][tPosZ],
		TruckerData[id][tLocked],
		TruckerData[id][tGps],
		TruckerData[id][tID]);
	mysql_tquery(m_Handle, query);
	return 1;
}

Industry_Show(playerid, id, gps = 0)
{
	new mes[1024],
		title[64 + 9],
	    str_len;

	SetPVarInt(playerid, "industry_id", id);

	switch(TruckerData[id][tType])
	{
		case 0:
		{
			format(title, sizeof(title), "{9ACD32}%s", TruckerData[id][tName]);
		    format(mes, sizeof(mes), "{9ACD32}%s {FFFFFF}fabrikasýna hoþgeldin!\n\n\
		    	{FFFFFF}Bu fabrika þuan da {9ACD32}%s.\n\n\
		    	{9ACD32}Satýlan:\n{808080}Ürün\t\t\tFiyat\t\tÜretim/Saat\t\tStok (depo boyutu){FFFFFF}", 
		    	TruckerData[id][tName], TruckerData[id][tLocked] == 0 ? "açýk" : "kapalý");

	        foreach(new i : Trucker)
		    {
				if(TruckerData[id][tPack] == 0 && id != i || TruckerData[i][tType] != 0 || TruckerData[i][tPack] != TruckerData[id][tPack])
				    continue;

				TruckerData_product[TruckerData[i][tProductID]][0] = toupper(TruckerData_product[TruckerData[i][tProductID]][0]);
	            str_len = strlen(TruckerData_product[TruckerData[i][tProductID]]);
	            format(mes, sizeof(mes), "%s\n%s%s\t\t$%i\t\t\t%s%i\t\t\t\t%i %s {808080}(%i){FFFFFF}", mes, TruckerData_product[TruckerData[i][tProductID]], str_len < 6 ? "\t" : "",
				TruckerData[i][tPrice], TruckerData[i][tProductAmount] > 0 ? "+" : "", TruckerData[i][tProductAmount], TruckerData[i][tStorage], Trucker_GetType(TruckerData[i][tProductID]), TruckerData[i][tStorageSize]);
		    }
		    strcat(mes, "\n\n{9ACD32}Alýnan:\n{808080}Bu fabrika hiç bir þey almýyor.");
		}
		case 2:
		{
			format(title, sizeof(title), "{9ACD32}Gemi");
		    str_len = strlen(TruckerData_product[TruckerData[id][tProductID]]);
		    format(mes, sizeof(mes), "{9ACD32}Gemi{FFFFFF}'ye hoþgeldin!\n\n\
		    	{FFFFFF}Gemi þuan {9ACD32}%s.\n\n\
		    	{FFFFFF}Aþaðýdaki zaman dilimleri kesin deðildir, yaklaþýktýr.\n\n\
		    	Geliþ Saati:\t\t%s\nKalkýþ Saati:\t\t%s\nDönüþ Saati: %s\n\n\
		    	{9ACD32}Satýlan:\n{808080}Bu gemi hiç bir þey satmýyor, sadece San Andreas'tan kargo alýyor.\n\n\
		    	{9ACD32}Alýnan:\n{808080}Ürün\t\t\tFiyat\t\tStok (depo boyutu){FFFFFF}",
			ship_docked == 1 ? "limanda" : "limanda deðil", GetShipHour(ship_arrived), GetShipHour(ship_depart), GetShipHour(ship_next));

			foreach(new i : Trucker)
		    {
				if(TruckerData[i][tType] != 2)
				    continue;

				TruckerData_product[TruckerData[i][tProductID]][0] = toupper(TruckerData_product[TruckerData[i][tProductID]][0]);
	            str_len = strlen(TruckerData_product[TruckerData[i][tProductID]]);
	            format(mes, sizeof(mes), "%s\n%s%s\t\t$%i\t\t\t%i %s {808080}(%i){FFFFFF}", mes, TruckerData_product[TruckerData[i][tProductID]], str_len < 6 ? "\t" : "",
				TruckerData[i][tPrice], TruckerData[i][tStorage], Trucker_GetType(TruckerData[i][tProductID]), TruckerData[i][tStorageSize]);
		    }
		}
		case 1, 3:
		{
		    format(title, sizeof(title), "{9ACD32}%s", TruckerData[id][tName]);
		    format(mes, sizeof(mes), "{9ACD32}%s {FFFFFF}fabrikasýna hoþgeldin!\n\n\
		    	{FFFFFF}Bu fabrika þuan da {9ACD32}%s.\n\n\
		    	{9ACD32}Satýlan:\n{808080}Ürün\t\t\tFiyat\t\tÜretim/Saat\t\tStok (depo boyutu){FFFFFF}", 
			TruckerData[id][tName], TruckerData[id][tLocked] == 0 ? "açýk" : "kapalý");

	        foreach(new i : Trucker)
		    {
				if(TruckerData[id][tPack] == 0 && id != i || TruckerData[i][tType] != 1 || TruckerData[i][tPack] != TruckerData[id][tPack])
				    continue;

				TruckerData_product[TruckerData[i][tProductID]][0] = toupper(TruckerData_product[TruckerData[i][tProductID]][0]);
	            str_len = strlen(TruckerData_product[TruckerData[i][tProductID]]);
	            format(mes, sizeof(mes), "%s\n%s%s\t\t$%i\t\t\t%s%i\t\t\t\t%i %s {808080}(%i){FFFFFF}", mes, TruckerData_product[TruckerData[i][tProductID]], str_len < 6 ? "\t" : "",
				TruckerData[i][tPrice], TruckerData[i][tProductAmount] > 0 ?  "+" : "", TruckerData[i][tProductAmount], TruckerData[i][tStorage], Trucker_GetType(TruckerData[i][tProductID]), TruckerData[i][tStorageSize]);
		    }

		    strcat(mes, "\n\n{9ACD32}Alýnan\n{808080}Ürün\t\t\tFiyat\t\tTüketim/Saat\t\tStok (depo boyutu){FFFFFF}");

		    foreach(new i : Trucker)
		    {
				if(TruckerData[id][tPack] == 0 && id != i || TruckerData[i][tType] != 3 || TruckerData[i][tPack] != TruckerData[id][tPack])
				    continue;

				TruckerData_product[TruckerData[i][tProductID]][0] = toupper(TruckerData_product[TruckerData[i][tProductID]][0]);
	            str_len = strlen(TruckerData_product[TruckerData[i][tProductID]]);
	            format(mes, sizeof(mes), "%s\n%s%s\t\t$%i\t\t\t%s%i\t\t\t\t%i %s {808080}(%i){FFFFFF}", mes, TruckerData_product[TruckerData[i][tProductID]], str_len < 6 ? "\t" : "",
				TruckerData[i][tPrice], TruckerData[i][tProductAmount] > 0 ? "+" : "", TruckerData[i][tProductAmount], TruckerData[i][tStorage], Trucker_GetType(TruckerData[i][tProductID]), TruckerData[i][tStorageSize]);
		    }
		}
	}

	if(gps == 1)
		Dialog_Show(playerid, PDA_SUB_INDUSTRY, DIALOG_STYLE_MSGBOX, title, mes, "Ýlerle", "Kapat");
	else
	    Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, title, mes, "Kapat", "");
	return 1;
}

Dialog:PDA_SUB_INDUSTRY(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		new count,
			mes[1512];

		foreach(new i : Trucker)
		{
			PlayerData[playerid][pPDAListed][i] = -1;

			if(TruckerData[i][tType] == 2 || TruckerData[i][tType] == 3 || TruckerData[i][tGps] == 0)
				continue;

			PlayerData[playerid][pPDAListed][count] = i;
			format(mes, sizeof(mes), "%s\n%s (%s, {9ACD32}%s{FFFFFF})", mes, TruckerData[i][tName], TruckerData_type[TruckerData[i][tType]], TruckerData[i][tLocked] == 0 ? "açýk" : "kapalý");
			count++;
		}

		if(count)
			Dialog_Show(playerid, PDA_MAIN_INDUSTRY, DIALOG_STYLE_LIST, "Trucker PDA - Fabrikalar", mes, "Seç", "Geri");
		else
			Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "Trucker PDA - Fabrikalar", "Hiç fabrika yok.", "Kapat", "");
		return 1;
	}

    listitem = GetPVarInt(playerid, "industry_id");

    if(listitem < 0 || listitem > MAX_TRUCK_CARGO) // || TruckerData[listitem][tOn] == 0
		return 1;

	if(TruckerData[listitem][tPack] == 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "{9ACD32}%s {FFFFFF}haritada iþaretlendi.", TruckerData[listitem][tName]);
	    SetPlayerCheckpoint(playerid, TruckerData[listitem][tPosX], TruckerData[listitem][tPosY], TruckerData[listitem][tPosZ], 5.0);
    	PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	    return 1;
	}

	new count,
 		mes[512];

	foreach(new i : Trucker)
 	{
		PlayerData[playerid][pPDAListed][i] = -1;

		if(TruckerData[i][tPack] == 0 || TruckerData[i][tPack] != TruckerData[listitem][tPack])
		    continue;

		PlayerData[playerid][pPDAListed][count] = i;
		format(mes, sizeof(mes), "%s\n{9ACD32}- %s {808080}({FFFFFF}%s $%i {808080}/ birim, {FFFFFF}%i {808080}/ %i)", mes, TruckerData[i][tType] == 3 ? "alýyor" : "satýyor", TruckerData_product[TruckerData[i][tProductID]], TruckerData[i][tPrice], TruckerData[i][tStorage], TruckerData[i][tStorageSize]);
		count++;
	}

	Dialog_Show(playerid, PDA_SUB_INDUSTRY_NAV, DIALOG_STYLE_LIST, "Trucker PDA - Navigasyon", mes, "Ýþaretle", "Geri");
	return 1;
}

Dialog:PDA_SUB_INDUSTRY_NAV(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return cmd_tpda(playerid, "");

    listitem = PlayerData[playerid][pPDAListed][listitem];

    if(listitem < 0 || listitem > MAX_TRUCK_CARGO) // TruckerData[listitem][tOn] == 0 
		return 1;

	SendClientMessageEx(playerid, COLOR_WHITE, "{9ACD32}%s {FFFFFF}haritada iþaretlendi.", TruckerData[listitem][tName]);
	SetPlayerCheckpoint(playerid, TruckerData[listitem][tPosX], TruckerData[listitem][tPosY], TruckerData[listitem][tPosZ], 5.0);
	PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	return 1;
}

Business_Industry(playerid, list = 0)
{
	if(list < 0 || list > 10) list = 0;

    new count,
        id,
        sub_str[128], primary_str[1024];

    strcat(primary_str, "{9ACD32}<<\n");

    for(new i; i != 10; i++)
		PlayerData[playerid][pCargoListed][i] = -1;

    foreach(new i : Businesses)
    {
		if(BusinessData[i][BusinessWantedProduct] == 0)
		    continue;

        if(count < list * 10)
			continue;

        id = biz_prod_types[BusinessData[i][BusinessType]];
		
		format(sub_str, sizeof(sub_str), "%s\t$%i / birim baþýna\t%i %s\t%s\n",  
			TruckerData_product[id], 
			BusinessData[i][BusinessProductPrice], 
			BusinessData[i][BusinessWantedProduct], 
			Trucker_GetType(id), 
			BusinessData[i][BusinessName]);

		strcat(primary_str, sub_str);

        PlayerData[playerid][pCargoListed][count - (list * 10)] = i;

		if(count++ == (list * 10) + 9)
			break;
	}

	if(count == 0)
	    return 1;

	if(count == (list * 10) + 9)
	    strcat(primary_str, "{9ACD32}>>");

 	Dialog_Show(playerid, PDA_BUSINESS, DIALOG_STYLE_LIST, "Trucker PDA - Ýþyerleri", primary_str, "Ýþaretle", "Geri");
 	SetPVarInt(playerid, "business_id", list);
	return 1;
}

Dialog:PDA_BUSINESS(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return cmd_tpda(playerid, "");

	if(listitem == 0)
		return Business_Industry(playerid, GetPVarInt(playerid, "business_id")-1);

    if(listitem == 11)
		return Business_Industry(playerid, GetPVarInt(playerid, "business_id")+1);

	if(PlayerData[playerid][pCargoListed][listitem-1] == -1)
	    return 1;

	new bizid = PlayerData[playerid][pCargoListed][listitem-1];

	if(!Iter_Contains(Businesses, bizid))
	    return 1;

	SendClientMessageEx(playerid, COLOR_WHITE, "{9ACD32}%s {FFFFFF}haritada iþaretlendi.", BusinessData[bizid][BusinessName]);
	SetPlayerCheckpoint(playerid, BusinessData[bizid][EnterPos][0], BusinessData[bizid][EnterPos][1], BusinessData[bizid][EnterPos][2], 5.0);
	PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	return 1;
}

CheckIndustries()
{
	new
		industires_prods[MAX_TRUCK_PACK char];

	foreach(new i : Trucker)
	{
		if(TruckerData[i][tType] == 0)
		{
		    TruckerData[i][tStorage] += TruckerData[i][tProductAmount];

		    if(TruckerData[i][tStorage] > TruckerData[i][tStorageSize])
		        TruckerData[i][tStorage] = TruckerData[i][tStorageSize];

		    else if(TruckerData[i][tStorage] < 0)
		        TruckerData[i][tStorage] = 0;

		    Industry_Update(i);
		}
		else if(TruckerData[i][tType] == 3)
		{
			if(TruckerData[i][tStorage] >= (-TruckerData[i][tProductAmount]))
			{
		    	TruckerData[i][tStorage] -= (-TruckerData[i][tProductAmount]);
				industires_prods{TruckerData[i][tPack]} += (-TruckerData[i][tProductAmount]);
			}
			Industry_Update(i);
		}
	}

	foreach(new i : Trucker)
	{
	    if(TruckerData[i][tType] != 1 || TruckerData[i][tPack] == 0 || TruckerData[i][tStorage] >= TruckerData[i][tStorageSize])
	        continue;

		if(industires_prods{TruckerData[i][tPack]} >= TruckerData[i][tProductAmount])
			TruckerData[i][tStorage] += TruckerData[i][tProductAmount];

        if(TruckerData[i][tStorage] > TruckerData[i][tStorageSize])
        	TruckerData[i][tStorage] = TruckerData[i][tStorageSize];

        Industry_Update(i);
	}
	return 1;
}

CMD:trailer(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != TRUCKER_JOB && PlayerData[playerid][pJob] != TRUCKER_JOB) 
		return SendClientMessage(playerid, COLOR_ADM, "SERVER: Kamyon þoförü deðilsin.");

    if(!IsPlayerInAnyVehicle(playerid))
		return 1;

    new vehicle = GetPlayerVehicleID(playerid),
   		trailerid = GetVehicleTrailer(vehicle);

    if(!IsTruckCar(vehicle))
        return 1;

    if(trailerid == 0)
    	return SendErrorMessage(playerid, "Aracýna baðlý trailer yok.");

	new parametrs[10];
	if(sscanf(params, "s[10]", parametrs))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "/trailer kilit{FFFFFF} - Traileri kilitler.");
		SendClientMessage(playerid, COLOR_YELLOW, "/trailer coz{FFFFFF} - Trailer baðlantýsý koparýr.");
		SendClientMessage(playerid, COLOR_YELLOW, "/trailer isik{FFFFFF} - Trailerýn ýþýklarýný açar.");
		SendClientMessage(playerid, COLOR_YELLOW, "/trailer liste{FFFFFF} - Trailerdaki kargolarý gösterir.");
		return 1;
	}

	if(!strcmp(parametrs, "liste", true) || !strcmp(parametrs, "kargo", true))
	{
		new title[52],
	        msg[512] = "{9ACD32}Ürün\t{9ACD32}Adet",
         	count;

	    format(title, sizeof(title), "Trailer (Kapasite: %i)", GetMaxCargoVehicle(trailerid));

		for(new i; i != MAX_TRUCK_PRODUCT; i++)
		{
		    if(CarData[trailerid][carCargoAmount][i] == 0)
		        continue;

			format(msg, sizeof(msg), "%s\n%s\t%i %s.", msg, TruckerData_product[i], CarData[trailerid][carCargoAmount][i], Trucker_GetType(i));
			count++;
		}

		if(!count)
		    return SendErrorMessage(playerid, "Bu trailerda hiç kargo yok.");

		Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, title, msg, "Kapat", "");
	    return 1;
	}
	else if(!strcmp(parametrs, "coz", true))
	{
	    if(GetVehicleSpeed(vehicle) > 3)
	        return SendErrorMessage(playerid, "Hareket halinde traileri çözemezsin.");

        DetachTrailerFromVehicle(vehicle);
	    return 1;
	}
	else if(!strcmp(parametrs, "isik", true))
	{
		if(CarLights[trailerid])
		{
			CarLights[trailerid] = false;
			ToggleVehicleLights(trailerid, false);
			GameTextForPlayer(playerid, "~w~TRAILER ISIKLARI ~r~KAPANDI", 2500, 4);
		}
		else
		{
			CarLights[trailerid] = true;
			ToggleVehicleLights(trailerid, true);
			GameTextForPlayer(playerid, "~w~TRAILER ISIKLARI ~g~ACILDI", 2500, 4);
		}
	    return 1;
	}
	else if(!strcmp(parametrs, "kilit", true))
	{
		if(!CarData[trailerid][carLocked])
		{
			ToggleVehicleLock(trailerid, true);
			CarData[trailerid][carLocked] = true;
			GameTextForPlayer(playerid, sprintf("~r~%s KILITLENDI", ReturnVehicleName(trailerid)), 2000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		}
		else
		{
			ToggleVehicleLock(trailerid, false);
			CarData[trailerid][carLocked] = false;
			GameTextForPlayer(playerid, sprintf("~g~%s ACILDI", ReturnVehicleName(trailerid)), 2000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		}
	    return 1;
	}
	return 1;
}

CMD:kargo(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != TRUCKER_JOB && PlayerData[playerid][pJob] != TRUCKER_JOB) 
		return SendClientMessage(playerid, COLOR_ADM, "SERVER: Kamyon þoförü deðilsin.");

	new parametrs[10], arg[4];
	if(sscanf(params, "s[10]S()[4]", parametrs, arg))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo liste{FFFFFF} - Araçtaki tüm kargolarý gösterir.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo yerlestir{FFFFFF} - Elinizdeki kargoyu araca koyar.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo fork{FFFFFF} - Yakýndaki araçtan forklifte kargo alýr.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo koy{FFFFFF} - Elinizdeki kargoyu yere koyar.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo al{FFFFFF} - Yerdeki kargoyu elinize alýr.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo satinal{FFFFFF} - Kargo satýn alýr.");
		SendClientMessage(playerid, COLOR_YELLOW, "/kargo sat{FFFFFF} - Kargo satar.");
		return 1;
	}

	if(!strcmp(parametrs, "liste", true))
	{
	    new vehicle = GetPlayerVehicleID(playerid);
		if(vehicle == 0 && (vehicle = GetNearBootVehicle(playerid)) == 0)
	    	return SendErrorMessage(playerid, "Yakýnýnda araç/trailer yok.");

        if(IsTruckCar(vehicle))
			return SendErrorMessage(playerid, "Trailer yüklenmiþ kargolarý listelemek için /trailer liste yazmalýsýn.");

		if(!IsTruckerJob(vehicle))
		    return SendErrorMessage(playerid, "Bu araç kargo taþýyabilecek tipten deðil.");

		if(!ValidTruckForPlayer(playerid, vehicle))
		    return SendErrorMessage(playerid, "Bu aracý kullanmanýz için meslek rütbeniz yetersiz. (/meslek yardim)");

		if(CarData[vehicle][carLocked])
			return SendErrorMessage(playerid, "Bu araç kilitli.");

	    new title[52],
	        msg[512] = "{9ACD32}Ürün\t{9ACD32}Adet",
         	count;

	    format(title, sizeof(title), "%s (Kapasite: %i)", ReturnVehicleModelName(GetVehicleModel(vehicle)), GetMaxCargoVehicle(vehicle));

      	for(new i; i != MAX_TRUCK_PRODUCT; i++) 
      		PlayerData[playerid][pCargoListed][i] = 0;

		for(new i; i != MAX_TRUCK_PRODUCT; i++)
		{
		    if(CarData[vehicle][carCargoAmount][i] == 0)
		        continue;

 			PlayerData[playerid][pCargoListed][count] = i;
			format(msg, sizeof(msg), "%s\n%s\t%i %s.", msg, TruckerData_product[i], CarData[vehicle][carCargoAmount][i], Trucker_GetType(i));
			count++;
		}

		if(!count)
		    return SendErrorMessage(playerid, "Bu araçta hiç kargo yok.");

		Dialog_Show(playerid, CARGO_LIST, DIALOG_STYLE_TABLIST_HEADERS, title, msg, "Al", "Kapat");
		SetPVarInt(playerid, "cargo_veh_id", vehicle);
	    return 1;
	}
	else if(!strcmp(parametrs, "yerlestir", true))
	{
	    if(PlayerData[playerid][pCargoID] == 0)
		    return SendErrorMessage(playerid, "Hiç kargo taþýmýyorsun.");

        new vehicle;
		if((vehicle = GetNearBootVehicle(playerid)) == 0)
	    	return SendErrorMessage(playerid, "Yakýnýnda araç yok.");

		if(!IsTruckerJob(vehicle))
		    return SendErrorMessage(playerid, "Bu araç kargo taþýyabilecek tipten deðil.");

		if(!ValidTruckForPlayer(playerid, vehicle))
		    return SendErrorMessage(playerid, "Bu aracý kullanmanýz için meslek rütbeniz yetersiz. (/meslek yardim)");

		if(CarData[vehicle][carLocked])
			return SendErrorMessage(playerid, "Bu araç kilitli.");

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);

		if(!boot)
			return SendErrorMessage(playerid, "Bu aracýn bagajý kapalý.");

		if(!IsValidProductVehicle(vehicle, PlayerData[playerid][pCargoID]-1))
		    return SendErrorMessage(playerid, "Bu araç elinizdeki kargo tipini desteklemiyor.");

		new amount;
		for(new i; i != MAX_TRUCK_PRODUCT; i++)
			amount += CarData[vehicle][carCargoAmount][i];

		if(amount >= GetMaxCargoVehicle(vehicle))
		    return SendErrorMessage(playerid, "Bu araçta yer kalmamýþ.");

        switch(GetVehicleModel(vehicle))
        {
            case 600, 543, 605, 422, 478, 554, 530: CarData[vehicle][carCargoObj][amount] = CreateDynamicObject(2912, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);
            case 443: CarData[vehicle][carCargoObj][amount] = CreateDynamicObject(3593, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);
		}

		switch(GetVehicleModel(vehicle))
		{
		    case 600: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, picador_attach[amount][0], picador_attach[amount][1], picador_attach[amount][2], 0.0, 0.0, 0.0);
		    case 543, 605: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, sadler_attach[amount][0], sadler_attach[amount][1], sadler_attach[amount][2], 0.0, 0.0, 0.0);
		    case 422: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, bobcat_attach[amount][0], bobcat_attach[amount][1], bobcat_attach[amount][2], 0.0, 0.0, 0.0);
            case 478: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, walton_attach[amount][0], walton_attach[amount][1], walton_attach[amount][2], 0.0, 0.0, 0.0);
            case 554: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, yosemite_attach[amount][0], yosemite_attach[amount][1], yosemite_attach[amount][2], 0.0, 0.0, 0.0);
			case 530: AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, forklift_attach[amount][0], forklift_attach[amount][1], forklift_attach[amount][2], 0.0, 0.0, 0.0);        	
		}

		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

        cmd_putdown(playerid, "");
        if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC))
        	RemovePlayerAttachedObject(playerid, SLOT_MISC);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

		CarData[vehicle][carCargoAmount][PlayerData[playerid][pCargoID]-1]++;
		PlayerData[playerid][pCargoID] = 0;
	    return 1;
	}
	else if(!strcmp(parametrs, "koy", true))
	{
	    if(PlayerData[playerid][pCargoID] == 0)
		    return SendErrorMessage(playerid, "Hiç kargo taþýmýyorsun.");

		new id = -1;
		for(new i; i != MAX_CARGO_OBJ; i++)
		{
		    if(CargoObject[i][oOn] != 0)
		        continue;

			id = i;
			break;
		}

		if(id == -1)
		    return SendErrorMessage(playerid, "Yakýnlarda çok fazla kargo olduðu için þimdilik yere kargo koyamýyorsun.");

		CargoObject[id][oOn] = 1;
		CargoObject[id][oProduct] = PlayerData[playerid][pCargoID];

        cmd_putdown(playerid, "");
		if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC))
 			RemovePlayerAttachedObject(playerid, SLOT_MISC);
  		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    	PlayerData[playerid][pCargoID] = 0;

		new Float: x,
			Float: y,
			Float: z;
			
		GetPlayerPos(playerid, x, y, z);
        GetXYInFrontOfPlayer(playerid, x, y, 1.5);
        CargoObject[id][oZ] -= 2.0;

		CargoObject[id][oObj] =
			CreateDynamicObject(2912, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

        CargoObject[id][oX] = x,
        CargoObject[id][oY] = y,
        CargoObject[id][oZ] = z,
        CargoObject[id][oInt] = GetPlayerInterior(playerid),
        CargoObject[id][oVW] = GetPlayerVirtualWorld(playerid);

		CargoObject[id][oLabel] =
			CreateDynamic3DTextLabel(sprintf("[{FFFF00}%s{FFFFFF}]", TruckerData_product[CargoObject[id][oProduct]-1]), 0xFFFFFFFF, x, y, z+0.1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 100.0);

		return 1;
	}
	else if(!strcmp(parametrs, "al", true))
	{
        if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC) || PlayerData[playerid][pCargoID] != 0)
	    	return SendErrorMessage(playerid, "Kargo taþýyorsun.");

		new id = -1;
		for(new i; i != MAX_CARGO_OBJ; i++)
		{
			if(CargoObject[i][oOn] == 0 || !IsPlayerInRangeOfPoint(playerid, 2.0, CargoObject[i][oX], CargoObject[i][oY], CargoObject[i][oZ]) || GetPlayerVirtualWorld(playerid) != CargoObject[i][oVW] || CargoObject[i][oInt] != GetPlayerInterior(playerid))
				continue;

			id = i;
			break;
		}

        if(id == -1)
		    return SendErrorMessage(playerid, "Yakýnýnda hiç kargo yok.");

        CargoObject[id][oOn] = 0;

        PlayerData[playerid][pCargoID] = CargoObject[id][oProduct];

        cmd_liftup(playerid, "");
        SetPlayerAttachedObject(playerid, SLOT_MISC, 2912, 5, 0.102000, 0.306000, -0.228999, -1.100001, 14.499999, -1.300000, 1.000000, 1.000000, 1.000000);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

        if(IsValidDynamicObject(CargoObject[id][oObj]))
            DestroyDynamicObject(CargoObject[id][oObj]);

        if(IsValidDynamic3DTextLabel(CargoObject[id][oLabel]))
		{
			DestroyDynamic3DTextLabel(CargoObject[id][oLabel]);
	        CargoObject[id][oLabel] = Text3D:INVALID_3DTEXT_ID;
		}
	    return 1;
	}
	else if(!strcmp(parametrs, "satinal", true))
	{
	    if(IsPlayerInAnyVehicle(playerid))
		{
			new id = -1;
			if((id = Industry_Nearest(playerid, 10.0)) == -1)
	    		return SendErrorMessage(playerid, "Yakýnýnda kargo satýn alabileceðin bir nokta yok.");

            if(TruckerData[id][tLocked] == 1)
	        	return SendErrorMessage(playerid, "Bu nokta kargo satýþýna kapalý.");

		    new vehicle = GetPlayerVehicleID(playerid),
		   		trailerid = GetVehicleTrailer(vehicle);

			if(GetVehicleModel(vehicle) == 578 || GetVehicleModel(vehicle) == 443 || GetVehicleModel(vehicle) == 554 || GetVehicleModel(vehicle) == 499 || GetVehicleModel(vehicle) == 414 || GetVehicleModel(vehicle) == 456 || GetVehicleModel(vehicle) == 455 || GetVehicleModel(vehicle) == 530)
				trailerid = vehicle;

	     	if(trailerid == 0)
		        return SendErrorMessage(playerid, "Bu komutu araç içinde trailerin varken kullanabilirsin.");

            if(ValidTruckForPlayer(playerid, trailerid) == 0)
		    	return SendErrorMessage(playerid, "Bu traileri kullanmanýz için meslek rütbeniz yetersiz. (/meslek yardim)");

			if(CarData[trailerid][carLocked])
				return SendErrorMessage(playerid, "Bu trailer kilitli.");

			if(GetVehicleModel(trailerid) != 530)
			{
	            if(IsTakeProduct(TruckerData[id][tProductID]))
			        return SendErrorMessage(playerid, "Seçtiðin kargo bu trailerin taþýyabileceði türden deðil.");
			}

			if(!IsValidProductVehicle(trailerid, TruckerData[id][tProductID]))
			    return SendErrorMessage(playerid, "Bu trailer satýn almak istediðiniz kargo tipini desteklemiyor.");

			new capacity = strval(arg),
			    content = GetMaxCargoVehicle(trailerid);

			if(isnull(arg))
			{
			    SendUsageMessage(playerid, "/kargo satinal [miktar]");
			    switch(TruckerData[id][tProductID])
			    {
			        case TRUCKER_BRICKS: SendClientMessageEx(playerid, -1, "Maksimum alýnabilecek miktar: %i (Tuðla)", content/6);
					case TRUCKER_TRANSFORMS: SendClientMessageEx(playerid, -1, "Maksimum alýnabilecek miktar: %i (Transformatör)", content/6);
					case TRUCKER_WOODS: SendClientMessageEx(playerid, -1, "Maksimum alýnabilecek miktar: %i (Aðaç Kütükleri)", content/18);
					default: SendClientMessageEx(playerid, -1, "Maksimum alýnabilecek miktar: %i", content);
				}
			    return 1;
			}

			if(capacity < 1 || capacity > GetMaxCargoVehicle(trailerid))
			    return SendErrorMessage(playerid, "Bu trailerin alabileceði kargo miktarý aralýðý: 1 - %i.", GetMaxCargoVehicle(trailerid));

			if(TruckerData[id][tStorage] < capacity)
	        	return SendErrorMessage(playerid, "Satýn almak istediðin %i tane kargo stokta yok.", capacity);

			if(PlayerData[playerid][pMoney] < TruckerData[id][tPrice] * capacity)
		    	return SendErrorMessage(playerid, "Yeterli paran bulunmuyor. ($%s)", MoneyFormat(TruckerData[id][tPrice] * capacity));

			new amount,
				prodid = -1;

			for(new i; i != MAX_TRUCK_PRODUCT; i++)
			{
			    if(CarData[trailerid][carCargoAmount][i] == 0)
			        continue;

				amount += CarData[trailerid][carCargoAmount][i];
				prodid = i;
			}

            switch(TruckerData[id][tProductID])
			{
   				case TRUCKER_BRICKS, TRUCKER_TRANSFORMS:
   				{
   				    if(amount + capacity > content/6)
			    		return SendErrorMessage(playerid, "Bu trailera en fazla %i adet kargo alabilirsin.", capacity);
   				}
				case TRUCKER_WOODS:
				{
				    if(amount + capacity > content/18)
			    		return SendErrorMessage(playerid, "Bu trailera en fazla %i adet kargo alabilirsin.", capacity);
				}
			 	default:
				{
					if(amount + capacity > content)
			    		return SendErrorMessage(playerid, "Bu trailera en fazla %i adet kargo alabilirsin.", capacity);
				}
			}

			if(amount && prodid != TruckerData[id][tProductID])
			    return SendErrorMessage(playerid, "Trailer içinde \"%s\" tipinde kargo bulunuyor, sadece ayný tipten satýn alabilirsin.", TruckerData_product[prodid]);

			if(GetVehicleModel(vehicle) == 443 || GetVehicleModel(vehicle) == 578 || GetVehicleModel(vehicle) == 554 || GetVehicleModel(vehicle) == 530)
			{
				for(new i = 0; i != capacity; i++)
				{
			        switch(GetVehicleModel(vehicle))
			        {
						case 530:
						{
							CarData[vehicle][carCargoObj][amount] =
								CreateDynamicObject(2912, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);

							AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, forklift_attach[amount][0], forklift_attach[amount][1], forklift_attach[amount][2], 0.0, 0.0, 0.0);
						}
			            case 443:
						{
							CarData[vehicle][carCargoObj][amount] =
								CreateDynamicObject(3593, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);

							AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, paker_attach[amount][0], paker_attach[amount][1], paker_attach[amount][2], paker_attach[amount][3], 0.0, 0.0);
						}
						case 578:
						{
							switch(TruckerData[id][tProductID])
							{
								case TRUCKER_WOODS:
								{
									CarData[vehicle][carCargoObj][amount] = CreateDynamicObject(18609, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);
									AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, dft_attach[0], dft_attach[1], dft_attach[2], 0.0, 0.0, dft_attach[3]);
								}
								case TRUCKER_BRICKS:
								{
									CarData[vehicle][carCargoObj][amount] = CreateDynamicObject(18609, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);
									AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, dft_attach_brick[amount][0], dft_attach_brick[amount][1], dft_attach_brick[amount][2], 0.0, 0.0, 0.0);
								}
								case TRUCKER_TRANSFORMS:
								{
									CarData[vehicle][carCargoObj][amount] = CreateDynamicObject(3273, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);
									AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, dft_attach_brick[amount][0], dft_attach_brick[amount][1], dft_attach_brick[amount][2], 0.0, 0.0, 0.0);
								}
							}
						}	
						case 554:
						{
							CarData[vehicle][carCargoObj][amount] =
								CreateDynamicObject(1685, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);

							AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][amount], vehicle, yosemite_attach_brick[0], yosemite_attach_brick[1], yosemite_attach_brick[2], 0.0, 0.0, 0.0);
						}
					}
					amount++;
				}
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			GameTextForPlayer(playerid, sprintf("~r~-$%i", (TruckerData[id][tPrice] * capacity)), 1000, 1);
			CarData[trailerid][carCargoAmount][TruckerData[id][tProductID]] += capacity;
            GiveMoney(playerid, -(TruckerData[id][tPrice] * capacity));
			TruckerData[id][tStorage] -= capacity;
        	Industry_Update(id);
			return 1;
		}

        new id = -1;
		if((id = Industry_Nearest(playerid, 2.0)) == -1)
	    	return SendErrorMessage(playerid, "Yakýnýnda kargo satýn alabileceðin bir nokta yok.");

	    if(TruckerData[id][tLocked] == 1)
	        return SendErrorMessage(playerid, "Bu nokta kargo satýþýna kapalý.");

		if(!IsTakeProduct(TruckerData[id][tProductID]))
		    return SendErrorMessage(playerid, "Seçtiðin kargo taþýyabileceðin türden deðil.");

        if(!TruckerData[id][tStorage])
	        return SendErrorMessage(playerid, "Stokta ürün kalmamýþ.");

		if(PlayerData[playerid][pMoney] < TruckerData[id][tPrice])
	    	return SendErrorMessage(playerid, "Yeterli paran bulunmuyor. ($%s)", MoneyFormat(TruckerData[id][tPrice]));

		if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC) || PlayerData[playerid][pCargoID] != 0)
	    	return SendErrorMessage(playerid, "Kargo taþýyorsun.");

        cmd_liftup(playerid, "");
        SetPlayerAttachedObject(playerid, SLOT_MISC, 2912, 5, 0.102000, 0.306000, -0.228999, -1.100001, 14.499999, -1.300000, 1.000000, 1.000000, 1.000000);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

		GiveMoney(playerid, -TruckerData[id][tPrice]);
		PlayerData[playerid][pCargoID] = TruckerData[id][tProductID]+1;
		GameTextForPlayer(playerid, sprintf("~r~-$%i", TruckerData[id][tPrice]), 1000, 1);
		TruckerData[id][tStorage]--;
		Industry_Update(id);
	    return 1;
	}
	else if(!strcmp(parametrs, "fork", true))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicle = GetPlayerVehicleID(playerid);

			if(GetVehicleModel(vehicle) != 530)
				return SendErrorMessage(playerid, "Bu komutu sadece forkliftte kullanabilirsin.");

			if(GetClosestVehicle(playerid, 5.0) == -1) 
				return SendErrorMessage(playerid, "Yakýnýnda kargo alabileceðin bir araç yok.");

			new
				Float:x,
				Float:y,
				Float:z;

			GetVehicleBoot(GetClosestVehicle(playerid, 5.0), x, y, z);
			new	nearvehicle = GetClosestVehicle(playerid, 5.0);

			if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) 
				return SendErrorMessage(playerid, "Bu aracýn bagajýna yakýn deðilsin.");

			if(CarData[nearvehicle][carLocked])
				return SendErrorMessage(playerid, "Bu araç kilitli.");

			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(nearvehicle, engine, lights, alarm, doors, bonnet, boot, objective);

			if(!boot)
				return SendErrorMessage(playerid, "Bu aracýn bagajý kapalý.");

			new amount2, prodid2 = -1;
			for(new i; i != MAX_TRUCK_PRODUCT; i++)
			{
			    if(CarData[vehicle][carCargoAmount][i] == 0)
			        continue;

				amount2 += CarData[vehicle][carCargoAmount][i];
				prodid2 = i;
			}

			new amount, total, prodid = -1;
			for(new i; i != MAX_TRUCK_PRODUCT; i++)
			{
			    if(CarData[nearvehicle][carCargoAmount][i] == 0)
			        continue;

				amount += CarData[nearvehicle][carCargoAmount][i];
				prodid = i;
			}

			if(amount < 1)
				return SendErrorMessage(playerid, "Yakýnýndaki araçta hiç kargo kalmamýþ.");

			if(amount2 && prodid2 != prodid)
			    return SendErrorMessage(playerid, "Forkliftte \"%s\" tipinde kargo bulunuyor, sadece ayný tipten koyabilirsin.", TruckerData_product[prodid2]);

			if(!IsTakeProduct(prodid))
    			return SendErrorMessage(playerid, "Seçtiðin kargo taþýyabileceðin türden deðil.");

			amount = (amount > GetMaxCargoVehicle(vehicle)) ? GetMaxCargoVehicle(vehicle) : amount;

			for(new i = 0; i != amount; i++)
			{
				switch(GetVehicleModel(nearvehicle))
			 	{
			  		case 600, 543, 605, 422, 478, 554: DestroyDynamicObject(CarData[nearvehicle][carCargoObj][total]);
				}

		        switch(GetVehicleModel(vehicle))
		        {
					case 530:
					{
						CarData[vehicle][carCargoObj][total] =
							CreateDynamicObject(2912, 0.0, 0.0, 0.0, -100.0, 0.0, 0.0);

						AttachDynamicObjectToVehicle(CarData[vehicle][carCargoObj][total], vehicle, forklift_attach[total][0], forklift_attach[total][1], forklift_attach[total][2], 0.0, 0.0, 0.0);
					}
				}
				total++;
			}

			CarData[nearvehicle][carCargoAmount][prodid] -= amount;
			CarData[vehicle][carCargoAmount][prodid] += amount;
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			return 1;
		} 
		else SendErrorMessage(playerid, "Herhangi bir araç içinde deðilsin.");
		return 1;
	}
	else if(!strcmp(parametrs, "sat", true))
	{
	    if(IsPlayerInAnyVehicle(playerid))
		{
            new vehicle = GetPlayerVehicleID(playerid),
		   		trailerid = GetVehicleTrailer(vehicle);

			if(GetVehicleModel(vehicle) == 578 || GetVehicleModel(vehicle) == 443 || GetVehicleModel(vehicle) == 554 || GetVehicleModel(vehicle) == 499 || GetVehicleModel(vehicle) == 414 || GetVehicleModel(vehicle) == 456 || GetVehicleModel(vehicle) == 530)
				trailerid = vehicle;

	     	if(trailerid == 0)
		        return SendErrorMessage(playerid, "Bu komutu araç içinde trailerin varken kullanabilirsin.");

            if(!ValidTruckForPlayer(playerid, trailerid))
		    	return SendErrorMessage(playerid, "Bu traileri kullanmanýz için meslek rütbeniz yetersiz. (/meslek yardim)");

			if(CarData[trailerid][carLocked])
				return SendErrorMessage(playerid, "Bu trailer kilitli.");

            new capacity = strval(arg);

			if(isnull(arg))
			{
			    SendUsageMessage(playerid, "/kargo sat [miktar]");
			    return 1;
			}

			if(capacity < 1 || capacity > GetMaxCargoVehicle(trailerid))
			    return SendErrorMessage(playerid, "Miktar en az 1 en fazla %i olarak girilebilir.", GetMaxCargoVehicle(trailerid));

            new amount, prodid = -1;

			for(new i; i != MAX_TRUCK_PRODUCT; i++)
			{
			    if(CarData[trailerid][carCargoAmount][i] == 0) // || IsTakeProduct(i) 
			        continue;

				amount += CarData[trailerid][carCargoAmount][i];
				prodid = i;
				break;
			}

			if(amount < capacity)
			    return SendErrorMessage(playerid, "Trailerda belirttiðin kadar kargo yok.");

            new id = -1;

			if((id = Industry_Nearest(playerid, 15.0)) != -1)
			{
                if(TruckerData[id][tLocked] == 1)
	        		return SendErrorMessage(playerid, "Bu nokta kargo alýmýna kapalý.");

		        if(TruckerData[id][tStorage] + amount > TruckerData[id][tStorageSize])
			        return SendErrorMessage(playerid, "Stok dolu gözüküyor.");

          		if(TruckerData[id][tProductID] != prodid)
			        return SendErrorMessage(playerid, "Satmak istediðin kargo tipini bu nokta almýyor.");

				if(GetVehicleModel(vehicle) == 443 || GetVehicleModel(vehicle) == 578 || GetVehicleModel(vehicle) == 554 || GetVehicleModel(vehicle) == 530)
				{
					for(new i = 0; i != capacity; i++)
					{
				        DestroyDynamicObject(CarData[vehicle][carCargoObj][amount-1]);
				        amount--;
					}
				}

				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
             	CarData[vehicle][carCargoAmount][prodid] -= capacity;
                GiveMoney(playerid, TruckerData[id][tPrice] * capacity);

				GameTextForPlayer(playerid, sprintf("~w~+$%i", TruckerData[id][tPrice] * capacity), 1000, 1);

				TruckerData[id][tStorage] += capacity;
				Industry_Update(id);
				return 1;
			}
			else if((id = GetNearBizOutside(playerid, 15.0)) != -1)
			{
			    if(capacity > BusinessData[id][BusinessWantedProduct])
			        return SendErrorMessage(playerid, "Bu iþyeri %i adet kargo satýn almak istiyor.", BusinessData[id][BusinessWantedProduct]);

			    if(BusinessData[id][BusinessProduct] > 400)
			    	return SendErrorMessage(playerid, "Bu iþyerinin kargo kapasitesi dolmuþ.");

                if(!BusinessData[id][BusinessProductPrice])
				    return SendErrorMessage(playerid, "Bu iþyeri kargo satýn almýyor.");

                if(biz_prod_types[BusinessData[id][BusinessType]] != prodid)
			        return SendErrorMessage(playerid, "Satmak istediðin kargo tipini bu iþyeri almýyor.");

			    if(GetVehicleModel(vehicle) == 443 || GetVehicleModel(vehicle) == 578 || GetVehicleModel(vehicle) == 554)
				{
					for(new i = 0; i != capacity; i++)
					{
				        DestroyDynamicObject(CarData[vehicle][carCargoObj][amount-1]);
				        amount--;
					}
				}

				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
             	CarData[trailerid][carCargoAmount][prodid] -= capacity;
                BusinessData[id][BusinessProduct] += (BusinessData[id][BusinessType] * capacity);
               	BusinessData[id][BusinessCashbox] -= (BusinessData[id][BusinessProductPrice] * capacity);
                GiveMoney(playerid, BusinessData[id][BusinessProductPrice] * capacity);
				GameTextForPlayer(playerid, sprintf("~w~+$%i", (BusinessData[id][BusinessProductPrice] * capacity)), 1000, 1);
				if(BusinessData[id][BusinessProduct] >= 400) BusinessData[id][BusinessProductPrice] = 0;
				Business_Save(id);
				return 1;
			}
			else SendErrorMessage(playerid, "Yakýnýnda kargo satabileceðin bir nokta yok.");
			return 1;
		}

		if(!PlayerData[playerid][pCargoID])
  			return SendErrorMessage(playerid, "Kargo taþýmýyorsun.");

        new id;
		if((id = Industry_Nearest(playerid, 2.0)) != -1)
		{
            if(TruckerData[id][tLocked] == 1)
        		return SendErrorMessage(playerid, "Bu nokta kargo alýmýna kapalý.");

	        if(TruckerData[id][tStorage] + 1 > TruckerData[id][tStorageSize])
		        return SendErrorMessage(playerid, "Stok dolu gözüküyor.");

	        if(TruckerData[id][tProductID] != PlayerData[playerid][pCargoID]-1)
		        return SendErrorMessage(playerid, "Satmak istediðin kargo tipini bu nokta almýyor.");

            cmd_putdown(playerid, "");
	        if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC))
	        	RemovePlayerAttachedObject(playerid, SLOT_MISC);
	        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

			GiveMoney(playerid, TruckerData[id][tPrice]);
			PlayerData[playerid][pCargoID] = 0;

			GameTextForPlayer(playerid, sprintf("~w~+$%i", TruckerData[id][tPrice]), 1000, 1);

			TruckerData[id][tStorage]++;
			Industry_Update(id);
        }
        else if((id = GetNearBizOutside(playerid)) != -1)
		{
		    if(BusinessData[id][BusinessProduct] > 400)
		    	return SendErrorMessage(playerid, "Bu iþyerinin kargo kapasitesi dolmuþ.");

            if(!BusinessData[id][BusinessProductPrice])
				return SendErrorMessage(playerid, "Bu iþyeri kargo satýn almýyor.");

            if(biz_prod_types[BusinessData[id][BusinessType]] != PlayerData[playerid][pCargoID]-1)
				return SendErrorMessage(playerid, "Satmak istediðin kargo tipini bu iþyeri almýyor.");

    	    cmd_putdown(playerid, "");
            if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC)) RemovePlayerAttachedObject(playerid, SLOT_MISC);
	        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

            PlayerData[playerid][pCargoID] = 0;
            BusinessData[id][BusinessProduct] += BusinessData[id][BusinessType];
           	BusinessData[id][BusinessCashbox] -= BusinessData[id][BusinessProductPrice];
            GiveMoney(playerid, BusinessData[id][BusinessProductPrice]);
			if(BusinessData[id][BusinessProduct] >= 400) BusinessData[id][BusinessProductPrice] = 0;
			Business_Save(id);
			return 1;
		}
		else SendErrorMessage(playerid, "Yakýnýnda kargo satabileceðin bir nokta yok.");
	}
	return 1;
}

Dialog:CARGO_LIST(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return 1;

	if(IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Araç içinde kargo alamazsýn.");

  	new vehicle = GetPVarInt(playerid, "cargo_veh_id");
	if(!vehicle || GetNearestVehicle(playerid) == INVALID_VEHICLE_ID) 
		return SendErrorMessage(playerid, "Yakýnýnda kargo alabileceðin bir araç yok.");

	if(CarData[vehicle][carLocked])
		return SendErrorMessage(playerid, "Bu araç kilitli.");

	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);

	if(!boot)
		return SendErrorMessage(playerid, "Bu aracýn bagajý kapalý.");

	listitem = PlayerData[playerid][pCargoListed][listitem];

	if(CarData[vehicle][carCargoAmount][listitem] == 0)
	    return SendErrorMessage(playerid, "Seçtiðin kargo araçta yok. (baþkasý almýþ olabilir)");

    if(!IsTakeProduct(listitem))
    	return SendErrorMessage(playerid, "Seçtiðin kargo taþýyabileceðin türden deðil.");

    if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC) || PlayerData[playerid][pCargoID] != 0)
	   	return SendErrorMessage(playerid, "Kargo taþýyorsun.");

	cmd_liftup(playerid, "");
 	SetPlayerAttachedObject(playerid, SLOT_MISC, 2912, 5, 0.102000, 0.306000, -0.228999, -1.100001, 14.499999, -1.300000, 1.000000, 1.000000, 1.000000);
  	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

	PlayerData[playerid][pCargoID] = listitem+1;
	CarData[vehicle][carCargoAmount][listitem]--;

	new amount;
	for(new i; i != MAX_TRUCK_PRODUCT; i++)
		amount += CarData[vehicle][carCargoAmount][i];

    switch(GetVehicleModel(vehicle))
 	{
  		case 600, 543, 605, 422, 478, 554, 530: DestroyDynamicObject(CarData[vehicle][carCargoObj][amount]);
	}

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return 1;
}

Industry_Nearest(playerid, Float: radius = 10.0)
{
	foreach(new i : Trucker)
	{
        if(IsPlayerInRangeOfPoint(playerid, radius, TruckerData[i][tPosX], TruckerData[i][tPosY], TruckerData[i][tPosZ]) && 0 == GetPlayerInterior(playerid) && 0 == GetPlayerVirtualWorld(playerid))
            return i;
	}
	return -1;
}

GetNearBootVehicle(playerid)
{
	for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
	{
	    if(0 != IsVehicleStreamedIn(i, playerid) && 0 != IsOnBootVehicle(playerid, i))
	        return i;
	}
	return 0;
}

IsOnBootVehicle(playerid, vehicleid)
{
    new Float:angle,
		Float:distance,
		Float: x,
		Float: y,
		Float: z,
		model = GetVehicleModel(vehicleid);

	GetVehicleModelInfo(model, 1, x, distance, z);
    distance = distance/2 + 0.1;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    x += (distance * floatsin(-angle+180, degrees));
    y += (distance * floatcos(-angle+180, degrees));

    if(model == 435 || model == 450 || model == 584 || model == 591)
        return IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z);

    return IsPlayerInRangeOfPoint(playerid, 2.0, x, y, z);
}

stock GetMaxCargoVehicle(vehicle)
{
	switch(GetVehicleModel(vehicle))
	{
	    case 600, 543, 605, 443: return 2;
	    case 422, 530: return 3;
	    case 478: return 4;
		case 554: return 6;
		case 413, 459, 482: return 10;
	    case 440, 498: return 12;
	    case 499: return 14;
	    case 414, 455, 428: return 16;
	    case 578: return 18;
		case 456: return 24;
		case 450: return 30;
		case 435, 591: return 36;
		case 584: return 40;
	}
	return 0;
}

stock IsValidProductVehicle(vehicle, prod)
{
	switch(GetVehicleModel(vehicle))
	{
	    case 600, 543, 605, 422, 478, 413, 459, 482, 440, 498, 530:
		{
			switch(prod)
			{
			    case 1, 2, 3, 5, 6, 7, 12, 15, 18, 19, 20, 23, 24: return 1;
			}
		}

		case 554, 499, 414, 456, 435, 591:
		{
			switch(prod)
			{
			    case 1, 2, 3, 5, 6, 7, 12, 15, 18, 19, 20, 23, 24, TRUCKER_BRICKS: return 1;
			}
		}

        case 584:
		{
			switch(prod)
			{
			    case 0, 8, 11, 19: return 1;
			}
		}

		case 450, 455:
        {
			switch(prod)
			{
			    case 9, 10, 13, 16, TRUCKER_SCRAP: return 1;
			}
		}

		case 578:
		{
			switch(prod)
			{
			    case TRUCKER_WOODS, TRUCKER_BRICKS, TRUCKER_TRANSFORMS: return 1;
			}
		}
		case 443:
		{
			switch(prod)
			{
			    case 4: return 1;
			}
		}
		case 428:
		{
			switch(prod)
			{
			    case 14, 21: return 1;
			}
		}
	}
	return 0;
}

stock IsTruckCar(vehicle)
{
	switch(GetVehicleModel(vehicle))
	{
	    case 403, 514, 515: return 1;
	}
	return 0;
}

stock TruckRank1(mv)
{
	return (mv == 600 || mv == 605 || mv == 543 || mv == 422 || mv == 478 || mv == 554 || mv == 530) ? 1 : 0;
}

stock TruckRank2(mv)
{
	return (TruckRank1(mv) == 1 || mv == 413 || mv == 459 || mv == 482) ? 1 : 0;
}

stock TruckRank3(mv)
{
	return (TruckRank1(mv) == 1 || TruckRank2(mv) == 1 || mv == 440 || mv == 498) ? 1 : 0;
}

stock TruckRank4(mv)
{
	return (TruckRank1(mv) == 1 || TruckRank2(mv) == 1 || TruckRank3(mv) == 1 || mv == 499 || mv == 414 || mv == 578 || mv == 443 || mv == 428) ? 1 : 0;
}

stock TruckRank5(mv)
{
	return (TruckRank1(mv) == 1 || TruckRank2(mv) == 1 || TruckRank3(mv) == 1 || TruckRank4(mv) == 1 || mv == 456 || mv == 455) ? 1 : 0;
}

stock TruckRank6(mv)
{
	return (TruckRank1(mv) == 1 || TruckRank2(mv) == 1 || TruckRank3(mv) == 1 || TruckRank4(mv) == 1 || TruckRank5(mv) == 1 || mv == 584 || mv == 591 || mv == 435 || mv == 450) ? 1 : 0;
}

stock IsTruckerJob(vehicle)
{
    new mv = GetVehicleModel(vehicle);
	return TruckRank6(mv) == 0 ? 0 : 1;
}

stock ValidTruckForPlayer(playerid, vehicle)
{
	new mv = GetVehicleModel(vehicle);
	switch(PlayerData[playerid][pJobLevel])
	{
	    case 0: if(TruckRank1(mv) == 0) return 0;
		case 1: if(TruckRank2(mv) == 0) return 0;
	    case 2: if(TruckRank3(mv) == 0) return 0;
	    case 3: if(TruckRank4(mv) == 0) return 0;
	    case 4: if(TruckRank5(mv) == 0) return 0;
	    default: if(TruckRank6(mv) == 0) return 0;
	}
	return 1;
}

stock GetClosestVehicle(playerid, Float: range)
{
    new Float: PosX, Float: PosY, Float: PosZ, Float: CloseDist = range, FetchVeh = -1, PlayerVeh;
    new Float: Dist;

    PlayerVeh = GetPlayerVehicleID(playerid);

    for(new i = GetVehiclePoolSize(); i != 0; i--)
    {
        if(!IsValidVehicle(i)) continue;
        if(i == PlayerVeh) continue;

        GetVehiclePos(i, PosX, PosY, PosZ);
        Dist = GetPlayerDistanceFromPoint(playerid, PosX, PosY, PosZ);
        
        if(Dist <= CloseDist)
        {
            FetchVeh = i; 
            CloseDist = Dist;
        }
    }
    return FetchVeh;
} 

GetNearBizOutside(playerid, Float: radius = 3.0)
{
   	foreach(new i : Businesses)
   	{
	    if(GetPlayerVirtualWorld(playerid) != BusinessData[i][EnterWorld]) continue;
		if(GetPlayerInterior(playerid) != BusinessData[i][EnterInterior]) continue;
	    if(!IsPlayerInRangeOfPoint(playerid, radius, BusinessData[i][EnterPos][0], BusinessData[i][EnterPos][1], BusinessData[i][EnterPos][2])) continue;

	    return i;
	}
	return -1;
}
