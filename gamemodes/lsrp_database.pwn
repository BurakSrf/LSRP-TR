Server:LoadFurnitures()
{
	mysql_tquery(m_Handle, "SELECT * FROM properties", "SQL_LoadProperties");
	mysql_tquery(m_Handle, "SELECT * FROM furnitures", "SQL_LoadFurnitures");
	return 1;
}

Server:SQL_LoadTruckers()
{
	if(!cache_num_rows()) return print("SERVER: Hiç trucker noktasý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_TRUCK_CARGO)
	{
		Iter_Add(Trucker, i);

		cache_get_value_name_int(i, "id", TruckerData[i][tID]);
		cache_get_value_name_int(i, "type", TruckerData[i][tType]);
		cache_get_value_name(i, "name", TruckerData[i][tName], 64);

		cache_get_value_name_int(i, "storage", TruckerData[i][tStorage]);
		cache_get_value_name_int(i, "storage_size", TruckerData[i][tStorageSize]);
		cache_get_value_name_int(i, "price", TruckerData[i][tPrice]);
		cache_get_value_name_int(i, "product_id", TruckerData[i][tProductID]);
		cache_get_value_name_int(i, "product_amount", TruckerData[i][tProductAmount]);
		cache_get_value_name_int(i, "pack", TruckerData[i][tPack]);
		cache_get_value_name_int(i, "gps", TruckerData[i][tGps]);
		cache_get_value_name_int(i, "locked", TruckerData[i][tLocked]);

		cache_get_value_name_float(i, "x", TruckerData[i][tPosX]);
		cache_get_value_name_float(i, "y", TruckerData[i][tPosY]);
		cache_get_value_name_float(i, "z", TruckerData[i][tPosZ]);

		Industry_Refresh(i);
	}

	printf("SERVER: %i adet trucker noktasý yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadProperties()
{
	if(!cache_num_rows()) return print("SERVER: Hiç ev yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_PROPERTY)
	{
		Iter_Add(Properties, i);

		cache_get_value_name_int(i, "id", PropertyData[i][PropertyID]);
		cache_get_value_name_int(i, "OwnerSQL", PropertyData[i][PropertyOwnerID]);
		cache_get_value_name_int(i, "Type", PropertyData[i][PropertyType]);
		cache_get_value_name_int(i, "ComplexID", PropertyData[i][PropertyComplexLink]);
		cache_get_value_name_int(i, "Faction", PropertyData[i][PropertyFaction]);

		cache_get_value_name_int(i, "Level", PropertyData[i][PropertyLevel]);
		cache_get_value_name_int(i, "Money", PropertyData[i][PropertyMoney]);

		cache_get_value_name_float(i, "ExteriorX", PropertyData[i][PropertyEnter][0]);
		cache_get_value_name_float(i, "ExteriorY", PropertyData[i][PropertyEnter][1]);
		cache_get_value_name_float(i, "ExteriorZ", PropertyData[i][PropertyEnter][2]);
		cache_get_value_name_float(i, "ExteriorA", PropertyData[i][PropertyEnter][3]);
		cache_get_value_name_int(i, "ExteriorID", PropertyData[i][PropertyEnterInterior]);
		cache_get_value_name_int(i, "ExteriorWorld", PropertyData[i][PropertyEnterWorld]);

		cache_get_value_name_float(i, "InteriorX", PropertyData[i][PropertyExit][0]);
		cache_get_value_name_float(i, "InteriorY", PropertyData[i][PropertyExit][1]);
		cache_get_value_name_float(i, "InteriorZ", PropertyData[i][PropertyExit][2]);
		cache_get_value_name_float(i, "InteriorA", PropertyData[i][PropertyExit][3]);
		cache_get_value_name_int(i, "InteriorID", PropertyData[i][PropertyExitInterior]);
		cache_get_value_name_int(i, "InteriorWorld", PropertyData[i][PropertyExitWorld]);

		cache_get_value_name_float(i, "CheckPosX", PropertyData[i][PropertyCheck][0]);
		cache_get_value_name_float(i, "CheckPosY", PropertyData[i][PropertyCheck][1]);
		cache_get_value_name_float(i, "CheckPosZ", PropertyData[i][PropertyCheck][2]);
		cache_get_value_name_int(i, "CheckID", PropertyData[i][PropertyCheckInterior]);
		cache_get_value_name_int(i, "CheckWorld", PropertyData[i][PropertyCheckWorld]);

		cache_get_value_name_int(i, "MarketPrice", PropertyData[i][PropertyMarketPrice]);
		cache_get_value_name_int(i, "RentPrice", PropertyData[i][PropertyRentPrice]);
		cache_get_value_name_int(i, "Rentable", bool:PropertyData[i][PropertyRentable]);
		cache_get_value_name_int(i, "Locked", bool:PropertyData[i][PropertyLocked]);
		cache_get_value_name_int(i, "HasXMR", bool:PropertyData[i][PropertyHasXMR]);
		
		cache_get_value_name_int(i, "BareSwitch", PropertyData[i][PropertySwitchID]);
		cache_get_value_name_int(i, "BareType", bool:PropertyData[i][PropertySwitch]);

		cache_get_value_name_int(i, "Time", PropertyData[i][PropertyTime]);
		cache_get_value_name_int(i, "Lights", bool:PropertyData[i][PropertyLights]);

		cache_get_value_name_float(i, "XMRPosX", PropertyData[i][PropertyXMR][0]);
		cache_get_value_name_float(i, "XMRPosY", PropertyData[i][PropertyXMR][1]);
		cache_get_value_name_float(i, "XMRPosZ", PropertyData[i][PropertyXMR][2]);
		cache_get_value_name_float(i, "XMRRotX", PropertyData[i][PropertyXMR][3]);
		cache_get_value_name_float(i, "XMRRotY", PropertyData[i][PropertyXMR][4]);
		cache_get_value_name_float(i, "XMRRotZ", PropertyData[i][PropertyXMR][5]);
	
		//new property_query[75];
       	//mysql_format(m_Handle, property_query, sizeof(property_query), "SELECT * FROM furnitures WHERE propertyid = %i", i);
		//mysql_tquery(m_Handle, property_query, "OnFurnituresLoad", "ii", i, 1);

		new property_query[75];
		mysql_format(m_Handle, property_query, sizeof(property_query), "SELECT * FROM property_drugs WHERE property_id = %i", i);
		mysql_tquery(m_Handle, property_query, "SQL_LoadPropertyDrugs", "i", i);

		mysql_format(m_Handle, property_query, sizeof(property_query), "SELECT * FROM property_weapons WHERE property_id = %i", i);
		mysql_tquery(m_Handle, property_query, "SQL_LoadPropertyWeaps", "i", i);

		Property_Refresh(i);
	}

	printf("SERVER: %i adet ev yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadPropertyDrugs(id)
{
	if(!cache_num_rows()) return 1;

  	for (new i = 0, j = 1; i < cache_num_rows(); i++, j++) if (j < MAX_PACK_SLOT)
    {
		property_drug_data[id][j][is_exist] = true;
	    cache_get_value_name_int(i, "id", property_drug_data[id][j][data_id]);
	   	cache_get_value_name_int(i, "property_id", property_drug_data[id][j][property_id]);
	    cache_get_value_name_int(i, "drug_type", property_drug_data[id][j][prop_drug_id]);
	    cache_get_value_name(i, "drug_name", property_drug_data[id][j][prop_drug_name], 64);
	    cache_get_value_name_float(i, "drug_amount", property_drug_data[id][j][prop_drug_amount]);
	    cache_get_value_name_int(i, "drug_quality", property_drug_data[id][j][prop_drug_quality]);
	    cache_get_value_name_int(i, "drug_size", property_drug_data[id][j][prop_drug_size]);
	}
	return 1;
}

Server:SQL_LoadPropertyWeaps(prop_id)
{
	if(!cache_num_rows()) return 1;

	for (new i = 0, j = 1; i < cache_num_rows(); i++, j++) if (j < MAX_PACK_SLOT)
	{
		property_weap_data[prop_id][j][is_exist] = true;
	    cache_get_value_name_int(i, "id", property_weap_data[prop_id][j][data_id]);
	    cache_get_value_name_int(i, "weapon", property_weap_data[prop_id][j][prop_wep]);
		cache_get_value_name_int(i, "ammo", property_weap_data[prop_id][j][prop_ammo]);
		cache_get_value_name_int(i, "property_id", property_weap_data[prop_id][j][property_id]);
	}
	return 1;
}

Server:SQL_LoadFurnitures()
{
	if(!cache_num_rows()) return print("SERVER: Hiç mobilya yüklenmedi.");

	new id, vw, interior, data[e_furniture], txt[12];

	for (new i = 0, j = cache_num_rows(); i < j; i ++)
	{
		cache_get_value_name_int(i, "id", data[SQLID]);
		cache_get_value_name_int(i, "PropertyID", data[PropertyID]);
		cache_get_value_name_int(i, "BusinessID", data[BusinessID]);
		cache_get_value_name_int(i, "CategoryID", data[ArrayID]);
		cache_get_value_name_int(i, "SubCategoryID", data[SubArrayID]);
		cache_get_value_name_int(i, "FurnitureID", data[ObjectID]);
		cache_get_value_name_int(i, "FurniturePrice", data[furniturePrice]);
		cache_get_value_name(i, "FurnitureName", data[furnitureName], 64);
      	cache_get_value_name_float(i, "FurnitureX", data[furnitureX]);
       	cache_get_value_name_float(i, "FurnitureY", data[furnitureY]);
        cache_get_value_name_float(i, "FurnitureZ", data[furnitureZ]);
        cache_get_value_name_float(i, "FurnitureRX", data[furnitureRX]);
        cache_get_value_name_float(i, "FurnitureRY", data[furnitureRY]);
        cache_get_value_name_float(i, "FurnitureRZ", data[furnitureRZ]);
        cache_get_value_name_int(i, "FurnitureVW", vw);
        cache_get_value_name_int(i, "FurnitureInt", interior);

		data[TempObjectID] = CreateDynamicObject(
				data[ObjectID],
				data[furnitureX], data[furnitureY], data[furnitureZ],
          		data[furnitureRX], data[furnitureRY], data[furnitureRZ],
				vw, interior
			);

		if(IsHouseDoor(data[ObjectID])) data[furnitureLocked] = true, data[furnitureOpened] = false;

		for(new t; t < 5; t++) 
		{
			format(txt, sizeof(txt), "Texture_%i", t+1);
			cache_get_value_name_int(i, txt, data[furnitureTexture][t]);
			
			if(data[furnitureTexture][t] == -1)
		        continue;

			id = data[furnitureTexture][t];
			SetDynamicObjectMaterial(data[TempObjectID], t, ObjectTextures[id][TModel], ObjectTextures[id][TXDName], ObjectTextures[id][TextureName], ObjectTextures[id][MaterialColor]);
		}
		
		Streamer_SetArrayData(STREAMER_TYPE_OBJECT, data[TempObjectID], E_STREAMER_EXTRA_ID, data);
	}
	return 1;
}

Server:SQL_LoadFactions()
{
	if(!cache_num_rows()) return print("SERVER: Hiç birlik yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_FACTIONS)
	{
	    Iter_Add(Factions, i);
		cache_get_value_name_int(i, "id", FactionData[i][FactionID]);
		cache_get_value_name(i, "Name", FactionData[i][FactionName], 128);
		cache_get_value_name(i, "Abbreviation", FactionData[i][FactionAbbrev], 128);

		cache_get_value_name_int(i, "MaxRanks", FactionData[i][FactionMaxRanks]);
		cache_get_value_name_int(i, "EditRank", FactionData[i][FactionEditrank]);
		cache_get_value_name_int(i, "ChatRank", FactionData[i][FactionChatrank]);
		cache_get_value_name_int(i, "TowRank", FactionData[i][FactionTowrank]);

		cache_get_value_name_int(i, "ChatColor", FactionData[i][FactionChatColor]);
		cache_get_value_name_int(i, "ChatStatus", FactionData[i][FactionChatStatus]);
		cache_get_value_name_int(i, "CopPerms", FactionData[i][FactionCopPerms]);
		cache_get_value_name_int(i, "MedPerms", FactionData[i][FactionMedPerms]);
		cache_get_value_name_int(i, "SanPerms", FactionData[i][FactionSanPerms]);

		cache_get_value_name_float(i, "SpawnX", FactionData[i][FactionSpawn][0]);
		cache_get_value_name_float(i, "SpawnY", FactionData[i][FactionSpawn][1]);
		cache_get_value_name_float(i, "SpawnZ", FactionData[i][FactionSpawn][2]);
		cache_get_value_name_float(i, "SpawnA", FactionData[i][FactionSpawn][3]);
		cache_get_value_name_int(i, "SpawnInt", FactionData[i][FactionSpawnInterior]);
		cache_get_value_name_int(i, "SpawnWorld", FactionData[i][FactionSpawnVW]);

		cache_get_value_name_float(i, "ExSpawn1X", FactionData[i][FactionSpawnEx1][0]);
		cache_get_value_name_float(i, "ExSpawn1Y", FactionData[i][FactionSpawnEx1][1]);
		cache_get_value_name_float(i, "ExSpawn1Z", FactionData[i][FactionSpawnEx1][2]);
		cache_get_value_name_int(i, "ExSpawn1Int", FactionData[i][FactionSpawnEx1Interior]);
		cache_get_value_name_int(i, "ExSpawn1World", FactionData[i][FactionSpawnEx1VW]);

		cache_get_value_name_float(i, "ExSpawn2X", FactionData[i][FactionSpawnEx2][0]);
		cache_get_value_name_float(i, "ExSpawn2Y", FactionData[i][FactionSpawnEx2][1]);
		cache_get_value_name_float(i, "ExSpawn2Z", FactionData[i][FactionSpawnEx2][2]);
		cache_get_value_name_int(i, "ExSpawn2Int", FactionData[i][FactionSpawnEx2Interior]);
		cache_get_value_name_int(i, "ExSpawn2World", FactionData[i][FactionSpawnEx2VW]);
		
		cache_get_value_name_float(i, "ExSpawn3X", FactionData[i][FactionSpawnEx3][0]);
		cache_get_value_name_float(i, "ExSpawn3Y", FactionData[i][FactionSpawnEx3][1]);
		cache_get_value_name_float(i, "ExSpawn3Z", FactionData[i][FactionSpawnEx3][2]);
		cache_get_value_name_int(i, "ExSpawn3Int", FactionData[i][FactionSpawnEx3Interior]);
		cache_get_value_name_int(i, "ExSpawn3World", FactionData[i][FactionSpawnEx3VW]);

		cache_get_value_name_int(i, "Bank", FactionData[i][FactionBank]);

		new faction_query[64];
		mysql_format(m_Handle, faction_query, sizeof(faction_query), "SELECT * FROM faction_ranks WHERE faction_id = %i", FactionData[i][FactionID]);
		mysql_tquery(m_Handle, faction_query, "SQL_LoadFactionRanks", "i", i);
	}

	printf("SERVER: %i adet birlik yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadFactionRanks(id)
{
	if(!cache_num_rows()) return 1;

	new str[25];
	for (new i = 0; i < cache_num_rows(); i++)
	{
		for (new j = 1; j < MAX_FACTION_RANKS; j++)
		{
			format(str, sizeof(str), "factionrank%i", j);
			cache_get_value_name(i, str, FactionRanks[id][j], 60);
			
			format(str, sizeof(str), "factionranksalary%i", j);
			cache_get_value_name_int(i, str, FactionRanksSalary[id][j]);
		}
	}
	return 1;
}

Server:SQL_LoadTolls()
{
	if(!cache_num_rows()) return print("SERVER: Hiç giþe yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_TOLLS)
	{
		Iter_Add(Tolls, i);

		cache_get_value_name_int(i, "id", TollData[i][TollID]);
		cache_get_value_name(i, "TollName", TollData[i][TollName], 25);
		cache_get_value_name_int(i, "TollModel", TollData[i][TollModel]);
		cache_get_value_name_int(i, "TollPrice", TollData[i][TollPrice]);

		cache_get_value_name_float(i, "PosX", TollData[i][TollPos][0]);
		cache_get_value_name_float(i, "PosY", TollData[i][TollPos][1]);
		cache_get_value_name_float(i, "PosZ", TollData[i][TollPos][2]);
		cache_get_value_name_float(i, "RotX", TollData[i][TollPos][3]);
		cache_get_value_name_float(i, "RotY", TollData[i][TollPos][4]);
		cache_get_value_name_float(i, "RotZ", TollData[i][TollPos][5]);

		cache_get_value_name_int(i, "TollInterior", TollData[i][TollInterior]);
		cache_get_value_name_int(i, "TollWorld", TollData[i][TollWorld]);

		cache_get_value_name_float(i, "OpenX", TollData[i][TollMovePos][0]);
		cache_get_value_name_float(i, "OpenY", TollData[i][TollMovePos][1]);
		cache_get_value_name_float(i, "OpenZ", TollData[i][TollMovePos][2]);
		cache_get_value_name_float(i, "OpenRotX", TollData[i][TollMovePos][3]);
		cache_get_value_name_float(i, "OpenRotY", TollData[i][TollMovePos][4]);
		cache_get_value_name_float(i, "OpenRotZ", TollData[i][TollMovePos][5]);

		Toll_Refresh(i);
	}		

	printf("SERVER: %i adet giþe yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadCameras()
{
	if(!cache_num_rows()) return print("SERVER: Hiç CCTV yüklenmedi.");

    for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_CCTVS)
    {
    	Iter_Add(Cameras, i);

        cache_get_value_name_int(i, "id", CameraData[i][CameraID]);
        cache_get_value_name(i, "CameraName", CameraData[i][CameraName], 30);

        cache_get_value_name_float(i, "CameraX", CameraData[i][CameraLocation][0]);
        cache_get_value_name_float(i, "CameraY", CameraData[i][CameraLocation][1]);
        cache_get_value_name_float(i, "CameraZ", CameraData[i][CameraLocation][2]);

        cache_get_value_name_float(i, "CameraRX", CameraData[i][CameraLocation][3]);
        cache_get_value_name_float(i, "CameraRY", CameraData[i][CameraLocation][4]);
        cache_get_value_name_float(i, "CameraRZ", CameraData[i][CameraLocation][5]);

        cache_get_value_name_int(i, "CameraInterior", CameraData[i][CameraInterior]);
        cache_get_value_name_int(i, "CameraWorld", CameraData[i][CameraWorld]);

        Camera_Refresh(i);
    }

	printf("SERVER: %i adet CCTV yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadBusinesses()
{
	if(!cache_num_rows()) return print("SERVER: Hiç iþyeri yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_BUSINESS)
	{
		Iter_Add(Businesses, i);

		cache_get_value_name_int(i, "id", BusinessData[i][BusinessID]);
		cache_get_value_name_int(i, "BusinessOwner", BusinessData[i][BusinessOwnerSQLID]);
		cache_get_value_name(i, "BusinessName", BusinessData[i][BusinessName], 128);
		cache_get_value_name(i, "BusinessMOTD", BusinessData[i][BusinessMOTD], 128);
		cache_get_value_name_int(i, "BusinessPrice", BusinessData[i][BusinessPrice]);
		cache_get_value_name_int(i, "BusinessType", BusinessData[i][BusinessType]);
		cache_get_value_name_int(i, "BusinessRType", BusinessData[i][BusinessRestaurantType]);

		cache_get_value_name_float(i, "EnterX", BusinessData[i][EnterPos][0]);
		cache_get_value_name_float(i, "EnterY", BusinessData[i][EnterPos][1]);
		cache_get_value_name_float(i, "EnterZ", BusinessData[i][EnterPos][2]);
		cache_get_value_name_float(i, "EnterA", BusinessData[i][EnterPos][3]);
		cache_get_value_name_int(i, "EnterInterior", BusinessData[i][EnterInterior]);
		cache_get_value_name_int(i, "EnterWorld", BusinessData[i][EnterWorld]);

		cache_get_value_name_float(i, "ExitX", BusinessData[i][ExitPos][0]);
		cache_get_value_name_float(i, "ExitY", BusinessData[i][ExitPos][1]);
		cache_get_value_name_float(i, "ExitZ", BusinessData[i][ExitPos][2]);
		cache_get_value_name_float(i, "ExitA", BusinessData[i][ExitPos][3]);
		cache_get_value_name_int(i, "ExitInterior", BusinessData[i][ExitInterior]);
		cache_get_value_name_int(i, "ExitWorld", BusinessData[i][ExitWorld]);

		cache_get_value_name_float(i, "BankX", BusinessData[i][BankPos][0]);
		cache_get_value_name_float(i, "BankY", BusinessData[i][BankPos][1]);
		cache_get_value_name_float(i, "BankZ", BusinessData[i][BankPos][2]);
		cache_get_value_name_int(i, "BankInterior", BusinessData[i][BankInterior]);
		cache_get_value_name_int(i, "BankWorld", BusinessData[i][BankWorld]);

		cache_get_value_name_int(i, "BusinessLocked", bool:BusinessData[i][BusinessLocked]);
		cache_get_value_name_int(i, "BusinessHasXMR", bool:BusinessData[i][BusinessHasXMR]);
		
		cache_get_value_name_int(i, "BusinessCashbox", BusinessData[i][BusinessCashbox]);
		cache_get_value_name_int(i, "BusinessFee", BusinessData[i][BusinessFee]);

		cache_get_value_name_int(i, "Time", BusinessData[i][BusinessTime]);
		cache_get_value_name_int(i, "Lights", bool:BusinessData[i][BusinessLights]);

		cache_get_value_name_int(i, "BusinessProduct", BusinessData[i][BusinessProduct]);
		cache_get_value_name_int(i, "BusinessWantedProduct", BusinessData[i][BusinessWantedProduct]);
		cache_get_value_name_int(i, "BusinessProductPrice", BusinessData[i][BusinessProductPrice]);

		cache_get_value_name_int(i, "Food1", BusinessData[i][BusinessFood][0]);
		cache_get_value_name_int(i, "Food2", BusinessData[i][BusinessFood][1]);
		cache_get_value_name_int(i, "Food3", BusinessData[i][BusinessFood][2]);

		cache_get_value_name_int(i, "Price1", BusinessData[i][BusinessFoodPrice][0]);
		cache_get_value_name_int(i, "Price2", BusinessData[i][BusinessFoodPrice][1]);
		cache_get_value_name_int(i, "Price3", BusinessData[i][BusinessFoodPrice][2]);

		Business_Refresh(i);
	}

	printf("SERVER: %i adet iþyeri yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadDealershipCats()
{
	if(!cache_num_rows()) return print("SERVER: Hiç araç kategorisi yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_DEALERSHIP_CAT)
	{
		Iter_Add(DealershipCats, i);
		cache_get_value_name_int(i, "id", DealershipCatData[i][CategoryID]);
		cache_get_value_name(i, "CategoryName", DealershipCatData[i][CategoryModelName], 25);
		cache_get_value_name_int(i, "CategoryModel", DealershipCatData[i][CategoryModel]);
	}

	printf("SERVER: %i adet araç kategorisi yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadDealerships()
{
	if(!cache_num_rows()) return print("SERVER: Hiç araç bilgisi yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_DEALERSHIPS)
	{
		Iter_Add(Dealerships, i);
		cache_get_value_name_int(i, "id", DealershipData[i][DealershipID]);
		cache_get_value_name_int(i, "VehicleCategory", DealershipData[i][DealershipCategory]);
		cache_get_value_name(i, "VehicleName", DealershipData[i][DealershipModelName], 45);
		cache_get_value_name_int(i, "VehicleModel", DealershipData[i][DealershipModel]);
		cache_get_value_name_int(i, "VehiclePrice", DealershipData[i][DealershipPrice]);
		cache_get_value_name_int(i, "VehicleEnabled", DealershipData[i][DealershipIsEnabled]);
	}

	printf("SERVER: %i adet araç bilgisi yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadStreets()
{
	if(!cache_num_rows()) return print("SERVER: Hiç sokak yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_STREETS)
	{
		cache_get_value_name_int(i, "id", StreetData[i][StreetID]);
		cache_get_value_name(i, "StreetName", StreetData[i][StreetName], 35);
		cache_get_value_name_int(i, "StreetX", StreetData[i][StreetX]);	
		cache_get_value_name_int(i, "StreetY", StreetData[i][StreetY]);	
		cache_get_value_name_int(i, "MaxPoints", StreetData[i][MaxPoints]);	

		new query[74];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM street_pos WHERE StreetID = %i", StreetData[i][StreetID]);
		mysql_tquery(m_Handle, query, "SQL_LoadStreetPos", "i", i);
	}

	printf("SERVER: %i adet sokak yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadStreetPos(id)
{
	if(!cache_num_rows()) return 1;

	new Float: position[200] = {};

	for (new i = 0, x = 0, j = cache_num_rows(); i < j; i++, x += 2) 
	{
	    cache_get_value_name_float(i, "StreetX", position[x]);
	    cache_get_value_name_float(i, "StreetY", position[x + 1]);
	}

	StreetData[id][StreetAreaID] = CreateDynamicPolygon(position, .maxpoints = StreetData[id][MaxPoints]);
	Iter_Add(Streets, id);
	return 1;
}	

Server:SQL_LoadAntennas()
{
	if(!cache_num_rows()) return print("SERVER: Hiç anten noktasý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_ANTENNAS)
	{
		Iter_Add(Antennas, i);

		cache_get_value_name_int(i, "id", AntennaData[i][AntennaID]);
		cache_get_value_name_float(i, "pos_x", AntennaData[i][AntennaLocation][0]);
		cache_get_value_name_float(i, "pos_y", AntennaData[i][AntennaLocation][1]);
		cache_get_value_name_float(i, "pos_z", AntennaData[i][AntennaLocation][2]);
		cache_get_value_name_float(i, "pos_rx", AntennaData[i][AntennaLocation][3]);
		cache_get_value_name_float(i, "pos_ry", AntennaData[i][AntennaLocation][4]);
		cache_get_value_name_float(i, "pos_rz", AntennaData[i][AntennaLocation][5]);
		
		AntennaData[i][AntennaObject] = CreateDynamicObject(3763, AntennaData[i][AntennaLocation][0], AntennaData[i][AntennaLocation][1], AntennaData[i][AntennaLocation][2], AntennaData[i][AntennaLocation][3], AntennaData[i][AntennaLocation][4], AntennaData[i][AntennaLocation][5]);
	}
	return 1;
}

Server:SQL_LoadEntrances()
{
	if(!cache_num_rows()) return print("SERVER: Hiç bina yüklenmedi.");
		
	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_ENTRANCES)
	{
	    Iter_Add(Entrances, i);
	    
	    cache_get_value_name_int(i, "id", EntranceData[i][EntranceID]);
	    cache_get_value_name(i, "EntranceName", EntranceData[i][EntranceName], 32);
	    
		cache_get_value_name_float(i, "EnterX", EntranceData[i][EntrancePos][0]);
		cache_get_value_name_float(i, "EnterY", EntranceData[i][EntrancePos][1]);
		cache_get_value_name_float(i, "EnterZ", EntranceData[i][EntrancePos][2]);
		cache_get_value_name_float(i, "EnterA", EntranceData[i][EntrancePos][3]);
		
		cache_get_value_name_int(i, "EnterInterior", EntranceData[i][EntranceInteriorID]);
		cache_get_value_name_int(i, "EnterWorld", EntranceData[i][EntranceWorld]);

		cache_get_value_name_float(i, "ExitX", EntranceData[i][EntranceInt][0]);
		cache_get_value_name_float(i, "ExitY", EntranceData[i][EntranceInt][1]);
		cache_get_value_name_float(i, "ExitZ", EntranceData[i][EntranceInt][2]);
		cache_get_value_name_float(i, "ExitA", EntranceData[i][EntranceInt][3]);

		cache_get_value_name_int(i, "ExitInterior", EntranceData[i][ExitInteriorID]);
		cache_get_value_name_int(i, "ExitWorld", EntranceData[i][ExitWorld]);

        cache_get_value_name_int(i, "EntranceIcon", EntranceData[i][EntranceIcon]);
        cache_get_value_name_int(i, "EntranceFaction", EntranceData[i][EntranceFaction]);
        cache_get_value_name_int(i, "EntranceLocked", bool:EntranceData[i][EntranceLocked]);

		Entrance_Refresh(i);
	}
	
	printf("SERVER: %i adet bina yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadBillboards()
{
	if(!cache_num_rows()) return print("SERVER: Hiç billboard noktasý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_BILLBOARDS)
	{
	    Iter_Add(Billboards, i);

		cache_get_value_name_int(i, "id", BillboardData[i][BillboardID]);
		cache_get_value_name_int(i, "BillboardModel", BillboardData[i][BillboardModel]);
		cache_get_value_name(i, "BillboardText", BillboardData[i][BillboardText], 128);
		
		cache_get_value_name_float(i, "BillboardX", BillboardData[i][BillboardLocation][0]);
        cache_get_value_name_float(i, "BillboardY", BillboardData[i][BillboardLocation][1]);
        cache_get_value_name_float(i, "BillboardZ", BillboardData[i][BillboardLocation][2]);
        cache_get_value_name_float(i, "BillboardRX", BillboardData[i][BillboardLocation][3]);
        cache_get_value_name_float(i, "BillboardRY", BillboardData[i][BillboardLocation][4]);
        cache_get_value_name_float(i, "BillboardRZ", BillboardData[i][BillboardLocation][5]);
        cache_get_value_name_int(i, "BillboardInterior", BillboardData[i][BillboardInterior]);
        cache_get_value_name_int(i, "BillboardWorld", BillboardData[i][BillboardWorld]);

        cache_get_value_name_int(i, "BillboardRentedBy", BillboardData[i][BillboardRentedBy]);
        cache_get_value_name_int(i, "BillboardRentExpiresAt", BillboardData[i][BillboardRentExpiresAt]);

		Billboard_Refresh(i);
	}
	printf("SERVER: %i adet billboard noktasý yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadTags()
{
	if(!cache_num_rows()) return print("SERVER: Hiç graffiti noktasý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_SPRAYS)
	{
	    Iter_Add(Tags, i);

		cache_get_value_name_int(i, "id", SprayData[i][SprayID]);
		cache_get_value_name_int(i, "SprayModel", SprayData[i][SprayModel]);
		
		cache_get_value_name_float(i, "SprayX", SprayData[i][SprayLocation][0]);
        cache_get_value_name_float(i, "SprayY", SprayData[i][SprayLocation][1]);
        cache_get_value_name_float(i, "SprayZ", SprayData[i][SprayLocation][2]);
        cache_get_value_name_float(i, "SprayRX", SprayData[i][SprayLocation][3]);
        cache_get_value_name_float(i, "SprayRY", SprayData[i][SprayLocation][4]);
        cache_get_value_name_float(i, "SprayRZ", SprayData[i][SprayLocation][5]);
        cache_get_value_name_int(i, "SprayInterior", SprayData[i][SprayInterior]);
        cache_get_value_name_int(i, "SprayWorld", SprayData[i][SprayWorld]);

		Spray_Refresh(i);
	}
	printf("SERVER: %i adet graffiti noktasý yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadObjects()
{
	if(!cache_num_rows()) return print("SERVER: Hiç sunucu objesi yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_SERVER_OBJECTS)
	{
		Iter_Add(Objects, i);

	   	cache_get_value_name_int(i, "id", ObjectData[i][ObjectID]);
	   	cache_get_value_name_int(i, "ObjectModel", ObjectData[i][ObjectModel]);
	   	
	    cache_get_value_name_float(i, "ObjectX", ObjectData[i][ObjectPos][0]);
	    cache_get_value_name_float(i, "ObjectY", ObjectData[i][ObjectPos][1]);
	    cache_get_value_name_float(i, "ObjectZ", ObjectData[i][ObjectPos][2]);

	    cache_get_value_name_float(i, "ObjectRX", ObjectData[i][ObjectPos][3]);
	    cache_get_value_name_float(i, "ObjectRY", ObjectData[i][ObjectPos][4]);
	    cache_get_value_name_float(i, "ObjectRZ", ObjectData[i][ObjectPos][5]);

	    cache_get_value_name_int(i, "ObjectInterior", ObjectData[i][ObjectInterior]);
	    cache_get_value_name_int(i, "ObjectWorld", ObjectData[i][ObjectWorld]);

	    Object_Refresh(i);
	}

	printf("SERVER: %i adet sunucu objesi yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadGates()
{
	if(!cache_num_rows()) return print("SERVER: Hiç hareketli kapý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_GATES)
	{
	    Iter_Add(Gates, i);
	    
		cache_get_value_name_int(i, "id", GateData[i][GateID]);
		cache_get_value_name_int(i, "GateModel", GateData[i][GateModel]);
		cache_get_value_name_float(i, "GateSpeed", GateData[i][GateSpeed]);
		cache_get_value_name_float(i, "GateRadius", GateData[i][GateRadius]);
		cache_get_value_name_int(i, "GateTime", GateData[i][GateTime]);

		cache_get_value_name_float(i, "PosX", GateData[i][GatePos][0]);
		cache_get_value_name_float(i, "PosY", GateData[i][GatePos][1]);
		cache_get_value_name_float(i, "PosZ", GateData[i][GatePos][2]);
		cache_get_value_name_float(i, "RotX", GateData[i][GatePos][3]);
		cache_get_value_name_float(i, "RotY", GateData[i][GatePos][4]);
		cache_get_value_name_float(i, "RotZ", GateData[i][GatePos][5]);

		cache_get_value_name_int(i, "GateInterior", GateData[i][GateInterior]);
		cache_get_value_name_int(i, "GateWorld", GateData[i][GateWorld]);

		cache_get_value_name_float(i, "OpenX", GateData[i][GateMovePos][0]);
		cache_get_value_name_float(i, "OpenY", GateData[i][GateMovePos][1]);
		cache_get_value_name_float(i, "OpenZ", GateData[i][GateMovePos][2]);
		cache_get_value_name_float(i, "OpenRotX", GateData[i][GateMovePos][3]);
		cache_get_value_name_float(i, "OpenRotY", GateData[i][GateMovePos][4]);
		cache_get_value_name_float(i, "OpenRotZ", GateData[i][GateMovePos][5]);

  		cache_get_value_name_int(i, "GateFaction", GateData[i][GateFaction]);
        cache_get_value_name_int(i, "GateLinkID", GateData[i][GateLinkID]);

	 	cache_get_value_name_int(i, "TIndex", GateData[i][GateTIndex]);
  		cache_get_value_name_int(i, "TModel", GateData[i][GateTModel]);

		cache_get_value_name(i, "TXDName", GateData[i][GateTXDName], 33);
		cache_get_value_name(i, "TextureName", GateData[i][GateTextureName], 33);

        GateData[i][GateStatus] = false;
		Gate_Refresh(i);
	}
	
	printf("SERVER: %d adet hareketli kapý yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadModels()
{
	if(!cache_num_rows()) return print("SERVER: Hiç model yüklenmedi.");

	new base_id, model_id, dffname[32], txdname[32];
	for (new i = 0, j = cache_num_rows(); i < j; i ++)
	{
        cache_get_value_name(i, "model_name", dffname, 32);
        strcat(dffname, ".dff");

        cache_get_value_name(i, "model_name", txdname, 32);
        strcat(txdname, ".txd");

        cache_get_value_name_int(i, "base_id", base_id);
        cache_get_value_name_int(i, "model_id", model_id);
		AddCharModel(base_id, model_id, dffname, txdname);
	}

	printf("SERVER: %d adet model yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadDoors()
{
	if(!cache_num_rows()) return print("SERVER: Hiç kapý noktasý yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_DOORS)
	{
		Iter_Add(Doors, i);

		cache_get_value_name_int(i, "id", DoorData[i][DoorID]);
		cache_get_value_name_float(i, "PosX", DoorData[i][EnterPos][0]);
		cache_get_value_name_float(i, "PosY", DoorData[i][EnterPos][1]);
		cache_get_value_name_float(i, "PosZ", DoorData[i][EnterPos][2]);
		cache_get_value_name_float(i, "PosA", DoorData[i][EnterPos][3]);
		cache_get_value_name_int(i, "PosInterior", DoorData[i][EnterInterior]);
		cache_get_value_name_int(i, "PosWorld", DoorData[i][EnterWorld]);
		
		cache_get_value_name_float(i, "IntX", DoorData[i][ExitPos][0]);
		cache_get_value_name_float(i, "IntY", DoorData[i][ExitPos][1]);
		cache_get_value_name_float(i, "IntZ", DoorData[i][ExitPos][2]);
		cache_get_value_name_float(i, "IntA", DoorData[i][ExitPos][3]);
		cache_get_value_name_int(i, "IntInterior", DoorData[i][ExitInterior]);
	 	cache_get_value_name_int(i, "IntWorld", DoorData[i][ExitWorld]);
	 	
		cache_get_value_name_int(i, "DoorFaction", DoorData[i][DoorFaction]);
		cache_get_value_name(i, "DoorName", DoorData[i][DoorName], 35);
		cache_get_value_name_int(i, "DoorLocked", bool:DoorData[i][DoorLocked]);

		Door_Refresh(i);
	}
	
	printf("SERVER: %i adet kapý noktasý yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadATMs()
{
	if(!cache_num_rows()) return print("SERVER: Hiç ATM yüklenmedi.");
	
	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_ATM_MACHINES)
	{
		Iter_Add(ATMs, i);
		
	   	cache_get_value_name_int(i, "id", ATMData[i][AtmID]);
	    cache_get_value_name_float(i, "AtmX", ATMData[i][AtmPos][0]);
	    cache_get_value_name_float(i, "AtmY", ATMData[i][AtmPos][1]);
	    cache_get_value_name_float(i, "AtmZ", ATMData[i][AtmPos][2]);
	    cache_get_value_name_float(i, "AtmRX", ATMData[i][AtmPos][3]);
	    cache_get_value_name_float(i, "AtmRY", ATMData[i][AtmPos][4]);
	    cache_get_value_name_float(i, "AtmRZ", ATMData[i][AtmPos][5]);
	    cache_get_value_name_int(i, "AtmInterior", ATMData[i][AtmInterior]);
	    cache_get_value_name_int(i, "AtmWorld", ATMData[i][AtmWorld]);

	    ATM_Refresh(i);
	}
	
	printf("SERVER: %i adet ATM yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadActors()
{
	if(!cache_num_rows()) return print("SERVER: Hiç aktör yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_ACTORS)
	{
	    Iter_Add(Actors, i);

 		cache_get_value_name_int(i, "id", ActorData[i][ActorID]);
 		cache_get_value_name(i, "ActorName", ActorData[i][ActorName], 45);
 		cache_get_value_name_int(i, "ActorSkin", ActorData[i][ActorModel]);
		cache_get_value_name_float(i, "ActorX", ActorData[i][ActorPos][0]);
		cache_get_value_name_float(i, "ActorY", ActorData[i][ActorPos][1]);
		cache_get_value_name_float(i, "ActorZ", ActorData[i][ActorPos][2]);
		cache_get_value_name_float(i, "ActorA", ActorData[i][ActorPos][3]);
		cache_get_value_name_int(i, "ActorInterior", ActorData[i][ActorInterior]);
		cache_get_value_name_int(i, "ActorWorld", ActorData[i][ActorWorld]);
		
		Actor_Refresh(i);
	}

	printf("SERVER: %i adet aktör yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadPNS()
{
	if(!cache_num_rows()) return print("SERVER: Hiç PNS yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_PAYNSPRAY)
	{
	    Iter_Add(Sprays, i);
	    
 		cache_get_value_name_int(i, "id", PNSData[i][PnsID]);
 		cache_get_value_name(i, "PnsName", PNSData[i][PnsName], 45);
 		cache_get_value_name_int(i, "PnsPrice", PNSData[i][PnsPrice]);
 		cache_get_value_name_int(i, "PnsEarnings", PNSData[i][PnsEarnings]);

		cache_get_value_name_float(i, "EnterX", PNSData[i][PnsPos][0]);
		cache_get_value_name_float(i, "EnterY", PNSData[i][PnsPos][1]);
		cache_get_value_name_float(i, "EnterZ", PNSData[i][PnsPos][2]);
		cache_get_value_name_float(i, "EnterA", PNSData[i][PnsPos][3]);
		cache_get_value_name_int(i, "EnterInterior", PNSData[i][EnterInteriorID]);
		cache_get_value_name_int(i, "EnterWorld", PNSData[i][EnterWorld]);
		
		cache_get_value_name_float(i, "RepairX", PNSData[i][PnsInt][0]);
		cache_get_value_name_float(i, "RepairY", PNSData[i][PnsInt][1]);
		cache_get_value_name_float(i, "RepairZ", PNSData[i][PnsInt][2]);
		cache_get_value_name_float(i, "RepairA", PNSData[i][PnsInt][3]);
		cache_get_value_name_int(i, "RepairInterior", PNSData[i][ExitInteriorID]);
		cache_get_value_name_int(i, "RepairWorld", PNSData[i][ExitWorld]);
		
		PNS_Refresh(i);
	}

	printf("SERVER: %i adet PNS yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadGarages()
{
	if(!cache_num_rows()) return print("SERVER: Hiç garaj yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_GARAGES)
	{
	    Iter_Add(Garages, i);
	    
		cache_get_value_name_int(i, "id", GarageData[i][GarageID]);
		cache_get_value_name_int(i, "GaragePropertyID", GarageData[i][GaragePropertyID]);
		
		cache_get_value_name_float(i, "EnterX", GarageData[i][GaragePos][0]);
		cache_get_value_name_float(i, "EnterY", GarageData[i][GaragePos][1]);
		cache_get_value_name_float(i, "EnterZ", GarageData[i][GaragePos][2]);
		cache_get_value_name_float(i, "EnterA", GarageData[i][GaragePos][3]);
		cache_get_value_name_int(i, "EnterInterior", GarageData[i][EnterInteriorID]);
		cache_get_value_name_int(i, "EnterWorld", GarageData[i][EnterWorld]);
		
		cache_get_value_name_float(i, "ExitX", GarageData[i][GarageInt][0]);
		cache_get_value_name_float(i, "ExitY", GarageData[i][GarageInt][1]);
		cache_get_value_name_float(i, "ExitZ", GarageData[i][GarageInt][2]);
		cache_get_value_name_float(i, "ExitA", GarageData[i][GarageInt][3]);
		cache_get_value_name_int(i, "ExitInterior", GarageData[i][ExitInteriorID]);
		cache_get_value_name_int(i, "ExitWorld", GarageData[i][ExitWorld]);
		
  		cache_get_value_name_int(i, "GarageFaction", GarageData[i][GarageFaction]);
        cache_get_value_name_int(i, "GarageLocked", bool:GarageData[i][GarageLocked]);

		Garage_Refresh(i);
	}

	printf("SERVER: %i adet garaj yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadGarbages()
{
    if(!cache_num_rows()) return print("SERVER: Hiç çöp kutusu yüklenmedi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_GARBAGE_BINS)
	{
	    Iter_Add(Garbages, i);
	
    	cache_get_value_name_int(i, "id", GarbageData[i][GarbageID]);
    	cache_get_value_name_int(i, "GarbageType", GarbageData[i][GarbageType]);
    	cache_get_value_name_int(i, "GarbageTakenCapacity", GarbageData[i][GarbageTakenCapacity]);
    	cache_get_value_name_int(i, "GarbageCapacity", GarbageData[i][GarbageCapacity]);
		cache_get_value_name_float(i, "GarbageX", GarbageData[i][GarbagePos][0]);
		cache_get_value_name_float(i, "GarbageY", GarbageData[i][GarbagePos][1]);
		cache_get_value_name_float(i, "GarbageZ", GarbageData[i][GarbagePos][2]);
 		cache_get_value_name_int(i, "GarbageInterior", GarbageData[i][GarbageInterior]);
    	cache_get_value_name_int(i, "GarbageWorld", GarbageData[i][GarbageWorld]);
    	
    	new array[2]; array[0] = 14; array[1] = i;
		GarbageData[i][GarbageArea] = CreateDynamicSphere(GarbageData[i][GarbagePos][0], GarbageData[i][GarbagePos][1], GarbageData[i][GarbagePos][2], 3.0, GarbageData[i][GarbageWorld], GarbageData[i][GarbageInterior]);
		Streamer_SetArrayData(STREAMER_TYPE_AREA, GarbageData[i][GarbageArea], E_STREAMER_EXTRA_ID, array, 2);
	}
	printf("SERVER: %i adet çöp kutusu yüklendi.", cache_num_rows());
	return 1;
}

Server:SQL_LoadChopshop()
{
	if(cache_num_rows() == 0)
		return print("[Chopshop] Hic chopshop verisi bulunamadi.");

    for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_CHOPSHOP)
    {
        ChopshopData[i][chopshop_exist] = true;
  		cache_get_value_name_int(i, "id", ChopshopData[i][chopshop_id]);
		cache_get_value_name_float(i, "offsetX", ChopshopData[i][chopshop_pos][0]);
		cache_get_value_name_float(i, "offsetY", ChopshopData[i][chopshop_pos][1]);
		cache_get_value_name_float(i, "offsetZ", ChopshopData[i][chopshop_pos][2]);
		cache_get_value_name_float(i, "rotX", ChopshopData[i][chopshop_pos][3]);
		cache_get_value_name_float(i, "rotY", ChopshopData[i][chopshop_pos][4]);
		cache_get_value_name_float(i, "rotZ", ChopshopData[i][chopshop_pos][5]);
		cache_get_value_name_int(i, "money", ChopshopData[i][chopshop_money]);
		
        Chopshop_Refresh(i);
    }
    return 1;
}

Server:SQL_LoadImpound()
{
	if(cache_num_rows() == 0)
		return print("[Impound] Hic arac baglama noktasi verisi bulunamadi.");

	for (new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_IMPOUND_LOTS)
	{
 		ImpoundData[i][impoundExists] = true;
	    cache_get_value_name_int(i, "impoundID", ImpoundData[i][impoundID]);
	    cache_get_value_name_float(i, "impoundLotX", ImpoundData[i][impoundLot][0]);
        cache_get_value_name_float(i, "impoundLotY", ImpoundData[i][impoundLot][1]);
        cache_get_value_name_float(i, "impoundLotZ", ImpoundData[i][impoundLot][2]);
        cache_get_value_name_float(i, "impoundReleaseX", ImpoundData[i][impoundRelease][0]);
        cache_get_value_name_float(i, "impoundReleaseY", ImpoundData[i][impoundRelease][1]);
        cache_get_value_name_float(i, "impoundReleaseZ", ImpoundData[i][impoundRelease][2]);
        cache_get_value_name_float(i, "impoundReleaseA", ImpoundData[i][impoundRelease][3]);

		Impound_Refresh(i);
	}
	return 1;
}

Server:SQL_LoadXMRData()
{
	if(!cache_num_rows()) return 1;

	new count = 0;
	for(new i = 0, j = cache_num_rows(); i < j && i < MAX_XMR_SUBCATEGORY; i++)
	{
		cache_get_value_name_int(i, "id", XMRData[i+1][xmrID]);
		cache_get_value_name_int(i, "category", XMRData[i+1][xmrCategory]);
		cache_get_value_name(i, "xmr_name", XMRData[i+1][xmrName], 90);
		cache_get_value_name(i, "xmr_url", XMRData[i+1][xmrStationURL], 128);
		count++;
	}
	printf("Loading - %d XMR stations were loaded.", count);
	return true;
}

Server:SQL_LoadXMRCategories()
{
	if(!cache_num_rows()) return 1;

	new count = 0;
	for(new i = 0, j = cache_num_rows(); i < j && i < MAX_XMR_CATEGORIES; i++)
	{
		cache_get_value_name_int(i, "id", XMRCategoryData[i+1][XMRID]);
		cache_get_value_name(i, "cat_name", XMRCategoryData[i+1][XMRCategoryName], 90);
		cache_get_value_name_int(i, "category_id", XMRCategoryData[i+1][XMRCategory]);
		count++;
	}
	printf("Loading - %d XMR sub categories were loaded.", count);
	return true;
}

Server:SQL_LoadPlayerNotes(playerid)
{
	if(!cache_num_rows()) return 1;

	for(new i = 0, j = cache_num_rows(); i < j; i++) if (i < MAX_PLAYER_NOTES)
	{
		cache_get_value_name_int(i, "id", NoteData[playerid][i][NoteID]);
		cache_get_value_name(i, "details", NoteData[playerid][i][NoteDetails], 128);
		cache_get_value_name_int(i, "time", NoteData[playerid][i][NoteTime]);
	}
	return 1;
}

Server:LoadPlayerFines(playerid)
{
	if(!cache_num_rows()) return 1;
	
	for(new i = 0, j = cache_num_rows(); i < j; i ++) if (i < MAX_FINES)
	{
		cache_get_value_name_int(i, "id", Fines[playerid][i][fine_id]);
		cache_get_value_name(i, "issuer_name", Fines[playerid][i][fine_issuer], 24);
		cache_get_value_name_int(i, "fine_amount", Fines[playerid][i][fine_amount]);
		cache_get_value_name_int(i, "fine_faction", Fines[playerid][i][fine_faction]);
		cache_get_value_name(i, "fine_reason", Fines[playerid][i][fine_reason], 128);
		cache_get_value_name_int(i, "fine_date", Fines[playerid][i][fine_date]);
	}
	return 1;
}

Server:SQL_LoadClothing(playerid)
{
	if(!cache_num_rows()) return 1;
	
	for(new i = 0, j = cache_num_rows(); i < j; i++) if (i < MAX_CLOTHING_ITEMS)
	{
		cache_get_value_name_int(i, "id", ClothingData[playerid][i][ClothingID]);
		cache_get_value_name_int(i, "player_dbid", ClothingData[playerid][i][ClothingOwnerID]);
		cache_get_value_name(i, "clothing_name", ClothingData[playerid][i][ClothingName], 20);

		cache_get_value_name_int(i, "slot_id", ClothingData[playerid][i][ClothingSlotID]);
		cache_get_value_name_int(i, "model_id", ClothingData[playerid][i][ClothingModelID]);
		cache_get_value_name_int(i, "bone_id", ClothingData[playerid][i][ClothingBoneID]);

		cache_get_value_name_float(i, "pos_x", ClothingData[playerid][i][ClothingPos][0]);
		cache_get_value_name_float(i, "pos_y", ClothingData[playerid][i][ClothingPos][1]);
		cache_get_value_name_float(i, "pos_z", ClothingData[playerid][i][ClothingPos][2]);

		cache_get_value_name_float(i, "rot_x", ClothingData[playerid][i][ClothingRot][0]);
		cache_get_value_name_float(i, "rot_y", ClothingData[playerid][i][ClothingRot][1]);
		cache_get_value_name_float(i, "rot_z", ClothingData[playerid][i][ClothingRot][2]);

		cache_get_value_name_float(i, "scale_x", ClothingData[playerid][i][ClothingScale][0]);
		cache_get_value_name_float(i, "scale_y", ClothingData[playerid][i][ClothingScale][1]);
		cache_get_value_name_float(i, "scale_z", ClothingData[playerid][i][ClothingScale][2]);

		cache_get_value_name_int(i, "auto_wear", bool:ClothingData[playerid][i][ClothingAutoWear]);

		cache_get_value_name_int(i, "color1", ClothingData[playerid][i][ClothingColor]);
		cache_get_value_name_int(i, "color2", ClothingData[playerid][i][ClothingColor2]);

		if(ClothingData[playerid][i][ClothingAutoWear]) 
		{
			if(!IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[playerid][i][ClothingSlotID])) {
				SetPlayerAttachedObject(playerid, ClothingData[playerid][i][ClothingSlotID], ClothingData[playerid][i][ClothingModelID], ClothingData[playerid][i][ClothingBoneID], ClothingData[playerid][i][ClothingPos][0], ClothingData[playerid][i][ClothingPos][1], ClothingData[playerid][i][ClothingPos][2], ClothingData[playerid][i][ClothingRot][0], ClothingData[playerid][i][ClothingRot][1], ClothingData[playerid][i][ClothingRot][2], ClothingData[playerid][i][ClothingScale][0], ClothingData[playerid][i][ClothingScale][1], ClothingData[playerid][i][ClothingScale][2], ClothingData[playerid][i][ClothingColor], ClothingData[playerid][i][ClothingColor2]);
			}
		}

	}
	return 1;
}

Server:SQL_LoadPlayerContacts(playerid)
{
	if(!cache_num_rows()) return 1;
	
	for(new i = 0, j = cache_num_rows(); i < j; i++) if(i < MAX_PLAYER_CONTACTS)
	{
		cache_get_value_name_int(i, "id", ContactsData[playerid][i+1][contactSQLID]);
		cache_get_value_name_int(i, "playersqlid", ContactsData[playerid][i+1][contactPlayerSQLID]);
		cache_get_value_name_int(i, "contactid", ContactsData[playerid][i+1][contactID]);

		cache_get_value_name(i, "contact_name", ContactsData[playerid][i+1][contactName], 128);
		cache_get_value_name_int(i, "contact_num", ContactsData[playerid][i+1][contactNumber]);
	}
	return 1;
}

Server:SQL_LoadAdminNotes(playerid)
{
	if(!cache_num_rows()) return 1;

	for(new i = 0, j = cache_num_rows(); i < j; i++) if(i < MAX_ADMIN_NOTES)
	{
		cache_get_value_name_int(i, "id", aNotesData[playerid][i+1][anote_SQLID]);
		cache_get_value_name_int(i, "player_dbid", aNotesData[playerid][i+1][anote_playerDBID]);
		cache_get_value_name(i, "anote_reason", aNotesData[playerid][i+1][anote_reason], 128);
		cache_get_value_name(i, "anote_issuer", aNotesData[playerid][i+1][anote_issuer], 60);
		cache_get_value_name_int(i, "anote_date", aNotesData[playerid][i+1][anote_date]);
		cache_get_value_name_int(i, "anote_active", aNotesData[playerid][i+1][anote_active]);
	}

	/*
	for(new i = 1; i < MAX_ADMIN_NOTES; i++)
	{
		if(aNotesData[playerid][i][anote_SQLID] != 0)
		{
			if(aNotesData[playerid][i][anote_active])
			{
				adminWarn(1, sprintf("Player %s has %d active OnAdminAction notes on him, last is: %s", ReturnName(playerid, 1), CountAdminNotes(playerid), aNotesData[playerid][i][anote_reason]));
			}
			else continue;
		}
	}*/
	return 1;
}

Server:SQL_LoadVehicles()
{
    if(!cache_num_rows()) return 1;

	new 
		str[20], vehicleid = INVALID_VEHICLE_ID;
		
	for(new i = 0, c = cache_num_rows(); i < c; i++) if(i < MAX_VEHICLES)
	{
		vehicleid = CreateVehicle(vericek_int(i, "ModelID"),
									vericek_float(i, "PosX"),
									vericek_float(i, "PosY"),
									vericek_float(i, "PosZ"),
									vericek_float(i, "PosA"),
									vericek_int(i, "Color1"),
									vericek_int(i, "Color2"), -1, vericek_int(i, "Siren"));
									
    	if(vehicleid != INVALID_VEHICLE_ID)
		{
		    Vehicle_DefaultValues(vehicleid);
		    CarData[vehicleid][carExists] = true;

            cache_get_value_name_int(i, "id", CarData[vehicleid][carID]);
			cache_get_value_name_int(i, "ModelID", CarData[vehicleid][carModel]);
			cache_get_value_name_int(i, "OwnerID", CarData[vehicleid][carOwnerID]);
			cache_get_value_name_int(i, "FactionID", CarData[vehicleid][carFaction]);
			
			cache_get_value_name_int(i, "RentalID", CarData[vehicleid][carRental]);
			cache_get_value_name_int(i, "RentalPrice", CarData[vehicleid][carRentalPrice]);
			cache_get_value_name_int(i, "RentedBy", CarData[vehicleid][carRentedBy]);

        	cache_get_value_name(i, "Plate", CarData[vehicleid][carPlates], 20);
        	SetVehicleNumberPlate(vehicleid, CarData[vehicleid][carPlates]);

            cache_get_value_name(i, "VehicleName", CarData[vehicleid][carName], 35);
			cache_get_value_name(i, "CarSign", CarData[vehicleid][carSign], 45);

			cache_get_value_name_float(i, "PosX", CarData[vehicleid][carPos][0]);
			cache_get_value_name_float(i, "PosY", CarData[vehicleid][carPos][1]);
			cache_get_value_name_float(i, "PosZ", CarData[vehicleid][carPos][2]);
			cache_get_value_name_float(i, "PosA", CarData[vehicleid][carPos][3]);

			cache_get_value_name_int(i, "Interior", CarData[vehicleid][carInterior]);
			cache_get_value_name_int(i, "World", CarData[vehicleid][carWorld]);

			cache_get_value_name_int(i, "Color1", CarData[vehicleid][carColor1]);
			cache_get_value_name_int(i, "Color2", CarData[vehicleid][carColor2]);

			cache_get_value_name_int(i, "XMR", bool:CarData[vehicleid][carXMR]);
			cache_get_value_name_int(i, "Siren", bool:CarData[vehicleid][carSiren]);
        	cache_get_value_name_int(i, "Locked", bool:CarData[vehicleid][carLocked]);

        	cache_get_value_name_int(i, "Impounded", CarData[vehicleid][carImpounded]);

        	cache_get_value_name_float(i, "Fuel", CarData[vehicleid][carFuel]);
        	cache_get_value_name_float(i, "Mileage", CarData[vehicleid][carMileage]);
        	cache_get_value_name_float(i, "Armour", CarData[vehicleid][carArmour]);
        	cache_get_value_name_float(i, "EngineLife", CarData[vehicleid][carEngine]);
        	cache_get_value_name_float(i, "BatteryLife", CarData[vehicleid][carBattery]);

			cache_get_value_name_int(i, "LockLevel", CarData[vehicleid][carLock]);
			cache_get_value_name_int(i, "AlarmLevel", CarData[vehicleid][carAlarm]);
			cache_get_value_name_int(i, "ImmobLevel", CarData[vehicleid][carImmob]);
			
			cache_get_value_name_int(i, "Insurance", CarData[vehicleid][carInsurance]);
			cache_get_value_name_int(i, "InsuranceTime", CarData[vehicleid][carInsuranceTime]);
			cache_get_value_name_int(i, "InsurancePrice", CarData[vehicleid][carInsurancePrice]);
			
			cache_get_value_name_int(i, "TimesDestroyed", CarData[vehicleid][carTimeDestroyed]);
			cache_get_value_name_int(i, "Paintjob", CarData[vehicleid][carPaintjob]);

			if(CarData[vehicleid][carPaintjob] != -1) ChangeVehiclePaintjob(vehicleid, CarData[vehicleid][carPaintjob]);

			for(new m; m < 14; m++) 
			{
				format(str, sizeof(str), "CarMods%i", m+1);
				cache_get_value_name_int(i, str, CarData[vehicleid][carMods][m]);

				if(m < 4)
				{
					format(str, sizeof(str), "CarDoors%i", m+1);
					cache_get_value_name_int(i, str, CarData[vehicleid][carDoors][m]);

					format(str, sizeof(str), "CarWindows%i", m+1);
					cache_get_value_name_int(i, str, CarData[vehicleid][carWindows][m]);
				}
			}

			cache_get_value_name_int(i, "LastDriver", CarData[vehicleid][carlastDriver]);
			cache_get_value_name_int(i, "LastPassenger", CarData[vehicleid][carlastPassenger]);

			cache_get_value_name_float(i, "LastHealth", CarData[vehicleid][carLastHealth]);
			cache_get_value_name_int(i, "Panels", CarData[vehicleid][carPanelStatus]);
			cache_get_value_name_int(i, "Doors", CarData[vehicleid][carDoorsStatus]);
			cache_get_value_name_int(i, "Lights", CarData[vehicleid][carLightsStatus]);
			cache_get_value_name_int(i, "Tires", CarData[vehicleid][carTiresStatus]);

			//SetVehicleParamsCarDoors(vehicleid, CarData[vehicleid][carDoors][0], CarData[vehicleid][carDoors][1], CarData[vehicleid][carDoors][2], CarData[vehicleid][carDoors][3]);
			//SetVehicleParamsCarWindows(vehicleid, CarData[vehicleid][carWindows][0], CarData[vehicleid][carWindows][1], CarData[vehicleid][carWindows][2], CarData[vehicleid][carWindows][3]);
			//UpdateVehicleDamageStatus(vehicleid, CarData[vehicleid][carPanelStatus], CarData[vehicleid][carDoorsStatus], CarData[vehicleid][carLightsStatus], CarData[vehicleid][carTiresStatus]);
			//SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
			SetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth] < 250.0 ? CarData[vehicleid][carLastHealth] : 1000.0);
			SetVehicleToRespawn(vehicleid);
		}
	}
	return 1;
}

Server:SQL_LoadOwnedCars(playerid)
{
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_ADM, "HATA: {FFFFFF}Bu araç slotu boþ gözüküyor.");

	new 
		str[20], vehicleid = INVALID_VEHICLE_ID;

	for(new i = 0, j = cache_num_rows(); i < j; i++) if(i < MAX_VEHICLES)
	{
		vehicleid = CreateVehicle(vericek_int(i, "ModelID"),
										vericek_float(i, "PosX"),
										vericek_float(i, "PosY"),
										vericek_float(i, "PosZ"),
										vericek_float(i, "PosA"),
										vericek_int(i, "Color1"),
										vericek_int(i, "Color2"), -1, false);
    	if(vehicleid != INVALID_VEHICLE_ID)
		{
		    Vehicle_DefaultValues(vehicleid);

		    CarData[vehicleid][carExists] = true;
			_has_spawned_vehicleid[playerid] = vehicleid;
			_has_vehicle_spawned[playerid] = true;

	        cache_get_value_name_int(i, "id", CarData[vehicleid][carID]);
			cache_get_value_name_int(i, "ModelID", CarData[vehicleid][carModel]);
			cache_get_value_name_int(i, "OwnerID", CarData[vehicleid][carOwnerID]);
			cache_get_value_name_int(i, "FactionID", CarData[vehicleid][carFaction]);
			
			cache_get_value_name_int(i, "RentalID", CarData[vehicleid][carRental]);
			cache_get_value_name_int(i, "RentalPrice", CarData[vehicleid][carRentalPrice]);
			cache_get_value_name_int(i, "RentedBy", CarData[vehicleid][carRentedBy]);

	    	cache_get_value_name(i, "Plate", CarData[vehicleid][carPlates], 20);
	    	SetVehicleNumberPlate(vehicleid, CarData[vehicleid][carPlates]);

	        cache_get_value_name(i, "VehicleName", CarData[vehicleid][carName], 35);
			cache_get_value_name(i, "CarSign", CarData[vehicleid][carSign], 45);

			cache_get_value_name_float(i, "PosX", CarData[vehicleid][carPos][0]);
			cache_get_value_name_float(i, "PosY", CarData[vehicleid][carPos][1]);
			cache_get_value_name_float(i, "PosZ", CarData[vehicleid][carPos][2]);
			cache_get_value_name_float(i, "PosA", CarData[vehicleid][carPos][3]);

			cache_get_value_name_int(i, "Interior", CarData[vehicleid][carInterior]);
			cache_get_value_name_int(i, "World", CarData[vehicleid][carWorld]);

			cache_get_value_name_int(i, "Color1", CarData[vehicleid][carColor1]);
			cache_get_value_name_int(i, "Color2", CarData[vehicleid][carColor2]);

			cache_get_value_name_int(i, "XMR", bool:CarData[vehicleid][carXMR]);
			cache_get_value_name_int(i, "Siren", bool:CarData[vehicleid][carSiren]);
	    	cache_get_value_name_int(i, "Locked", bool:CarData[vehicleid][carLocked]);

	    	cache_get_value_name_int(i, "Impounded", CarData[vehicleid][carImpounded]);

	    	cache_get_value_name_float(i, "Fuel", CarData[vehicleid][carFuel]);
	    	cache_get_value_name_float(i, "Mileage", CarData[vehicleid][carMileage]);
	    	cache_get_value_name_float(i, "Armour", CarData[vehicleid][carArmour]);
	    	cache_get_value_name_float(i, "EngineLife", CarData[vehicleid][carEngine]);
	    	cache_get_value_name_float(i, "BatteryLife", CarData[vehicleid][carBattery]);

			cache_get_value_name_int(i, "LockLevel", CarData[vehicleid][carLock]);
			cache_get_value_name_int(i, "AlarmLevel", CarData[vehicleid][carAlarm]);
			cache_get_value_name_int(i, "ImmobLevel", CarData[vehicleid][carImmob]);
			
			cache_get_value_name_int(i, "Insurance", CarData[vehicleid][carInsurance]);
			cache_get_value_name_int(i, "InsuranceTime", CarData[vehicleid][carInsuranceTime]);
			cache_get_value_name_int(i, "InsurancePrice", CarData[vehicleid][carInsurancePrice]);
			
			cache_get_value_name_int(i, "TimesDestroyed", CarData[vehicleid][carTimeDestroyed]);
			cache_get_value_name_int(i, "Paintjob", CarData[vehicleid][carPaintjob]);

			if(CarData[vehicleid][carPaintjob] != -1) ChangeVehiclePaintjob(vehicleid, CarData[vehicleid][carPaintjob]);

			for(new m; m < 14; m++) 
			{
				format(str, sizeof(str), "CarMods%i", m+1);
				cache_get_value_name_int(i, str, CarData[vehicleid][carMods][m]);

				if(m < 4)
				{
					format(str, sizeof(str), "CarDoors%i", m+1);
					cache_get_value_name_int(i, str, CarData[vehicleid][carDoors][m]);

					format(str, sizeof(str), "CarWindows%i", m+1);
					cache_get_value_name_int(i, str, CarData[vehicleid][carWindows][m]);
				}
			}

			cache_get_value_name_int(i, "LastDriver", CarData[vehicleid][carlastDriver]);
			cache_get_value_name_int(i, "LastPassenger", CarData[vehicleid][carlastPassenger]);

			cache_get_value_name_float(i, "LastHealth", CarData[vehicleid][carLastHealth]);
			cache_get_value_name_int(i, "Panels", CarData[vehicleid][carPanelStatus]);
			cache_get_value_name_int(i, "Doors", CarData[vehicleid][carDoorsStatus]);
			cache_get_value_name_int(i, "Lights", CarData[vehicleid][carLightsStatus]);
			cache_get_value_name_int(i, "Tires", CarData[vehicleid][carTiresStatus]);

			SetVehicleHealth(vehicleid, CarData[vehicleid][carLastHealth] < 250.0 ? CarData[vehicleid][carLastHealth] : 1000.0);
			ToggleVehicleLock(vehicleid, CarData[vehicleid][carLocked] ? true : false);
			SetVehicleToRespawn(vehicleid);
		}	
	}

	//LogVehicleAction(vehicleid, "Spawn edildi.");

	new query[74];
	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicle_weapons WHERE vehicle_id = %i", CarData[vehicleid][carID]);
	mysql_tquery(m_Handle, query, "SQL_LoadVehicleWeapons", "i", vehicleid);

	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicle_drugs WHERE vehicle_id = %i", CarData[vehicleid][carID]);
	mysql_tquery(m_Handle, query, "SQL_LoadVehicleDrugs", "i", vehicleid);
	
	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM vehicle_fines WHERE vehicle_dbid = %i", CarData[vehicleid][carID]);
	mysql_tquery(m_Handle, query, "LoadVehicleFines", "i", vehicleid);

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "%s isimli araç park edilen noktada spawn oldu.", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Güvenlik: Kilit[%i], Alarm[%i], Immob[%i], Sigorta[%i], KM[%.1f]", CarData[vehicleid][carLock], CarData[vehicleid][carAlarm], CarData[vehicleid][carImmob], CarData[vehicleid][carInsurance], CarData[vehicleid][carMileage]);
	SendClientMessageEx(playerid, COLOR_WHITE, "Araç Ömrü: Motor Ömrü[%.2f], Batarya Ömrü[%.2f], Patlatýldýðý Sayý[%i]", CarData[vehicleid][carEngine], CarData[vehicleid][carBattery], CarData[vehicleid][carTimeDestroyed]);

	SendClientMessage(playerid, COLOR_PINK, "ÝPUCU: Kýrmýzý noktayý takip ederek aracýný bulabilirsin.");
	SetPlayerCheckpoint(playerid, CarData[vehicleid][carPos][0], CarData[vehicleid][carPos][1], CarData[vehicleid][carPos][2], 3.0);
	if(CarData[vehicleid][carImpounded]) SendClientMessage(playerid, COLOR_ADM, "Aracýnýz polisler tarafýndan çekilmiþ gözüküyor.");
	return 1;
}

Server:SQL_LoadVehicleWeapons(vehicleid)
{
	if(cache_num_rows() == 0)
		return print("[Vehicle Trunk] Hic arac bagaji verisi bulunamadi.");

   	for (new i = 0, j = 1; i < cache_num_rows(); i++, j++) if (j < MAX_WEP_SLOT)
	{
	    cache_get_value_name_int(i, "id", vehicle_weap_data[vehicleid][j][data_id]);
	    cache_get_value_name_int(i, "weapon", vehicle_weap_data[vehicleid][j][veh_wep]);
		cache_get_value_name_int(i, "ammo", vehicle_weap_data[vehicleid][j][veh_ammo]);
		cache_get_value_name_int(i, "vehicle_id", vehicle_weap_data[vehicleid][j][veh_id]);
		cache_get_value_name_float(i, "offsetX", vehicle_weap_data[vehicleid][j][wep_offset][0]);
		cache_get_value_name_float(i, "offsetY", vehicle_weap_data[vehicleid][j][wep_offset][1]);
		cache_get_value_name_float(i, "offsetZ", vehicle_weap_data[vehicleid][j][wep_offset][2]);
		cache_get_value_name_float(i, "rotX", vehicle_weap_data[vehicleid][j][wep_offset][3]);
		cache_get_value_name_float(i, "rotY", vehicle_weap_data[vehicleid][j][wep_offset][4]);
		cache_get_value_name_float(i, "rotZ", vehicle_weap_data[vehicleid][j][wep_offset][5]);

		printf("vehicle_weap_data[%i][%i][data_id]: %i", vehicleid, j, vehicle_weap_data[vehicleid][j][veh_wep]);

		if(vehicle_weap_data[vehicleid][j][veh_wep])
		{
		    if(IsValidDynamicObject(vehicle_weap_data[vehicleid][j][temp_object])) DestroyDynamicObject(vehicle_weap_data[vehicleid][j][temp_object]);
		    vehicle_weap_data[vehicleid][j][is_exist] = true;

		    vehicle_weap_data[vehicleid][j][temp_object] = CreateDynamicObject(ReturnWeaponsModel( vehicle_weap_data[vehicleid][j][veh_wep] ), 0, 0, -1000, 0, 0, 0);
		    AttachDynamicObjectToVehicle( vehicle_weap_data[vehicleid][j][temp_object] , vehicleid,
				vehicle_weap_data[vehicleid][j][wep_offset][0],
				vehicle_weap_data[vehicleid][j][wep_offset][1],
				vehicle_weap_data[vehicleid][j][wep_offset][2],
				vehicle_weap_data[vehicleid][j][wep_offset][3],
				vehicle_weap_data[vehicleid][j][wep_offset][4],
				vehicle_weap_data[vehicleid][j][wep_offset][5]
			);
		}
	}
	return 1;
}

Server:SQL_LoadVehicleDrugs(vehicleid)
{
	if(!cache_num_rows()) return 1;

	for (new i = 0, j = 1; i < cache_num_rows(); i++, j++)
    {
        vehicle_drug_data[vehicleid][j][is_exist] = true;
	    cache_get_value_name_int(i, "id", vehicle_drug_data[vehicleid][j][data_id]);
	    cache_get_value_name(i, "drug_name", vehicle_drug_data[vehicleid][j][veh_drug_name], 64);
	   	cache_get_value_name_int(i, "drug_type", vehicle_drug_data[vehicleid][j][veh_drug_id]);
	    cache_get_value_name_float(i, "drug_amount", vehicle_drug_data[vehicleid][j][veh_drug_amount]);
	    cache_get_value_name_int(i, "drug_quality", vehicle_drug_data[vehicleid][j][veh_drug_quality]);
	    cache_get_value_name_int(i, "drug_size", vehicle_drug_data[vehicleid][j][veh_drug_size]);
	    cache_get_value_name_int(i, "vehicle_id", vehicle_drug_data[vehicleid][j][veh_id]);
	}
	return 1;
}

Server:LoadVehicleFines(vehicleid)
{
	if(!cache_num_rows()) return 1;

	for(new i = 0, j = cache_num_rows(); i < j; i ++)
	{
		cache_get_value_name_int(i, "id", VehicleFines[vehicleid][i][fine_id]);
		cache_get_value_name_float(i, "vehicle_x", VehicleFines[vehicleid][i][fine_x]);
		cache_get_value_name_float(i, "vehicle_y", VehicleFines[vehicleid][i][fine_y]);
		cache_get_value_name_float(i, "vehicle_z", VehicleFines[vehicleid][i][fine_z]);
		cache_get_value_name(i, "issuer_name", VehicleFines[vehicleid][i][fine_issuer], 24);
		cache_get_value_name_int(i, "fine_amount", VehicleFines[vehicleid][i][fine_amount]);
		cache_get_value_name_int(i, "fine_faction", VehicleFines[vehicleid][i][fine_faction]);
		cache_get_value_name(i, "fine_reason", VehicleFines[vehicleid][i][fine_reason],  128);
		cache_get_value_name_int(i, "fine_date", VehicleFines[vehicleid][i][fine_date]);
	}
	return 1;
}

Server:SQL_LoadAttachments(playerid)
{
	if(!cache_num_rows())
	{
		return 1;
	}

	new weaponid, index;

	for(new i, j = cache_num_rows(); i < j; ++i)
	{
		cache_get_value_name_int(i, "WeaponID", weaponid); index = weaponid - 22;
		cache_get_value_name_int(i, "BoneID", WeaponSettings[playerid][index][WeaponBone]);
		cache_get_value_name_int(i, "Hidden", bool:WeaponSettings[playerid][index][WeaponHidden]);
		cache_get_value_name_float(i, "PosX", WeaponSettings[playerid][index][WeaponPos][0]);
		cache_get_value_name_float(i, "PosY", WeaponSettings[playerid][index][WeaponPos][1]);
		cache_get_value_name_float(i, "PosZ", WeaponSettings[playerid][index][WeaponPos][2]);
		cache_get_value_name_float(i, "RotX", WeaponSettings[playerid][index][WeaponPos][3]);
		cache_get_value_name_float(i, "RotY", WeaponSettings[playerid][index][WeaponPos][4]);
		cache_get_value_name_float(i, "RotZ", WeaponSettings[playerid][index][WeaponPos][5]);
	}
	return 1;
}