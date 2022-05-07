new FurnitureHolder[MAX_PLAYERS][MAX_CLOTHING_SHOW][3];

CMD:mobilyaizin(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
	if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/mobilyaizin [oyuncu ID/isim]");
	if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi üzerinde kullanamazsýn.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz oyuncu oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz oyuncu henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðin oyuncuya yakýn deðilsin.");
	if(IsPlayerInProperty(id) != h) return SendErrorMessage(playerid, "Belirttiðin oyuncuya seninle ayný evde deðil.");
	if(PlayerData[id][pGrantBuild] != -1) return SendErrorMessage(playerid, "Belirttiðin oyuncunun mobilya izni bulunuyor.");

	InfoTD_MSG(id, 1, 5000, "~w~MOBILYA DUZENLEME ICIN DAVET.~n~~y~Y ~p~TUSUYLA KABUL EDEBILIR ~r~N ~p~TUSUYLA REDDEDEBILIRSIN.");
	InfoTD_MSG(playerid, 1, 5000, "~w~MOBILYA DUZENLEME ICIN DAVET GONDERDIN.~n~~y~LUTFEN CEVAPLANMASINI BEKLE.");
	SetPVarInt(id, "Grantbuild_PropertyID", h);
	SetPVarInt(id, "Grantbuild_ID", playerid);
	return 1;
}

CMD:mobilyalarikaldir(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
	if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");
	if(PropertyData[h][PropertySwitchID] == -1) return SendServerMessage(playerid, "Bu komutu kullanabilmek için evinin ayarýnýn yapýlmasý gerekiyor.");
	
	new confirm[5];
	if(sscanf(params, "s[5]", confirm)) 
	{
		SendUsageMessage(playerid, "/mobilyalarikaldir {FFFF00}onay");
		return 1;
	}

	if(!isnull(confirm) && !strcmp(confirm, "onay", true))
	{
		new data[e_furniture], query[64], sellprice;
		for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i ++)
		{
		    if(!IsValidDynamicObject(i)) continue;
		    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

			Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
			if(data[SQLID] > 0 && data[PropertyID] == h)
			{
				sellprice += (data[furniturePrice] - (data[furniturePrice] & 2)) / 2;

				DestroyDynamicObject(i);
				mysql_format(m_Handle, query, sizeof(query), "DELETE FROM furnitures WHERE id = %i", data[SQLID]);
				mysql_tquery(m_Handle, query);
				
				//Streamer_RemoveArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data[PropertyID]);
			}
	    }

		GameTextForPlayer(playerid, sprintf("~w~+$%i", sellprice), 2000, 1);
		GiveMoney(playerid, sellprice);

		if(!PropertyData[h][PropertySwitch])
		{	
			new p = PropertyData[h][PropertySwitchID];
			PropertyData[h][PropertyExit][0] = g_PropertyInteriorsWOF[p][InteriorX];
			PropertyData[h][PropertyExit][1] = g_PropertyInteriorsWOF[p][InteriorY];
			PropertyData[h][PropertyExit][2] = g_PropertyInteriorsWOF[p][InteriorZ];
			PropertyData[h][PropertyExit][3] = g_PropertyInteriorsWOF[p][InteriorA];
			PropertyData[h][PropertyExitInterior] = g_PropertyInteriorsWOF[p][InteriorID];
			PropertyData[h][PropertySwitch] = true;
		}
		else 
		{
			new p = PropertyData[h][PropertySwitchID];
			PropertyData[h][PropertyExit][0] = g_PropertyInteriors[p][InteriorX];
			PropertyData[h][PropertyExit][1] = g_PropertyInteriors[p][InteriorY];
			PropertyData[h][PropertyExit][2] = g_PropertyInteriors[p][InteriorZ];
			PropertyData[h][PropertyExit][3] = g_PropertyInteriors[p][InteriorA];
			PropertyData[h][PropertyExitInterior] = g_PropertyInteriors[p][InteriorID];
			PropertyData[h][PropertySwitch] = false;
		}

		foreach(new i : Player) if(PlayerData[i][pInsideHouse] == h)
		{
			SendPlayer(i, PropertyData[h][PropertyExit][0], PropertyData[h][PropertyExit][1], PropertyData[h][PropertyExit][2], PropertyData[h][PropertyExit][3], PropertyData[h][PropertyExitInterior], PropertyData[h][PropertyExitWorld]);
			SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu evin iç kýsmý güncellendi.");
			SetCameraBehindPlayer(i);
		}

		Property_Refresh(h);
		Property_Save(h);
		return 1;
	}
	else SendUsageMessage(playerid, "/mobilyalarikaldir {FFFF00}onay");
	return 1;
}

CMD:tummobilyalarisat(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
	//if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID] && PlayerData[playerid][pGrantBuild] != PropertyData[h][PropertyID])
	//    return SendErrorMessage(playerid, "Sahip olmadýðýn evin mobilyasýný satamazsýn.");
	if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");
	if(!Furniture_GetCount(h)) return SendErrorMessage(playerid, "Hiç mobilyan yok.");

	new property_address[64], property_entered[64];
	switch(PropertyData[h][PropertyType])
	{
	    case 1,3: format(property_entered, sizeof(property_entered), "%s %i %s Mobilya", GetStreet(PropertyData[h][PropertyEnter][0], PropertyData[h][PropertyEnter][1], PropertyData[h][PropertyEnter][2]), h, GetCityName(PropertyData[h][PropertyEnter][0], PropertyData[h][PropertyEnter][1], PropertyData[h][PropertyEnter][2]));
	    case 2: 
	    {
		    new link = PropertyData[h][PropertyComplexLink]; 
		  	format(property_entered, sizeof(property_entered), "%s %i %s Mobilya", GetStreet(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2]), h, GetCityName(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2]));
	    }
	}

	if(sscanf(params, "s[64]", property_address)) 
	{
		new data[e_furniture], sellprice, count;
		for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i ++)
		{
		    if(!IsValidDynamicObject(i)) continue;
		    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

			Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
			if(data[SQLID] > 0 && data[PropertyID] == h)
			{
			    sellprice += (data[furniturePrice] - (data[furniturePrice] & 2)) / 2;
		 		count++;
			}
	    }

		SendClientMessage(playerid, COLOR_DARKRED, "Uyarý: Bu iþlem geri alýnamaz. Yaptýðýn iþlemden emin ol.");
		SendClientMessage(playerid, COLOR_WHITE, " ");
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "Bu ev $%s deðerinde %i adet mobilyaya sahip.", MoneyFormat(sellprice), count);
		SendClientMessage(playerid, COLOR_DARKGREEN, "Ýþlemi onaylamak için, aþaðýda yazýlaný giriniz.");
		SendClientMessageEx(playerid, COLOR_WHITE, "/tummobilyalarisat %s", property_entered);
		SendClientMessage(playerid, COLOR_WHITE, " ");
		SendClientMessage(playerid, COLOR_DARKRED, "Uyarý: Bu iþlem geri alýnamaz. Yaptýðýn iþlemden emin ol.");
		return 1;
	}	

	if(!isnull(property_address) && !strcmp(property_entered, property_address, true))
	{
		new data[e_furniture], query[64], sellprice;
		for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i ++)
		{
		    if(!IsValidDynamicObject(i)) continue;
		    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

			Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
			if(data[SQLID] > 0 && data[PropertyID] == h)
			{
				sellprice += (data[furniturePrice] - (data[furniturePrice] & 2)) / 2;

				DestroyDynamicObject(i);
				mysql_format(m_Handle, query, sizeof(query), "DELETE FROM furnitures WHERE id = %i", data[SQLID]);
				mysql_tquery(m_Handle, query);
				
				//Streamer_RemoveArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data[PropertyID]);
			}
	    }

		GameTextForPlayer(playerid, sprintf("~w~+$%i", sellprice), 2000, 1);
		GiveMoney(playerid, sellprice);
	}
	return 1;
}

CMD:mobilya(playerid, params[])
{
	if(EditingObject[playerid]) return SendErrorMessage(playerid, "Þu anda baþka bir obje düzenliyorsun.");

	// iþyeri içinde gelecek aynýsý
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) != -1) 
	{
		//if(!Property_Count(playerid)) return SendErrorMessage(playerid, "Hiç evin yok.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID] && PropertyData[h][PropertyID] != PlayerData[playerid][pGrantBuild]) 
		{
    		SendErrorMessage(playerid, "Bu eve sahip deðilsin veya mobilya iznin bulunmuyor.");
    		return 1;
    	}

    	Furniture_Panel(playerid, h);
    	return 1;
	}

	SendErrorMessage(playerid, "Burada dekorasyon yapamazsýn.");
	return 1;
}	

Furniture_Panel(playerid, id)
{
	if(PlayerData[playerid][p3DMenu] != -1)
	{
	   	Destroy3DMenu(PlayerData[playerid][p3DMenu]);
		PlayerData[playerid][p3DMenu] = -1;
	}

	PlayerData[playerid][pHouseFurniture] = id;
	Dialog_Show(playerid, FURNITURE_MAIN, DIALOG_STYLE_LIST, "Mobilya Ana Menü:", "Mobilya Satýnal\nMevcut Mobilyalar\nMobilya Bilgileri", "Seç", "<<<");
	return 1;
}

Dialog:FURNITURE_MAIN(playerid, response, listitem, inputtext[])
{
	if(!response) {
		PlayerData[playerid][pHouseFurniture] = -1;
		return 1;
	}

	switch(listitem)
	{
	    case 0: Furniture_Category(playerid);
	    case 1: Furniture_List(playerid);		
		case 2:
		{
			new
				sub_str[105], primary_str[315];

			format(sub_str, sizeof(sub_str), "{FFFFFF}- Bu ev þuan da {33AA33}%i{FFFFFF} adet mobilyaya sahip.\n", Furniture_GetCount(PlayerData[playerid][pHouseFurniture]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "- Bu eve ekleyebileceðin mobilya sayýsý {33AA33}%i{FFFFFF} adettir.\n", Furniture_GetLimit(playerid));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "- {33AA33}%i{FFFFFF} adet mobilya daha ekleyebilirsin.\n", Furniture_GetLimit(playerid) - Furniture_GetCount(PlayerData[playerid][pHouseFurniture]));
			strcat(primary_str, sub_str);

			Dialog_Show(playerid, FURNITURE_MAIN_INFO, DIALOG_STYLE_MSGBOX, "Mobilya Bilgileri", primary_str, "Tamam", "<<<");
		}
	}
	return 1;
}

Dialog:FURNITURE_MAIN_INFO(playerid, response, listitem, inputtext[])
{
	cmd_mobilya(playerid, "");
	return 1;
}


Dialog:FURNITURE_CATEGORIES(playerid, response, listitem, inputtext[])
{
	if(!response) {
		cmd_mobilya(playerid, "");
		return 1;
	}

	SetPVarInt(playerid, "furniture_category", listitem+1);
	Furniture_SubCategory(playerid, listitem+1);
	return 1;
}

Dialog:FURNITURE_SUBCATEGORY(playerid, response, listitem, inputtext[])
{
	if(!response) {
		Furniture_Category(playerid);
		return 1;
	}

	new id = Furniture_GetSubAltID(inputtext);
	SetPVarInt(playerid, "furniture_subcategory", id);
	Furniture_SubCategoryAlt(playerid, id);
	return 1;
}

Dialog:FURNITURE_SUBALTCATEGORY(playerid, response, listitem, inputtext[])
{
	if(!response) {
		Furniture_SubCategory(playerid, GetPVarInt(playerid, "furniture_category"));
		return 1;
	}

	new obj_name[64];
	sscanf(inputtext, "s[64]", obj_name);
	SetPVarString(playerid, "furniture_name", obj_name);
	SetPVarInt(playerid, "furniture_price", Furniture_GetPrice(GetPVarInt(playerid, "furniture_subcategory"), obj_name));
	SetPVarInt(playerid, "furniture_objid", Furniture_GetObjID(GetPVarInt(playerid, "furniture_subcategory"), obj_name));

	new sub_str[75], primary_str[325];
	format(sub_str, sizeof(sub_str), "{FFFFFF}Ana Kategori: {FFFF00}%s\n", Furniture_GetCategory(GetPVarInt(playerid, "furniture_category")));
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "{FFFFFF}Alt Kategori: {FFFF00}%s\n", Furniture_GetSubCategory(GetPVarInt(playerid, "furniture_subcategory")));
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "{FFFFFF}Mobilya Adý: {FFFF00}%s\n", obj_name);
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "{FFFFFF}Fiyat: {33AA33}${FFFF00}%s\n", MoneyFormat(GetPVarInt(playerid, "furniture_price")));
	strcat(primary_str, sub_str);

	Dialog_Show(playerid, FURNITURE_CATEGORYBUY, DIALOG_STYLE_MSGBOX, "Mobilya Bilgisi", primary_str, "Satýnal", "<<<");
	return 1;
}

Dialog:FURNITURE_CATEGORYBUY(playerid, response, listitem, inputtext[])
{
	if(!response) {
        Furniture_SubCategoryAlt(playerid, GetPVarInt(playerid, "furniture_subcategory"));
	    return 1;
	}

	new p = PlayerData[playerid][pHouseFurniture];

	if(p != IsPlayerInProperty(playerid)) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	if(Furniture_GetCount(p) >= Furniture_GetLimit(playerid)) 
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Maksimum satýn alabileceðin mobilya sýnýrýna ulaþmýþsýn. (%i adet)", Furniture_GetLimit(playerid));
		return 1;
	}

    if(GetPVarInt(playerid, "furniture_price") > PlayerData[playerid][pMoney]) 
    {
    	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yeterli paran yok. Toplam: $%s", MoneyFormat(GetPVarInt(playerid, "furniture_price")));
    	return 1;
    }

    new furn_name[64];
    GetPVarString(playerid, "furniture_name", furn_name, sizeof(furn_name));
	new query[512], Float: x, Float: y, Float: z; GetPlayerPos(playerid, x, y, z); GetXYInFrontOfPlayer(playerid, x, y, 3.0);
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO furnitures (PropertyID, CategoryID, SubCategoryID, FurnitureID, FurniturePrice, FurnitureName, FurnitureX, FurnitureY, FurnitureZ, FurnitureVW, FurnitureInt) VALUES (%i, %i, %i, %i, %i, '%e', %f, %f, %f, %i, %i)", p, GetPVarInt(playerid, "furniture_category"), GetPVarInt(playerid, "furniture_subcategory"), GetPVarInt(playerid, "furniture_objid"), GetPVarInt(playerid, "furniture_price"), furn_name, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    new Cache: add = mysql_query(m_Handle, query), data[e_furniture];
    data[SQLID] = cache_insert_id();
 	data[PropertyID] = p, data[BusinessID] = -1;
    data[ObjectID] = GetPVarInt(playerid, "furniture_objid");
    data[ArrayID] = GetPVarInt(playerid, "furniture_category");
	data[SubArrayID] = GetPVarInt(playerid, "furniture_subcategory");
   	data[TempObjectID] = CreateDynamicObject(GetPVarInt(playerid, "furniture_objid"), x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	format(data[furnitureName], 64, furn_name); data[furniturePrice] = GetPVarInt(playerid, "furniture_price");
	data[furnitureX] = x, data[furnitureY] = y, data[furnitureZ] = z;
	data[furnitureRX] = data[furnitureRY] = data[furnitureRZ] = 0.0;
	for(new i; i < 5; i++) data[furnitureTexture][i] = -1;
	cache_delete(add);

	if(IsHouseDoor(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn kapýyý {AFAFAF}/kapi ve /kilit {FFFFFF}komutlarýyla kontol edebilirsin.");
		data[furnitureLocked] = true, data[furnitureOpened] = false;
	} 
	else if(IsHouseRefrigerator(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn buzdolabýnýn önünde {AFAFAF}/candoldur {FFFFFF}yazarak canýný fulleyebilirsin.");
	}
	else if(IsHouseSafe(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn kasayla {AFAFAF}/ev paracek/parayatir {FFFFFF}komutlarýný kullanabileceksin.");
	}

	EditingID[playerid] = p; EditingObject[playerid] = 21;
	Streamer_SetArrayData(STREAMER_TYPE_OBJECT, data[TempObjectID], E_STREAMER_EXTRA_ID, data);
	EditDynamicObject(playerid, data[TempObjectID]); SetPVarInt(playerid, "chose_slot", data[TempObjectID]);
	GiveMoney(playerid, -data[furniturePrice]);

    InfoTD_MSG(playerid, 1, 5000, "\
		\" ~y~SPACE ~w~\" ve \" ~y~MMB ~w~\" TUSLARINA BASARAK MOBILYAYI ONUNE DOGRU GETIREBILIRSIN.~n~\
		EGER MOBILYAYI BEGENMEDIYSEN \" ~r~ESC ~w~\" TUSUNA BASARAK IADE EDEBILIRSIN.");
	return 1;
}

Dialog:FURNITURE_EDIT(playerid, response, listitem, inputtext[])
{
	if(!response) return cmd_mobilya(playerid, "");

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Seçtiðiniz mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	switch(listitem)
	{
	    case 0:
	    {
	    	new 
	    		sub_str[75], primary_str[325];

	        format(sub_str, sizeof(sub_str), "{FFFFFF}Ana Kategori: {FFFF00}%s\n", 	Furniture_GetCategory(data[ArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Alt Kategori: {FFFF00}%s\n", Furniture_GetSubCategory(data[SubArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Mobilya Adý: {FFFF00}%s\n", data[furnitureName]);
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Fiyat: {33AA33}${FFFF00}%s\n", MoneyFormat(data[furniturePrice]));
			strcat(primary_str, sub_str);

			Dialog_Show(playerid, FURNITURE_INFO, DIALOG_STYLE_MSGBOX, "Mobilya Bilgisi", primary_str, "Tamam", "<<<");
	        return 1;
	    }
	    case 1:
	    {
	    	Furniture_Details(playerid);
	        return 1;
	    }
	    case 2:
	    {
	    	if(!PlayerData[playerid][pDonator]) 
	    	{
	    		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu seçeneði kullanabilmek için baðýþçý paketlerinden birini almýþ olmalýsýn.");
	    		return 1;
	    	}

            InfoTD_MSG(playerid, 1, 5000, "\
	 			HER MOBILYA YAKLASIK 5 DEKORASYON SLOTUNA SAHIPTIR.~n~\
            	HER SLOT MOBILYANIN BIR KISMINI ETKILER.");

	    	new 
	    		sub_str[50], primary_str[250];

			for(new i; i < 5; i++)
			{
				if(data[furnitureTexture][i] != -1) format(sub_str, sizeof(sub_str), "Dekorasyon %i: %s\n", i+1, GetTextureName(data[furnitureTexture][i]));
				else format(sub_str, sizeof(sub_str), "Slot %i: {FFFF00}Yok\n", i+1);
				strcat(primary_str, sub_str);
			}

			strcat(primary_str, "{FFFF00}Dekorasyonlarý Kaldýr");
	        Dialog_Show(playerid, FURNITURE_TEXTURE, DIALOG_STYLE_LIST, "Mobilya Dekorasyon", primary_str, "Seç", "<<<");
			return 1;
	    }
	    case 3:
	    {
	    	new 
	    		sub_str[75], primary_str[325];

	        format(sub_str, sizeof(sub_str), "{FFFFFF}Ana Kategori: {FFFF00}%s\n", 	Furniture_GetCategory(data[ArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Alt Kategori: {FFFF00}%s\n", Furniture_GetSubCategory(data[SubArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Mobilya Adý: {FFFF00}%s\n", data[furnitureName]);
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Fiyat: {33AA33}${FFFF00}%s\n", MoneyFormat(data[furniturePrice]));
			strcat(primary_str, sub_str);

		    format(sub_str, sizeof(sub_str), "{FFFFFF}Mobilyayý sattýðýnýzda {FFFF00}$%s {FFFFFF}alacaksýnýz.", MoneyFormat((data[furniturePrice] - (data[furniturePrice] & 2)) / 2));
	    	strcat(primary_str, sub_str);

			Dialog_Show(playerid, FURNITURE_SELL, DIALOG_STYLE_MSGBOX, "Mobilya Sat", primary_str, "Sat", "<<<");
	        return 1;
	    }
		case 4:
		{
			new 
				primary_str[500];

			strcat(primary_str, "{FFFF00}Mobilyanýza özel bir ad ekleme olanaðýnýz bulunuyor.\n");
			strcat(primary_str, "Bu özellik, sahip olabileceðiniz bir çok mobilyayý kolayca bulmanýzý saðlamak içindir.\n\n");

			strcat(primary_str, "Mobilyanýzýn görünmesini istediðiniz yeni adýný girin. Maksimum sýnýr 32 karakterdir.\n\n");

			strcat(primary_str, "{FF6347}[ ! ] UYARI: Bu özelliðin kötüye kullanýlmasý cezalandýrýlabilir. Kötüye kullanma.\n");
			strcat(primary_str, "[ ! ] NOT: Bu mobilya adý sadece sizin izin verdikleriniz tarafýndan görülebilir.");

			Dialog_Show(playerid, FURNITURE_RENAME, DIALOG_STYLE_INPUT, data[furnitureName], primary_str, "Deðiþtir", "<<<");
			return 1;
		}
		case 5:
		{
	    	new 
	    		sub_str[75], primary_str[325];

	        format(sub_str, sizeof(sub_str), "{FFFFFF}Ana Kategori: {FFFF00}%s\n", 	Furniture_GetCategory(data[ArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Alt Kategori: {FFFF00}%s\n", Furniture_GetSubCategory(data[SubArrayID]));
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Mobilya Adý: {FFFF00}%s\n", data[furnitureName]);
			strcat(primary_str, sub_str);

			format(sub_str, sizeof(sub_str), "{FFFFFF}Fiyat: {33AA33}${FFFF00}%s\n", MoneyFormat(data[furniturePrice]));
			strcat(primary_str, sub_str);

	    	strcat(primary_str, "{FFFFFF}Bu mobilyayý kopyalamak istiyor musunuz?");
			Dialog_Show(playerid, FURNITURE_COPY, DIALOG_STYLE_MSGBOX, "Mobilya Kopyala", primary_str, "Kopyala", "<<<");
	        return 1;
		}
	}
	return 1;
}

Dialog:FURNITURE_INFO(playerid, response, listitem, inputtext[]) return Furniture_Edit(playerid);
Dialog:FURNITURE_EDIT_DETAILS(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		return Furniture_Edit(playerid);
	}

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], query[128], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Düzenlemek için seçtiðiniz mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	switch(listitem)
	{
		case 0:
		{
			EditingObject[playerid] = 22; EditingID[playerid] = data[PropertyID]; EditDynamicObject(playerid, objid);
    		InfoTD_MSG(playerid, 1, 5000, "\" ~y~SPACE ~w~\" ve \" ~y~MMB ~w~\" TUSLARINA BASARAK MOBILYAYI ONUNE DOGRU GETIREBILIRSIN.");
		}
		case 1: 
		{
			data[furnitureRZ] = data[furnitureRZ] - 90.0;
			SetDynamicObjectRot(objid, data[furnitureRX], data[furnitureRY], data[furnitureRZ]);
			Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
			mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET FurnitureRZ = %f WHERE id = %i", data[furnitureRZ], data[SQLID]);
			mysql_tquery(m_Handle, query);
			Furniture_Details(playerid);
		}
		case 2:
		{
			data[furnitureRX] = data[furnitureRX] - 90.0;
			SetDynamicObjectRot(objid, data[furnitureRX], data[furnitureRY], data[furnitureRZ]);
			Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
			mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET FurnitureRX = %f WHERE id = %i", data[furnitureRX], data[SQLID]);
			mysql_tquery(m_Handle, query);
			Furniture_Details(playerid);
		}
	}

	if(!strcmp(inputtext, "Pozisyonu Kopyala"))
	{
		SetPVarInt(playerid, "FurniturePos", data[SQLID]);
	    Furniture_Details(playerid);
	} 
	else if(!strcmp(inputtext, "* Pozisyonu Yapýþtýr"))
	{
		new datafrom[e_furniture];
		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, GetPVarInt(playerid, "FurniturePos"), E_STREAMER_EXTRA_ID, datafrom);
		if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, datafrom[SQLID]))
		{
			SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Pozisyonunu kopyaladýðýn mobilya ortalýkta yok.");
			SetPVarInt(playerid, "FurniturePos", -1);
			Furniture_Details(playerid);
			return 1;
		}

		data[furnitureX] = datafrom[furnitureX]; data[furnitureY] = datafrom[furnitureY]; data[furnitureZ] = datafrom[furnitureZ];
		SetDynamicObjectPos(objid, data[furnitureX], data[furnitureY], data[furnitureZ]); Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
		mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET FurnitureX = %f, FurnitureY = %f, FurnitureZ = %f WHERE id = %i", data[furnitureX], data[furnitureY], data[furnitureZ], data[SQLID]);
		mysql_tquery(m_Handle, query);
		Furniture_Details(playerid);
	}
	else if(!strcmp(inputtext, "Rotasyonu Kopyala"))
	{
		SetPVarInt(playerid, "FurnitureRot", data[SQLID]);
	    Furniture_Details(playerid);
	}
	else if(!strcmp(inputtext, "* Rotasyonu Yapýþtýr"))
	{
		new datafrom[e_furniture];
		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, GetPVarInt(playerid, "FurnitureRot"), E_STREAMER_EXTRA_ID, datafrom);
		if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, datafrom[SQLID]))
		{
			SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Rotasyonunu kopyaladýðýn mobilya ortalýkta yok.");
			SetPVarInt(playerid, "FurnitureRot", -1);
			Furniture_Details(playerid);
			return 1;
		}

		data[furnitureRX] = datafrom[furnitureRX]; data[furnitureRY] = datafrom[furnitureRY]; data[furnitureRZ] = datafrom[furnitureRZ];
		SetDynamicObjectRot(objid, data[furnitureRX], data[furnitureRY], data[furnitureRZ]); Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
		mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET FurnitureRX = %f, FurnitureRY = %f, FurnitureRZ = %f WHERE id = %i", data[furnitureRX], data[furnitureRY], data[furnitureRZ], data[SQLID]);
		mysql_tquery(m_Handle, query);
		Furniture_Details(playerid);
	}
	return 1;
}

Dialog:FURNITURE_TEXTURE(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		return Furniture_Edit(playerid);
	}

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], query[64], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Dekorasyon için seçtiðiniz mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	if(listitem < 5)
	{
 		Dialog_Show(playerid, FURNITURE_TEXTURE_SELECT, DIALOG_STYLE_LIST, sprintf("Mobilya Dekorasyon {00FF22}(%i)", listitem+1), "Dekorasyon Seç\n{FFFF00}Dekorasyon Kaldýr", "Seç", "<<<");
        SetPVarInt(playerid, "chose_texture", listitem);
		return 1;
	}

  	for(new i; i < 5; i++)
	{
	    if(data[furnitureTexture][i] == -1)
	        continue;

		data[furnitureTexture][i] = -1;
        SetDynamicObjectMaterial(objid, i, -1, "none", "none", 0);
		mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET Texture_%i = -1 WHERE id = %i", i+1, data[SQLID]);
		mysql_tquery(m_Handle, query);
	}

    Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
 	SendClientMessageEx(playerid, COLOR_WHITE, "%s adlý mobilyanýn tüm dekorasyonunu sýfýrladýn.", data[furnitureName]);
	Furniture_Edit(playerid);
	return 1;
}

Dialog:FURNITURE_TEXTURE_SELECT(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		return Furniture_Edit(playerid);
	}

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], query[64], objid = GetPVarInt(playerid, "chose_slot"), slot = GetPVarInt(playerid, "chose_texture");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Dekorasyon için seçtiðiniz mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	switch(listitem)
	{
	    case 0:
		{
		    new Float:x,
				Float:y,
				Float:z,
				Float:facing,
				Float:distance = 3.0;

		    GetPlayerPos(playerid, x, y, z);
		    GetPlayerFacingAngle(playerid, facing);

		  	x += (distance * floatsin(-facing, degrees));
		    y += (distance * floatcos(-facing, degrees));

            InfoTD_MSG(playerid, 1, 20000, "\
	 		\" ~y~Y ~w~\" ve \" ~y~N ~w~\" TUSLARIYLA DEKORASYONLARI GEZEBILIRSIN.~n~\
            \" ~y~H ~w~\" TUSUYLA DEKORASYON SLOTUNU DEGISTIREBILIRSIN.~n~\
            \" ~y~SPACE ~w~\" TUSUYLA SECILI DEKORASYONU UYGULAYABILIRSIN.~n~\
            \" ~y~ENTER ~w~\" TUSUYLA DEKORASYON MENUSUNU KAPATABILIRSIN.~n~");

			PlayerData[playerid][p3DMenu] = Create3DMenu(playerid, x, y, z, facing, 16);
		    Select3DMenu(playerid, PlayerData[playerid][p3DMenu]);
			return 1;
		}
		case 1:
	    {
	        if(data[furnitureTexture][slot] == -1) 
	        {
	            SendErrorMessage(playerid, "Seçtiðiniz slotta dekorasyon bulunmuyor.");
	            Furniture_Edit(playerid);
	            return 1;
	        }

        	data[furnitureTexture][slot] = -1;
        	SetDynamicObjectMaterial(objid, slot, -1, "none", "none", 0);
            SendClientMessageEx(playerid, COLOR_WHITE, "%s adlý mobilyanýn %i numaralý slotta bulunan dekorasyonunu sýfýrladýn.", data[furnitureName], slot+1);
			Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
			mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET Texture_%i = -1 WHERE id = %i", slot+1, data[SQLID]);
			mysql_tquery(m_Handle, query);
	        return 1;
	    }
	}
	return 1;
}

Dialog:FURNITURE_SELL(playerid, response, listitem, inputtext[])
{
    if(!response) return Furniture_Edit(playerid);

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], query[64], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);

	if(PropertyData[data[PropertyID]][PropertyOwnerID] != PlayerData[playerid][pSQLID] && data[PropertyID] != PlayerData[playerid][pGrantBuild])
	{
	    SendErrorMessage(playerid, "Sahip olmadýðýn evin mobilyasýný satamazsýn.");
	    return 1;
	}

	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Satmaya çalýþtýðýn mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	new sell_price = (data[furniturePrice] - (data[furniturePrice] & 2)) / 2;
	SendClientMessageEx(playerid, COLOR_WHITE, "%s adlý mobilyayý satarak paranýn yüzde ellisini geri aldýn. ({FFFF00}+$%s{FFFFFF})", data[furnitureName], MoneyFormat(sell_price));
	GameTextForPlayer(playerid, sprintf("~w~+$%i", sell_price), 2000, 1);
	GiveMoney(playerid, data[furniturePrice]); DestroyDynamicObject(objid);
	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM furnitures WHERE id = %i", data[SQLID]);
	mysql_tquery(m_Handle, query);

	//Streamer_RemoveArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]);
	return 1;
}

Dialog:FURNITURE_RENAME(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		return Furniture_Edit(playerid);
	}

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new data[e_furniture], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Adýný deðiþtirmeye çalýþtýðýn mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

	if(strlen(inputtext) < 1 || strlen(inputtext) > 32)
	{
		new 
			primary_str[500];

		strcat(primary_str, "{FFFF00}Mobilyanýza özel bir ad ekleme olanaðýnýz bulunuyor.\n");
		strcat(primary_str, "Bu özellik, sahip olabileceðiniz bir çok mobilyayý kolayca bulmanýzý saðlamak içindir.\n\n");

		strcat(primary_str, "Mobilyanýzýn görünmesini istediðiniz yeni adýný girin. Maksimum sýnýr 32 karakterdir.\n\n");

		strcat(primary_str, "{FF6347}[ ! ] UYARI: Bu özelliðin kötüye kullanýlmasý cezalandýrýlabilir. Kötüye kullanma.\n");
		strcat(primary_str, "[ ! ] NOT: Bu mobilya adý sadece sizin izin verdikleriniz tarafýndan görülebilir.");

		Dialog_Show(playerid, FURNITURE_RENAME, DIALOG_STYLE_INPUT, data[furnitureName], primary_str, "Deðiþtir", "<<<");
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_WHITE, "%s adlý mobilyanýn yeni adý %s olarak güncellendi.", data[furnitureName], inputtext);
    format(data[furnitureName], 64, "%s", inputtext);
    Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
    
	new query[56 + 33 + 12];
	mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET FurnitureName = '%e' WHERE ID = %i", data[furnitureName], data[SQLID]);
	mysql_tquery(m_Handle, query);

    Furniture_Edit(playerid);
	return 1;
}

Dialog:FURNITURE_COPY(playerid, response, listitem, inputtext[])
{
	if(!response) 
	{
		return Furniture_Edit(playerid);
	}

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

	new datafrom[e_furniture], objid = GetPVarInt(playerid, "chose_slot");
	Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, datafrom);
	if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, datafrom[SQLID]))
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Kopyalamaya çalýþtýðýn mobilya ortalýkta yok.");
		cmd_mobilya(playerid, "");
		return 1;
	}

    if(datafrom[furniturePrice] > PlayerData[playerid][pMoney]) 
    {
    	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yeterli paran yok. Toplam: $%s", MoneyFormat(datafrom[furniturePrice]));
    	return 1;
    }

	if(Furniture_GetCount(PlayerData[playerid][pHouseFurniture]) >= Furniture_GetLimit(playerid)) 
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Maksimum satýn alabileceðin mobilya sýnýrýna ulaþmýþsýn. (%i adet)", Furniture_GetLimit(playerid));
		return 1;
	}


    new query[512];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO furnitures (PropertyID, CategoryID, SubCategoryID, FurnitureID, FurniturePrice, FurnitureName, FurnitureX, FurnitureY, FurnitureZ, FurnitureRX, FurnitureRY, FurnitureRZ, FurnitureVW, FurnitureInt) VALUES (%i, %i, %i, %i, %i, '%e', %f, %f, %f, %f, %f, %f, %i, %i)", 
		datafrom[PropertyID], 
		datafrom[ArrayID], 
		datafrom[SubArrayID], 
		datafrom[ObjectID], 
		datafrom[furniturePrice], 
		datafrom[furnitureName], 
		datafrom[furnitureX], 
		datafrom[furnitureY], 
		datafrom[furnitureZ], 
		datafrom[furnitureRX], 
		datafrom[furnitureRY], 
		datafrom[furnitureRZ], 
		GetPlayerVirtualWorld(playerid), 
		GetPlayerInterior(playerid)
	);

    new Cache: add = mysql_query(m_Handle, query), data[e_furniture];
    data[SQLID] = cache_insert_id(); 
   	data[TempObjectID] = CreateDynamicObject(datafrom[ObjectID], datafrom[furnitureX], datafrom[furnitureY], datafrom[furnitureZ], datafrom[furnitureRX], datafrom[furnitureRY], datafrom[furnitureRZ], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    data[ArrayID] = datafrom[ArrayID]; data[SubArrayID] = datafrom[SubArrayID]; data[ObjectID] = datafrom[ObjectID]; data[PropertyID] = datafrom[PropertyID], data[BusinessID] = -1;
	format(data[furnitureName], 64, datafrom[furnitureName]); data[furniturePrice] = datafrom[furniturePrice];
	data[furnitureX] = datafrom[furnitureX], data[furnitureY] = datafrom[furnitureY], data[furnitureZ] = datafrom[furnitureZ];
	data[furnitureRX] = datafrom[furnitureRX], data[furnitureRY] = datafrom[furnitureRY], data[furnitureRZ] = datafrom[furnitureRZ];
	cache_delete(add);

	new tid;
	for(new i; i < 5; i++) 
	{
		if(datafrom[furnitureTexture][i] == -1)
   			continue;
		
		tid = datafrom[furnitureTexture][i];
		data[furnitureTexture][i] = datafrom[furnitureTexture][i];
		SetDynamicObjectMaterial(data[TempObjectID], i, ObjectTextures[tid][TModel], ObjectTextures[tid][TXDName], ObjectTextures[tid][TextureName], ObjectTextures[tid][MaterialColor]);
		mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET Texture_%i = %i WHERE id = %i", i+1, data[furnitureTexture][i], data[SQLID]);
		mysql_tquery(m_Handle, query);
	}

	if(IsHouseDoor(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn kapýyý {AFAFAF}/kapi ve /kilit {FFFFFF}komutlarýyla kontol edebilirsin.");
		data[furnitureLocked] = true, data[furnitureOpened] = false;
	} 
	else if(IsHouseRefrigerator(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn buzdolabýnýn önünde {AFAFAF}/candoldur {FFFFFF}yazarak canýný fulleyebilirsin.");
	}
	else if(IsHouseSafe(data[ObjectID]))
	{
		SendClientMessage(playerid, COLOR_SOFTPINK, "Bunu biliyor muydun?");
		SendClientMessage(playerid, COLOR_WHITE, "Satýn alacaðýn kasayla {AFAFAF}/ev paracek/parayatir {FFFFFF}komutlarýný kullanabileceksin.");
	}

	Streamer_SetArrayData(STREAMER_TYPE_OBJECT, data[TempObjectID], E_STREAMER_EXTRA_ID, data);
	
	EditingID[playerid] = data[PropertyID]; EditingObject[playerid] = 21;
	EditDynamicObject(playerid, data[TempObjectID]); SetPVarInt(playerid, "chose_slot", data[TempObjectID]);
	GiveMoney(playerid, -data[furniturePrice]);

    InfoTD_MSG(playerid, 1, 5000, "\
		\" ~y~SPACE ~w~\" ve \" ~y~MMB ~w~\" TUSLARINA BASARAK MOBILYAYI ONUNE DOGRU GETIREBILIRSIN.~n~\
		EGER MOBILYAYI BEGENMEDIYSEN \" ~r~ESC ~w~\" TUSUNA BASARAK IADE EDEBILIRSIN.");
	return 1;
}

Furniture_Edit(playerid)
{
    new primary_str[156];
	strcat(primary_str, "Mobilya Bilgisi\nPozisyonu Deðiþtir\n");
	strcat(primary_str, !PlayerData[playerid][pDonator] ? "{FF6347}Dekorasyon Deðiþtir [+Baðýþçý]\n" : "Dekorasyon Deðiþtir\n");		
	strcat(primary_str, "Sat\nAdýný Deðiþtir\nKopyala\n");
 	Dialog_Show(playerid, FURNITURE_EDIT, DIALOG_STYLE_LIST, "Mobilya Düzenle", primary_str, "Seç", "<<<");
 	return 1;
}

Furniture_Details(playerid)
{
	new primary_str[140];
	strcat(primary_str, "Hareket Ettirme Aracý\nYön Düzeltme\nKeskin Dönüþ\nPozisyonu Kopyala\n");
	if(GetPVarInt(playerid, "FurniturePos") != -1) strcat(primary_str, "{FFFF00}* Pozisyonu Yapýþtýr\n");
	strcat(primary_str, "Rotasyonu Kopyala\n");
	if(GetPVarInt(playerid, "FurnitureRot") != -1) strcat(primary_str, "{FFFF00}* Rotasyonu Yapýþtýr\n");
	Dialog_Show(playerid, FURNITURE_EDIT_DETAILS, DIALOG_STYLE_LIST, "Mobilya Pozisyon Düzenle", primary_str, "Seç", "<<<");
	return 1;
}

Furniture_GetCategory(id)
{
	new query[75], cat[26];
	mysql_format(m_Handle, query, sizeof(query), "SELECT CategoryName FROM furniture_categories WHERE id = %i", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, "CategoryName", cat);
	cache_delete(cache);
	return cat;
}

Furniture_GetSubCategory(id)
{
	new query[75], sub[45];
	mysql_format(m_Handle, query, sizeof(query), "SELECT SubCategoryName FROM furniture_subcategories WHERE id = %i", id);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name(0, "SubCategoryName", sub);
	cache_delete(cache);
	return sub;
}

Furniture_GetObjID(id, inputtext[] = "")
{
	new query[129], price;
	mysql_format(m_Handle, query, sizeof(query), "SELECT ObjID FROM furniture_lists WHERE SubCategoryID = %i AND ObjName = '%e'", id, inputtext);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "ObjID", price);
	cache_delete(cache);
	return price;
}

Furniture_GetPrice(id, inputtext[] = "")
{
	new query[129], price;
	mysql_format(m_Handle, query, sizeof(query), "SELECT ObjPrice FROM furniture_lists WHERE SubCategoryID = %i AND ObjName = '%e'", id, inputtext);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "ObjPrice", price);
	cache_delete(cache);
	return price;
}

Furniture_GetCount(id)
{
	new query[60], sayi;
	mysql_format(m_Handle, query, sizeof(query), "SELECT id FROM furnitures WHERE PropertyID = %i", id);
	new Cache: cache = mysql_query(m_Handle, query);
	sayi = cache_num_rows();
	cache_delete(cache);
	return sayi;
}

Furniture_GetSubAltID(inputtext[] = "")
{
	new query[129], id;
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, SubCategoryName FROM furniture_subcategories WHERE SubCategoryName = '%e'", inputtext);
	new Cache: cache = mysql_query(m_Handle, query);
	cache_get_value_name_int(0, "id", id);
	cache_delete(cache);
	return id;
}

Furniture_GetLimit(playerid)
{
	new max_furniture;
	switch(PlayerData[playerid][pDonator])
	{
		case 1: max_furniture = 200;
		case 2: max_furniture = 300;
		case 3: max_furniture = 400;
		default: max_furniture = 70;
	}
	return max_furniture;
}

public OnPlayerSelect3DMenuBox(playerid, MenuID, boxid, list, boxes)
{
    if(PlayerData[playerid][p3DMenu] == MenuID)
    {
		if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
		{
			SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
			return 1;
		}

		new data[e_furniture], objid = GetPVarInt(playerid, "chose_slot");
		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);

		new slot = GetPVarInt(playerid, "chose_texture");
     	new tid = (list * boxes) + boxid; data[furnitureTexture][slot] = tid;
     	SetDynamicObjectMaterial(objid, slot, ObjectTextures[tid][TModel], ObjectTextures[tid][TXDName], ObjectTextures[tid][TextureName], ObjectTextures[tid][MaterialColor]);
     	Streamer_SetArrayData(STREAMER_TYPE_OBJECT, objid, E_STREAMER_EXTRA_ID, data);
     	
		new query[74];
		mysql_format(m_Handle, query, sizeof(query), "UPDATE furnitures SET Texture_%i = %i WHERE id = %i", slot+1, data[furnitureTexture][slot], data[SQLID]);
		mysql_tquery(m_Handle, query);
     	return 1;
	}
	return 1;
}

IsHouseDoor(model)
{
	switch(model)
	{
	    case 1493, 1495..1498, 1500, 1501, 1504, 1506, 1507, 1522, 1532, 1533, 1535, 1536, 1557, 1566, 1567, 3089: return 1;
	}
	return 0;
}

IsPokerTable(model)
{
	switch(model)
	{
		case 19474: return 1;
	}
	return 0;
}

IsHouseRefrigerator(model)
{
	switch(model)
	{
		case 2127, 2529, 2531, 2360, 19916: return 1;
	}
	return 0;
}

IsHouseSafe(model)
{
	switch(model)
	{
		case 2332: return 1;
	}
	return 0;
}

Furniture_Category(playerid)
{
	mysql_tquery(m_Handle, "SELECT CategoryName FROM furniture_categories", "SQL_FurnitureMainList", "i", playerid);
	return 1;
}

Server:SQL_FurnitureMainList(playerid)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
    	return 0;
    }

	new
		sub_str[40], primary_str[256], cat_name[26];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name(i, "CategoryName", cat_name, 26);
		format(sub_str, sizeof(sub_str), "%s\n", cat_name);
		strcat(primary_str, sub_str);
	}

    Dialog_Show(playerid, FURNITURE_CATEGORIES, DIALOG_STYLE_LIST, "Kategoriler:", primary_str, "Seç", "<<<");
	return 1;
}

Furniture_SubCategory(playerid, listitem)
{
	new query[129];
    mysql_format(m_Handle, query, sizeof(query), "SELECT SubCategoryName FROM furniture_subcategories WHERE CategoryID = %i", listitem);
	mysql_tquery(m_Handle, query, "SQL_FurnitureSubList", "i", playerid);
	return 1;
}

Server:SQL_FurnitureSubList(playerid)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
    	return 0;
    }

	new
		sub_str[40], primary_str[256], sub_name[45];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name(i, "SubCategoryName", sub_name, 45);
		format(sub_str, sizeof(sub_str), "%s\n", sub_name);
		strcat(primary_str, sub_str);
	}

    Dialog_Show(playerid, FURNITURE_SUBCATEGORY, DIALOG_STYLE_LIST, "Kategoriler:", primary_str, "Seç", "<<<");
	return 1;
}

Furniture_SubCategoryAlt(playerid, listitem) 
{
	new query[129];
    mysql_format(m_Handle, query, sizeof(query), "SELECT ObjName, ObjPrice FROM furniture_lists WHERE SubCategoryID = %i", listitem);
	mysql_tquery(m_Handle, query, "SQL_FurnitureSubAltList", "i", playerid);
	return 1;
}

Server:SQL_FurnitureSubAltList(playerid)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
    	return 0;
    }

	new
		primary_str[1424], objname[64], objprice;

	for(new i; i < rows; ++i)
	{
		cache_get_value_name(i, "ObjName", objname, 64);
		cache_get_value_name_int(i, "ObjPrice", objprice);
		format(primary_str, sizeof(primary_str), "%s%s\t{33AA33}$%s\n", primary_str, objname, MoneyFormat(objprice));
	}

    Dialog_Show(playerid, FURNITURE_SUBALTCATEGORY, DIALOG_STYLE_TABLIST, "Mobilyalar:", primary_str, "Seç", "<<<");
	return 1;
}

Furniture_List(playerid, page = 0)
{
	SetPVarInt(playerid, "furniture_idx", page);

    new query[125];
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, PropertyID, FurnitureID, FurnitureName FROM furnitures WHERE PropertyID = %i LIMIT %i, 25", PlayerData[playerid][pHouseFurniture], page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_FurnitureList", "ii", playerid, page);
	return 1;
}

Server:SQL_FurnitureList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

	if(IsPlayerInProperty(playerid) != PlayerData[playerid][pHouseFurniture]) 
	{
		SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		return 1;
	}

    new rows = cache_num_rows();   
    if(!rows) {
    	Dialog_Show(playerid, FURNITURE_NO_LIST, DIALOG_STYLE_LIST, sprintf("Mevcut Mobilyalar(%s%i{FFFFFF})", rows ? "{33AA33}" : "{FF6347}", rows), "Hiç mobilyan yok.", "Seç", "<<<");
        return 1;
    }

	new primary_str[1024], furniture_name[64];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", FurnitureHolder[playerid][i][0]); 
		cache_get_value_name_int(i, "PropertyID", FurnitureHolder[playerid][i][1]); 
		cache_get_value_name_int(i, "FurnitureID", FurnitureHolder[playerid][i][2]); 
		cache_get_value_name(i, "FurnitureName", furniture_name, 64);

		format(primary_str, sizeof(primary_str), "%sSlot %i. %s\n", primary_str, i+1, furniture_name);
	}

	strcat(primary_str, "{FFFF00}*Seçerek Mobilya Düzenle*");
	if(page != 0) strcat(primary_str, "{FFFF00}<<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}>>");

	Dialog_Show(playerid, FURNITURE_LIST, DIALOG_STYLE_LIST, sprintf("Mevcut Mobilyalar(%s%i{FFFFFF})", rows ? "{33AA33}" : "{FF6347}", rows), primary_str, "Seç", "<<<");
	return 1;
}

Dialog:FURNITURE_LIST(playerid, response, listitem, inputtext[])
{
	if(!response) return cmd_mobilya(playerid, "");

	new page = GetPVarInt(playerid, "furniture_idx");
	if(!strcmp(inputtext, "<<")) return Furniture_List(playerid, page-1);
	if(!strcmp(inputtext, ">>")) return Furniture_List(playerid, page+1);

	if(!strcmp(inputtext, "*Seçerek Mobilya Düzenle*"))
	{
     	SendClientMessage(playerid, COLOR_WHITE, "Düzenlemek istediðiniz mobilyayý seçiniz.");
     	SelectObject(playerid);
		return 1;
	}

	new data[e_furniture];
	for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i ++)
	{
	    if(!IsValidDynamicObject(i)) continue;
	    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, FurnitureHolder[playerid][listitem][2])) continue;

		Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
		if(data[SQLID] == FurnitureHolder[playerid][listitem][0] && data[PropertyID] == FurnitureHolder[playerid][listitem][1])
		{
			SetPVarInt(playerid, "chose_slot", i);
			Furniture_Edit(playerid);
		    break;
		}
    }
    return 1;
}

Dialog:FURNITURE_NO_LIST(playerid, response, listitem, inputtext[])
{
	cmd_mobilya(playerid, "");
	return 1;
}