#define DEALERSHIP_PER_LINE  	3
#define DEALERSHIP_PER_PAGE		6
#define DEALERSHIP_BASE_X   	79.00
#define DEALERSHIP_BASE_Y   	96.666694

#define DEALERSHIP_NAME_BASE_X 	(140.00)
#define DEALERSHIP_NAME_BASE_Y 	(195.833251)
#define DEALERSHIP_PRICE_BASE_X (140.00)
#define DEALERSHIP_PRICE_BASE_Y (120.00)

new PlayerText: Dealership_Next_Arrow[MAX_PLAYERS],
	PlayerText: Dealership_Prev_Arrow[MAX_PLAYERS],
	PlayerText: Dealership_Model_Cat[MAX_PLAYERS],
	PlayerText: Dealership_Model_Name[MAX_PLAYERS][DEALERSHIP_PER_PAGE],
	PlayerText: Dealership_Model_Price[MAX_PLAYERS][DEALERSHIP_PER_PAGE],
	PlayerText: Dealership_Model[MAX_PLAYERS][DEALERSHIP_PER_PAGE];


new DealershipHolder[MAX_PLAYERS][DEALERSHIP_PER_PAGE];

GetNumberOfPages(id)
{
	if((id >= DEALERSHIP_PER_PAGE) && (id % DEALERSHIP_PER_PAGE) == 0)
	{
		return (id / DEALERSHIP_PER_PAGE);
	}
	else return (id / DEALERSHIP_PER_PAGE) + 1;
}

Dealership_Hide(playerid)
{	
	for(new x = 0; x < DEALERSHIP_PER_PAGE; x++)
	{
	    if(Dealership_Model[playerid][x] != PlayerText:INVALID_TEXT_DRAW) 
	    {
			PlayerTextDrawDestroy(playerid, Dealership_Model[playerid][x]);
			PlayerTextDrawDestroy(playerid, Dealership_Model_Name[playerid][x]);
			PlayerTextDrawDestroy(playerid, Dealership_Model_Price[playerid][x]);

			Dealership_Model[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
			Dealership_Model_Name[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
			Dealership_Model_Price[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	PlayerTextDrawDestroy(playerid, Dealership_Prev_Arrow[playerid]);
   	PlayerTextDrawDestroy(playerid, Dealership_Next_Arrow[playerid]);
   	PlayerTextDrawDestroy(playerid, Dealership_Model_Cat[playerid]);
    Dealership_Prev_Arrow[playerid] = PlayerText:INVALID_TEXT_DRAW;
    Dealership_Next_Arrow[playerid] = PlayerText:INVALID_TEXT_DRAW;
   	Dealership_Model_Cat[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

Dealership_Show(playerid, type = 0)
{
	Dealership_Hide(playerid);

	new Float: BaseX = DEALERSHIP_BASE_X,
		Float: BaseY = DEALERSHIP_BASE_Y,
		Float: BaseNameX = DEALERSHIP_NAME_BASE_X,
		Float: BaseNameY = DEALERSHIP_NAME_BASE_Y,
		Float: BasePriceX = DEALERSHIP_PRICE_BASE_X,
		Float: BasePriceY = DEALERSHIP_PRICE_BASE_Y;

	new right_tracker = 0, left_tracker = 0, nerde_cikacak = 0;

	switch(type)
	{
		case 0:
		{
			new itemat = GetPVarInt(playerid, "dealership_category_page") * DEALERSHIP_PER_PAGE;

			for(new x = 0; x < DEALERSHIP_PER_PAGE && itemat < MAX_DEALERSHIP_CAT; x++)
			{
			    if(right_tracker != 0) 
			    {
			        BaseX += 120.878479;
			        BaseNameX += 120.410034;
				}

				if(left_tracker != 0)
				{
					BaseX = DEALERSHIP_BASE_X;
					BaseNameX = DEALERSHIP_NAME_BASE_X;

			        BaseY = 216.833267;
			        BaseNameY = 316.583343;
			        left_tracker = 0;
				}

				switch(x)
				{
					case 0: nerde_cikacak = 1;
					case 1: nerde_cikacak = 2;
					case 2: nerde_cikacak = 3;
				}

			    Dealership_Model[playerid][x] = CreatePlayerTextDraw(playerid, BaseX, BaseY, "");
			    PlayerTextDrawLetterSize(playerid, Dealership_Model[playerid][x], 0.000000, 0.000000);
			    PlayerTextDrawTextSize(playerid, Dealership_Model[playerid][x], 121.000000, 120.000000);
			    PlayerTextDrawAlignment(playerid, Dealership_Model[playerid][x], 1);
			    PlayerTextDrawColor(playerid, Dealership_Model[playerid][x], -1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawSetOutline(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawBackgroundColor(playerid, Dealership_Model[playerid][x], 0xFF634766);
				PlayerTextDrawFont(playerid, Dealership_Model[playerid][x], TEXT_DRAW_FONT_MODEL_PREVIEW);
				PlayerTextDrawSetProportional(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawSetPreviewModel(playerid, Dealership_Model[playerid][x], DealershipCatData[itemat][CategoryModel]);
				PlayerTextDrawSetPreviewRot(playerid, Dealership_Model[playerid][x], -15.000000, 0.000000, -45.000000, 0.899999);
				PlayerTextDrawSetPreviewVehCol(playerid, Dealership_Model[playerid][x], random(sizeof(VehicleColoursTableRGBA)), random(sizeof(VehicleColoursTableRGBA)));
				PlayerTextDrawSetSelectable(playerid, Dealership_Model[playerid][x], 1);
			    PlayerTextDrawShow(playerid, Dealership_Model[playerid][x]);

		    	Dealership_Model_Name[playerid][x] = CreatePlayerTextDraw(playerid, BaseNameX, BaseNameY, DealershipCatData[itemat][CategoryModelName]);
			    PlayerTextDrawLetterSize(playerid, Dealership_Model_Name[playerid][x], 0.459502, 2.078332);
			    PlayerTextDrawTextSize(playerid, Dealership_Model_Name[playerid][x], 0.000000, 120.000000);
			    PlayerTextDrawAlignment(playerid, Dealership_Model_Name[playerid][x], 2);
			    PlayerTextDrawColor(playerid, Dealership_Model_Name[playerid][x], -1);
			    PlayerTextDrawUseBox(playerid, Dealership_Model_Name[playerid][x], 1);
				PlayerTextDrawBoxColor(playerid, Dealership_Model_Name[playerid][x], 255);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
				PlayerTextDrawSetOutline(playerid, Dealership_Model_Name[playerid][x], 0);
				PlayerTextDrawBackgroundColor(playerid, Dealership_Model_Name[playerid][x], 255);
				PlayerTextDrawFont(playerid, Dealership_Model_Name[playerid][x], 3);
				PlayerTextDrawSetProportional(playerid, Dealership_Model_Name[playerid][x], 1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
			    PlayerTextDrawShow(playerid, Dealership_Model_Name[playerid][x]);

		  		DealershipHolder[playerid][x] = DealershipCatData[itemat][CategoryID];
				right_tracker++;

				if(right_tracker == DEALERSHIP_PER_LINE) 
				{
					right_tracker = 0;
					left_tracker = 1;
				} 
				itemat++;
			}

			SetPVarInt(playerid, "Viewing_DealershipCats", 1);
			SetPVarInt(playerid, "Viewing_Dealership", 0);	
		}
		case 1:
		{
			new itemat = GetPVarInt(playerid, "dealership_page") * DEALERSHIP_PER_PAGE;

			for(new x = 0; x < DEALERSHIP_PER_PAGE && itemat < GetPVarInt(playerid, "dealership_count"); x++)
			{
			    if(right_tracker != 0) 
			    {
			        BaseX += 120.878479;
			        BaseNameX += 120.410034;
			       	BasePriceX += 120.410034;
				}

				if(left_tracker != 0)
				{
					BaseX = DEALERSHIP_BASE_X;
					BaseNameX = DEALERSHIP_NAME_BASE_X;
					BasePriceX = DEALERSHIP_PRICE_BASE_X;

			        BaseY = 216.833267;
			        BaseNameY = 316.583343;
			        BasePriceY = 240.00;
			        left_tracker = 0;
				}

				switch(x)
				{
					case 0: nerde_cikacak = 1;
					case 1: nerde_cikacak = 2;
					case 2: nerde_cikacak = 3;
				}

				Dealership_Model[playerid][x] = CreatePlayerTextDraw(playerid, BaseX, BaseY, "");
			    PlayerTextDrawLetterSize(playerid, Dealership_Model[playerid][x], 0.000000, 0.000000);
			    PlayerTextDrawTextSize(playerid, Dealership_Model[playerid][x], 121.000000, 120.000000);
			    PlayerTextDrawAlignment(playerid, Dealership_Model[playerid][x], 1);
			    PlayerTextDrawColor(playerid, Dealership_Model[playerid][x], -1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawSetOutline(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawBackgroundColor(playerid, Dealership_Model[playerid][x], 0xFF634766);
				PlayerTextDrawFont(playerid, Dealership_Model[playerid][x], TEXT_DRAW_FONT_MODEL_PREVIEW);
				PlayerTextDrawSetProportional(playerid, Dealership_Model[playerid][x], 0);
				PlayerTextDrawSetPreviewModel(playerid, Dealership_Model[playerid][x], DealershipPData[itemat][DealershipModel]);
				PlayerTextDrawSetPreviewRot(playerid, Dealership_Model[playerid][x], -15.000000, 0.000000, -45.000000, 0.899999);
				PlayerTextDrawSetPreviewVehCol(playerid, Dealership_Model[playerid][x], random(sizeof(VehicleColoursTableRGBA)), random(sizeof(VehicleColoursTableRGBA)));
				PlayerTextDrawSetSelectable(playerid, Dealership_Model[playerid][x], 1);
			    PlayerTextDrawShow(playerid, Dealership_Model[playerid][x]);

		    	Dealership_Model_Name[playerid][x] = CreatePlayerTextDraw(playerid, BaseNameX, BaseNameY, sprintf("%s", DealershipPData[itemat][DealershipModelName]));
			    PlayerTextDrawLetterSize(playerid, Dealership_Model_Name[playerid][x], 0.459502, 2.078332);
			    PlayerTextDrawTextSize(playerid, Dealership_Model_Name[playerid][x], 0.000000, 120.000000);
			    PlayerTextDrawAlignment(playerid, Dealership_Model_Name[playerid][x], 2);
			    PlayerTextDrawColor(playerid, Dealership_Model_Name[playerid][x], -1);
			    PlayerTextDrawUseBox(playerid, Dealership_Model_Name[playerid][x], 1);
				PlayerTextDrawBoxColor(playerid, Dealership_Model_Name[playerid][x], 255);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
				PlayerTextDrawSetOutline(playerid, Dealership_Model_Name[playerid][x], 0);
				PlayerTextDrawBackgroundColor(playerid, Dealership_Model_Name[playerid][x], 255);
				PlayerTextDrawFont(playerid, Dealership_Model_Name[playerid][x], 3);
				PlayerTextDrawSetProportional(playerid, Dealership_Model_Name[playerid][x], 1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
			    PlayerTextDrawShow(playerid, Dealership_Model_Name[playerid][x]);

			   	Dealership_Model_Price[playerid][x] = CreatePlayerTextDraw(playerid, BasePriceX, BasePriceY, sprintf("$%s", MoneyFormat(DealershipPData[itemat][DealershipPrice])));
			    PlayerTextDrawLetterSize(playerid, Dealership_Model_Price[playerid][x], 0.459502, 2.078332);
			    PlayerTextDrawTextSize(playerid, Dealership_Model_Price[playerid][x], 0.000000, 120.000000);
			    PlayerTextDrawAlignment(playerid, Dealership_Model_Price[playerid][x], 2);
			    PlayerTextDrawColor(playerid, Dealership_Model_Price[playerid][x], -1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Price[playerid][x], 0);
				PlayerTextDrawSetOutline(playerid, Dealership_Model_Price[playerid][x], 0);
				PlayerTextDrawBackgroundColor(playerid, Dealership_Model_Price[playerid][x], 255);
				PlayerTextDrawFont(playerid, Dealership_Model_Price[playerid][x], 1);
				PlayerTextDrawSetProportional(playerid, Dealership_Model_Price[playerid][x], 1);
				PlayerTextDrawSetShadow(playerid, Dealership_Model_Price[playerid][x], 0);
			    PlayerTextDrawShow(playerid, Dealership_Model_Price[playerid][x]);

		  		DealershipHolder[playerid][x] = DealershipPData[itemat][DealershipModel];
				right_tracker++;

				if(right_tracker == DEALERSHIP_PER_LINE) 
				{
					right_tracker = 0;
					left_tracker = 1;
				} 
				itemat++;
			}

			SetPVarInt(playerid, "Viewing_DealershipCats", 0);
			SetPVarInt(playerid, "Viewing_Dealership", 1);

			Dealership_Model_Cat[playerid] = CreatePlayerTextDraw(playerid, 150.00, 90.0, sprintf("%s", DealershipCatData[DealershipPData[GetPVarInt(playerid, "dealership_page") * DEALERSHIP_PER_PAGE][DealershipCategory]-1][CategoryModelName]));
		    PlayerTextDrawLetterSize(playerid, Dealership_Model_Cat[playerid], 0.459502, 2.078332);
		    PlayerTextDrawTextSize(playerid, Dealership_Model_Cat[playerid], 0.000000, 120.000000);
		    PlayerTextDrawAlignment(playerid, Dealership_Model_Cat[playerid], 2);
		    PlayerTextDrawColor(playerid, Dealership_Model_Cat[playerid], -1);
		    PlayerTextDrawUseBox(playerid, Dealership_Model_Cat[playerid], 1);
			PlayerTextDrawBoxColor(playerid, Dealership_Model_Cat[playerid], 255);
			PlayerTextDrawSetShadow(playerid, Dealership_Model_Cat[playerid], 0);
			PlayerTextDrawSetOutline(playerid, Dealership_Model_Cat[playerid], 0);
			PlayerTextDrawBackgroundColor(playerid, Dealership_Model_Cat[playerid], 255);
			PlayerTextDrawFont(playerid, Dealership_Model_Cat[playerid], 3);
			PlayerTextDrawSetProportional(playerid, Dealership_Model_Cat[playerid], 1);
			PlayerTextDrawSetShadow(playerid, Dealership_Model_Cat[playerid], 0);
		    PlayerTextDrawShow(playerid, Dealership_Model_Cat[playerid]);
		}
	}
	
   	Dealership_Prev_Arrow[playerid] = CreatePlayerTextDraw(playerid, 47.606147, 188.833297, "LD_BEAT:LEFT");
   	PlayerTextDrawLetterSize(playerid, Dealership_Prev_Arrow[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Dealership_Prev_Arrow[playerid], 44.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, Dealership_Prev_Arrow[playerid], 1);
    PlayerTextDrawColor(playerid, Dealership_Prev_Arrow[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Dealership_Prev_Arrow[playerid], 0); 
    PlayerTextDrawSetOutline(playerid, Dealership_Prev_Arrow[playerid], 0);
   	PlayerTextDrawBackgroundColor(playerid, Dealership_Prev_Arrow[playerid], 255);
	PlayerTextDrawSetProportional(playerid, Dealership_Prev_Arrow[playerid], 0);
	PlayerTextDrawFont(playerid, Dealership_Prev_Arrow[playerid], 4);
    PlayerTextDrawSetSelectable(playerid, Dealership_Prev_Arrow[playerid], 1);
    PlayerTextDrawShow(playerid, Dealership_Prev_Arrow[playerid]);

   	Dealership_Next_Arrow[playerid] = CreatePlayerTextDraw(playerid, Dealership_LocateX(nerde_cikacak), 188.833297, "LD_BEAT:RIGHT");
   	PlayerTextDrawLetterSize(playerid, Dealership_Next_Arrow[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Dealership_Next_Arrow[playerid], 44.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, Dealership_Next_Arrow[playerid], 1);
    PlayerTextDrawColor(playerid, Dealership_Next_Arrow[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Dealership_Next_Arrow[playerid], 0); 
    PlayerTextDrawSetOutline(playerid, Dealership_Next_Arrow[playerid], 0);
   	PlayerTextDrawBackgroundColor(playerid, Dealership_Next_Arrow[playerid], 255);
	PlayerTextDrawSetProportional(playerid, Dealership_Next_Arrow[playerid], 0);
	PlayerTextDrawFont(playerid, Dealership_Next_Arrow[playerid], 4);
    PlayerTextDrawSetSelectable(playerid, Dealership_Next_Arrow[playerid], 1);
    PlayerTextDrawShow(playerid, Dealership_Next_Arrow[playerid]);
    return 1;
}

Dealership_LocateX(id)
{
	new position;
	switch(id)
	{
		case 1: position = 192;
		case 2: position = 310;
		default: position = 431;
	}
	return position;
}

HandlePlayerItemSelection(playerid, selecteditem)
{
	Dealership_Hide(playerid);

	new
		query[200];

	mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM dealerships WHERE VehicleCategory = %i", selecteditem);
	new Cache:cache = mysql_query(m_Handle, query);

	for(new i = 0, j = cache_num_rows(); i < j; i++)
	{
		cache_get_value_name_int(i, "id", DealershipPData[i][DealershipID]);
		cache_get_value_name_int(i, "VehicleCategory", DealershipPData[i][DealershipCategory]);
		cache_get_value_name(i, "VehicleName", DealershipPData[i][DealershipModelName], 45);
		cache_get_value_name_int(i, "VehicleModel", DealershipPData[i][DealershipModel]);
		cache_get_value_name_int(i, "VehiclePrice", DealershipPData[i][DealershipPrice]);
		cache_get_value_name_int(i, "VehicleEnabled", DealershipPData[i][DealershipIsEnabled]);
	}

    SetPVarInt(playerid, "dealership_count", cache_num_rows());
	SetPVarInt(playerid, "dealership_page", 0);

    Dealership_Show(playerid, 1);
    SelectTextDraw(playerid, COLOR_DARKGREEN);
    cache_delete(cache);
    return 1;
}

PlayerVehicles_Hide(playerid)
{	
	for(new x = 0; x < DEALERSHIP_PER_PAGE; x++)
	{
	    if(Dealership_Model[playerid][x] != PlayerText:INVALID_TEXT_DRAW) 
	    {
			PlayerTextDrawDestroy(playerid, Dealership_Model[playerid][x]);
			PlayerTextDrawDestroy(playerid, Dealership_Model_Name[playerid][x]);

			Dealership_Model[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
			Dealership_Model_Name[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	PlayerTextDrawDestroy(playerid, Dealership_Prev_Arrow[playerid]);
   	PlayerTextDrawDestroy(playerid, Dealership_Next_Arrow[playerid]);
    Dealership_Prev_Arrow[playerid] = PlayerText:INVALID_TEXT_DRAW;
    Dealership_Next_Arrow[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

PlayerVehicles_Show(playerid)
{
	PlayerVehicles_Hide(playerid);

	new Float: BaseX = DEALERSHIP_BASE_X,
		Float: BaseY = DEALERSHIP_BASE_Y,
		Float: BaseNameX = DEALERSHIP_NAME_BASE_X,
		Float: BaseNameY = DEALERSHIP_NAME_BASE_Y;

	new right_tracker = 0, left_tracker = 0, nerde_cikacak = 0;
	new itemat = GetPVarInt(playerid, "playervehicles_page") * DEALERSHIP_PER_PAGE;

	for(new x = 0; x < DEALERSHIP_PER_PAGE && itemat < GetPVarInt(playerid, "playervehicles_count"); x++)
	{
	    if(right_tracker != 0) 
	    {
	        BaseX += 120.878479;
	        BaseNameX += 120.410034;
		}

		if(left_tracker != 0)
		{
			BaseX = DEALERSHIP_BASE_X;
			BaseNameX = DEALERSHIP_NAME_BASE_X;

	        BaseY = 216.833267;
	        BaseNameY = 316.583343;
	        left_tracker = 0;
		}

		switch(x)
		{
			case 0: nerde_cikacak = 1;
			case 1: nerde_cikacak = 2;
			case 2: nerde_cikacak = 3;
		}

	    Dealership_Model[playerid][x] = CreatePlayerTextDraw(playerid, BaseX, BaseY, "");
	    PlayerTextDrawLetterSize(playerid, Dealership_Model[playerid][x], 0.000000, 0.000000);
	    PlayerTextDrawTextSize(playerid, Dealership_Model[playerid][x], 121.000000, 120.000000);
	    PlayerTextDrawAlignment(playerid, Dealership_Model[playerid][x], 1);
	    PlayerTextDrawColor(playerid, Dealership_Model[playerid][x], -1);
		PlayerTextDrawSetShadow(playerid, Dealership_Model[playerid][x], 0);
		PlayerTextDrawSetOutline(playerid, Dealership_Model[playerid][x], 0);
		PlayerTextDrawBackgroundColor(playerid, Dealership_Model[playerid][x], 0xFF634766);
		PlayerTextDrawFont(playerid, Dealership_Model[playerid][x], TEXT_DRAW_FONT_MODEL_PREVIEW);
		PlayerTextDrawSetProportional(playerid, Dealership_Model[playerid][x], 0);
		PlayerTextDrawSetPreviewModel(playerid, Dealership_Model[playerid][x], PlayerVehicles_GetInt(playerid, "ModelID", itemat+1));
		PlayerTextDrawSetPreviewRot(playerid, Dealership_Model[playerid][x], -15.000000, 0.000000, -45.000000, 0.899999);
		PlayerTextDrawSetPreviewVehCol(playerid, Dealership_Model[playerid][x], PlayerVehicles_GetInt(playerid, "Color1", itemat+1), PlayerVehicles_GetInt(playerid, "Color2", itemat+1));
		PlayerTextDrawSetSelectable(playerid, Dealership_Model[playerid][x], 1);
	    PlayerTextDrawShow(playerid, Dealership_Model[playerid][x]);

    	Dealership_Model_Name[playerid][x] = CreatePlayerTextDraw(playerid, BaseNameX, BaseNameY, PlayerVehicles_GetVarchar(playerid, "VehicleName", itemat+1));
	    PlayerTextDrawLetterSize(playerid, Dealership_Model_Name[playerid][x], 0.459502, 2.078332);
	    PlayerTextDrawTextSize(playerid, Dealership_Model_Name[playerid][x], 0.000000, 120.000000);
	    PlayerTextDrawAlignment(playerid, Dealership_Model_Name[playerid][x], 2);
	    PlayerTextDrawColor(playerid, Dealership_Model_Name[playerid][x], -1);
	    PlayerTextDrawUseBox(playerid, Dealership_Model_Name[playerid][x], 1);
		PlayerTextDrawBoxColor(playerid, Dealership_Model_Name[playerid][x], 255);
		PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
		PlayerTextDrawSetOutline(playerid, Dealership_Model_Name[playerid][x], 0);
		PlayerTextDrawBackgroundColor(playerid, Dealership_Model_Name[playerid][x], 255);
		PlayerTextDrawFont(playerid, Dealership_Model_Name[playerid][x], 3);
		PlayerTextDrawSetProportional(playerid, Dealership_Model_Name[playerid][x], 1);
		PlayerTextDrawSetShadow(playerid, Dealership_Model_Name[playerid][x], 0);
	    PlayerTextDrawShow(playerid, Dealership_Model_Name[playerid][x]);

  		DealershipHolder[playerid][x] = itemat+1;
		right_tracker++;

		if(right_tracker == DEALERSHIP_PER_LINE) 
		{
			right_tracker = 0;
			left_tracker = 1;
		} 
		itemat++;
	}

	SetPVarInt(playerid, "Viewing_OwnedCarList", 1);
	
   	Dealership_Prev_Arrow[playerid] = CreatePlayerTextDraw(playerid, 47.606147, 188.833297, "LD_BEAT:LEFT");
   	PlayerTextDrawLetterSize(playerid, Dealership_Prev_Arrow[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Dealership_Prev_Arrow[playerid], 44.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, Dealership_Prev_Arrow[playerid], 1);
    PlayerTextDrawColor(playerid, Dealership_Prev_Arrow[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Dealership_Prev_Arrow[playerid], 0); 
    PlayerTextDrawSetOutline(playerid, Dealership_Prev_Arrow[playerid], 0);
   	PlayerTextDrawBackgroundColor(playerid, Dealership_Prev_Arrow[playerid], 255);
	PlayerTextDrawSetProportional(playerid, Dealership_Prev_Arrow[playerid], 0);
	PlayerTextDrawFont(playerid, Dealership_Prev_Arrow[playerid], 4);
    PlayerTextDrawSetSelectable(playerid, Dealership_Prev_Arrow[playerid], 1);
    PlayerTextDrawShow(playerid, Dealership_Prev_Arrow[playerid]);

   	Dealership_Next_Arrow[playerid] = CreatePlayerTextDraw(playerid, Dealership_LocateX(nerde_cikacak), 188.833297, "LD_BEAT:RIGHT");
   	PlayerTextDrawLetterSize(playerid, Dealership_Next_Arrow[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Dealership_Next_Arrow[playerid], 44.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, Dealership_Next_Arrow[playerid], 1);
    PlayerTextDrawColor(playerid, Dealership_Next_Arrow[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Dealership_Next_Arrow[playerid], 0); 
    PlayerTextDrawSetOutline(playerid, Dealership_Next_Arrow[playerid], 0);
   	PlayerTextDrawBackgroundColor(playerid, Dealership_Next_Arrow[playerid], 255);
	PlayerTextDrawSetProportional(playerid, Dealership_Next_Arrow[playerid], 0);
	PlayerTextDrawFont(playerid, Dealership_Next_Arrow[playerid], 4);
    PlayerTextDrawSetSelectable(playerid, Dealership_Next_Arrow[playerid], 1);
    PlayerTextDrawShow(playerid, Dealership_Next_Arrow[playerid]);
    return 1;
}

PlayerVehicles_GetInt(playerid, column[], index)
{
	new query[64], sonuc;
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM vehicles WHERE id = %i", column, PlayerData[playerid][pOwnedCar][index]);
	new Cache:cache = mysql_query(m_Handle, query);
	cache_get_value_index_int(0, 0, sonuc);
	cache_delete(cache);
	return sonuc;
}

PlayerVehicles_GetVarchar(playerid, column[], index)
{
	new query[84], sonuc[24];
	mysql_format(m_Handle, query, sizeof(query), "SELECT %s FROM vehicles WHERE id = %i", column, PlayerData[playerid][pOwnedCar][index]);
	new Cache:cache = mysql_query(m_Handle, query);
	cache_get_value_index(0, 0, sonuc);
	cache_delete(cache);
	return sonuc;
}