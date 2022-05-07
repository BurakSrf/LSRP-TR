enum 	e_market_items 
{
	ItemName[15],
	ItemModelID,
	ItemPrice,
	Float: ItemX,
	Float: ItemY,
	Float: ItemZ,
	Float: ItemA
}

new const MarketData[][e_market_items] =
{
	{"Gas Can", 1650, 500, 0.000000, 0.000000, 35.000000, 0.899999},
	{"Boombox", 2226, 2000, 0.000000, 0.000000, 180.000000, 0.899999},
	{"Beyzbol Sopasi", 336, 1500, 50.000000, 91.000000, 298.000000, 2.099999},
	{"Cicek", 325, 500, 50.000000, 91.000000, 298.000000, 2.099999},
	{"Baston", 326, 200, 50.000000, 91.000000, 298.000000, 1.000000},
	{"Kamera", 367, 500, 52.000000, 231.000000, 102.000000, 1.000000},
	{"Maske", 0, 5000, 50.000000, 91.000000, 298.000000, -1.000000},
	{"Icecek", 19823, 200, 0.000000, 0.000000, 0.000000, 1.000000},
	{"Sigara", 19896, 500, 90.000000, 180.000000, 0.000000, 0.699999},
	{"Radyo", 18875, 0, 0.000000, 0.000000, 180.000000, 0.899999}
};


new PlayerText: Market_Selectable[MAX_PLAYERS][11],
	PlayerText: Market_ProductName[MAX_PLAYERS][11],
	PlayerText: Market_ProductPrice[MAX_PLAYERS][11],
	PlayerText: Market_Textdraw[MAX_PLAYERS][8],
	PlayerText: Market_Extra[MAX_PLAYERS];

// Market_Textdraw[playerid][2] - kapat
// Market_Textdraw[playerid][3] - satýnal
// Market_Textdraw[playerid][4] - temizle
// 6 item name
// 7 açýklamasý

Market_Hide(playerid)
{	
	for(new i; i < sizeof(MarketData); i++)
	{
		if(i < 8)
		{
			if(Market_Textdraw[playerid][i] != PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid, Market_Textdraw[playerid][i]), Market_Textdraw[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}

	    if(Market_Selectable[playerid][i] != PlayerText:INVALID_TEXT_DRAW) 
	    {
			PlayerTextDrawDestroy(playerid, Market_Selectable[playerid][i]);
			PlayerTextDrawDestroy(playerid, Market_ProductName[playerid][i]);
			PlayerTextDrawDestroy(playerid, Market_ProductPrice[playerid][i]);

			Market_Selectable[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
			Market_ProductName[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
			Market_ProductPrice[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	PlayerTextDrawDestroy(playerid, Market_Extra[playerid]);
	Market_Extra[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

Market_Show(playerid)
{
	Market_Hide(playerid);

	Market_Textdraw[playerid][0] = CreatePlayerTextDraw(playerid, 304.000000, 114.000000, "_");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][0], 0.637498, 26.199995);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][0], 310.500000, 350.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][0], 2);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][0], 135);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][0], 0);

	Market_Textdraw[playerid][1] = CreatePlayerTextDraw(playerid, 130.000000, 102.000000, sprintf("%s", BusinessData[ IsPlayerInBusiness(playerid) ][BusinessName]));
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][1], 0);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][1], 0.470833, 1.750000);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][1], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][1], 0);

	Market_Textdraw[playerid][2] = CreatePlayerTextDraw(playerid, 451.000000, 111.000000, "KAPAT");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][2], 0.275000, 1.299998);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][2], 480.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][2], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][2], 1);

	Market_Textdraw[playerid][3] = CreatePlayerTextDraw(playerid, 386.000000, 181.000000, "SATINAL");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][3], 0.254166, 1.350000);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][3], 427.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][3], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][3], 1);

	Market_Textdraw[playerid][4] = CreatePlayerTextDraw(playerid, 435.000000, 181.000000, "TEMIZLE");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][4], 0.254166, 1.350000);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][4], 476.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][4], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][4], 1);

	Market_Textdraw[playerid][5] = CreatePlayerTextDraw(playerid, 311.000000, 121.000000, "_");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][5], 0.320832, 1.599998);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][5], 424.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][5], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][5], 0);

	Market_Textdraw[playerid][6] = CreatePlayerTextDraw(playerid, 315.000000, 137.000000, "Hosgeldin, sepete atmak icin urune ~n~bir kez tikla.~n~~r~Sectigin urunleri SATINAL tusuna basarak elde edebilirsin.");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][6], 0.229166, 1.049998);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][6], 466.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][6], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][6], 0);

	Market_Textdraw[playerid][7] = CreatePlayerTextDraw(playerid, 309.000000, 182.000000, "Hesap ~r~BOS");
	PlayerTextDrawFont(playerid, Market_Textdraw[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, Market_Textdraw[playerid][7], 0.195832, 1.149999);
	PlayerTextDrawTextSize(playerid, Market_Textdraw[playerid][7], 386.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Market_Textdraw[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Market_Textdraw[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, Market_Textdraw[playerid][7], 1);
	PlayerTextDrawColor(playerid, Market_Textdraw[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, Market_Textdraw[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, Market_Textdraw[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, Market_Textdraw[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, Market_Textdraw[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, Market_Textdraw[playerid][7], 0);

	for(new i; i < 10; ++i) 
	{
		if(i < 8) PlayerTextDrawShow(playerid, Market_Textdraw[playerid][i]);

	    PlayerData[playerid][pItemCache][i] = 0;
	}

	new Float: BaseX = 131.000000, 
		Float: BaseY = 124.000000;

		// ust 1 131.000000, 124.000000
		// ust 2 218.000000, 124.000000

		// orta 1 131.000000, 199.000000
		// orta 2 218.000000, 199.000000
		// orta 3 305.000000, 199.000000
		// orta 4 392.000000, 199.000000	

		// alt 1 131.000000, 274.000000
		// alt 2 218.000000, 274.000000
		// alt 3 305.000000, 274.000000
		// alt 4 392.000000, 274.000000

	new Float: BaseNameX = 133.000000,
		Float: BaseNameY = 125.000000;

		// ust1 133.000000, 125.000000
		// ust2 220.000000, 125.000000

	new Float: BasePriceX = 197.000000,
		Float: BasePriceY = 182.000000;

		// ust1 197.000000, 182.000000
		// ust2 282.000000, 182.000000

	new right_tracker = 0, down_tracker = 0, down_row = 0, first_row = 0;

	for(new i; i < sizeof(MarketData); i++)
	{
		switch(first_row)
		{
			case 0, 1: if(right_tracker != 0) BaseX += 87.000000, BaseNameX += 87.000000, BasePriceX += 87.000000, first_row++;
			default: if(right_tracker != 0) BaseX += 87.000000, BaseNameX += 87.000000, BasePriceX += 87.000000;
		}

		if(down_tracker != 0)
		{
			switch(down_row)
			{
				case 0:
				{
					BaseX = 131.000000, BaseY = 199.000000;
					BaseNameX = 133.000000, BaseNameY = 200.000000;
					BasePriceX = 197.000000, BasePriceY = 257.000000;
				}
				case 1:
				{
					BaseX = 131.000000, BaseY = 274.000000;
					BaseNameX = 133.000000, BaseNameY = 275.000000;
					BasePriceX = 197.000000, BasePriceY = 332.000000;
				}
			}

	        down_tracker = 0;
	        down_row++;
		}


		if(i == 6) 
		{
			Market_Extra[playerid] = CreatePlayerTextDraw(playerid, 173.000000, 277.000000, "_");
			PlayerTextDrawFont(playerid, Market_Extra[playerid], 1);
			PlayerTextDrawLetterSize(playerid, Market_Extra[playerid], 0.412499, 7.450006);
			PlayerTextDrawTextSize(playerid, Market_Extra[playerid], 287.000000, 80.000000);
			PlayerTextDrawSetOutline(playerid, Market_Extra[playerid], 1);
			PlayerTextDrawSetShadow(playerid, Market_Extra[playerid], 0);
			PlayerTextDrawAlignment(playerid, Market_Extra[playerid], 2);
			PlayerTextDrawColor(playerid, Market_Extra[playerid], -1);
			PlayerTextDrawBackgroundColor(playerid, Market_Extra[playerid], 255);
			PlayerTextDrawBoxColor(playerid, Market_Extra[playerid], -1378294017);
			PlayerTextDrawUseBox(playerid, Market_Extra[playerid], 1);
			PlayerTextDrawSetProportional(playerid, Market_Extra[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, Market_Extra[playerid], 0);
			PlayerTextDrawShow(playerid, Market_Extra[playerid]);

			Market_Selectable[playerid][i] = CreatePlayerTextDraw(playerid, 174.000000, 293.000000, "_");
			PlayerTextDrawFont(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawLetterSize(playerid, Market_Selectable[playerid][i], 0.275000, 1.450000);
			PlayerTextDrawTextSize(playerid, Market_Selectable[playerid][i], 400.000000, 71.500000);
			PlayerTextDrawSetOutline(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawSetShadow(playerid, Market_Selectable[playerid][i], 0);
			PlayerTextDrawAlignment(playerid, Market_Selectable[playerid][i], 2);
			PlayerTextDrawColor(playerid, Market_Selectable[playerid][i], -1);
			PlayerTextDrawBackgroundColor(playerid, Market_Selectable[playerid][i], 255);
			PlayerTextDrawBoxColor(playerid, Market_Selectable[playerid][i], 50);
			PlayerTextDrawUseBox(playerid, Market_Selectable[playerid][i], 0);
			PlayerTextDrawSetProportional(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawSetSelectable(playerid, Market_Selectable[playerid][i], 1);
			
			new maskId[24];
		    format(maskId, sizeof(maskId), "Maskeli~n~[%i_%i]", PlayerData[playerid][pMaskID], PlayerData[playerid][pMaskIDEx]);
		    PlayerTextDrawSetString(playerid, Market_Selectable[playerid][i], maskId);
		    PlayerTextDrawShow(playerid, Market_Selectable[playerid][i]);
		} 
		else 
		{
			Market_Selectable[playerid][i] = CreatePlayerTextDraw(playerid, BaseX, BaseY, "HUD:radar_burgershot");
			PlayerTextDrawLetterSize(playerid, Market_Selectable[playerid][i], 0.600000, 2.000000);
			PlayerTextDrawTextSize(playerid, Market_Selectable[playerid][i], 84.000000, 72.500000);
			PlayerTextDrawSetOutline(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawSetShadow(playerid, Market_Selectable[playerid][i], 0);
			PlayerTextDrawAlignment(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawColor(playerid, Market_Selectable[playerid][i], -1);
			PlayerTextDrawBackgroundColor(playerid, Market_Selectable[playerid][i], -1378294017);
			PlayerTextDrawBoxColor(playerid, Market_Selectable[playerid][i], 50);
			PlayerTextDrawUseBox(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawSetProportional(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawSetSelectable(playerid, Market_Selectable[playerid][i], 1);
			PlayerTextDrawFont(playerid, Market_Selectable[playerid][i], 5);
			PlayerTextDrawSetPreviewModel(playerid, Market_Selectable[playerid][i], MarketData[i][ItemModelID]);
			PlayerTextDrawSetPreviewRot(playerid, Market_Selectable[playerid][i], MarketData[i][ItemX], MarketData[i][ItemY], MarketData[i][ItemZ], MarketData[i][ItemA]);
			PlayerTextDrawSetPreviewVehCol(playerid, Market_Selectable[playerid][i], 1, 1);
			PlayerTextDrawShow(playerid, Market_Selectable[playerid][i]);

			Market_ProductName[playerid][i] = CreatePlayerTextDraw(playerid, BaseNameX, BaseNameY, sprintf("%s", MarketData[i][ItemName]));
			PlayerTextDrawFont(playerid, Market_ProductName[playerid][i], 1);
			PlayerTextDrawLetterSize(playerid, Market_ProductName[playerid][i], 0.195832, 1.149999);
			PlayerTextDrawTextSize(playerid, Market_ProductName[playerid][i], 386.500000, 17.000000);
			PlayerTextDrawSetOutline(playerid, Market_ProductName[playerid][i], 1);
			PlayerTextDrawSetShadow(playerid, Market_ProductName[playerid][i], 0);
			PlayerTextDrawAlignment(playerid, Market_ProductName[playerid][i], 1);
			PlayerTextDrawColor(playerid, Market_ProductName[playerid][i], -1);
			PlayerTextDrawBackgroundColor(playerid, Market_ProductName[playerid][i], 255);
			PlayerTextDrawBoxColor(playerid, Market_ProductName[playerid][i], 50);
			PlayerTextDrawUseBox(playerid, Market_ProductName[playerid][i], 0);
			PlayerTextDrawSetProportional(playerid, Market_ProductName[playerid][i], 1);
			PlayerTextDrawSetSelectable(playerid, Market_ProductName[playerid][i], 0);
			PlayerTextDrawShow(playerid, Market_ProductName[playerid][i]);
		}


		Market_ProductPrice[playerid][i] = CreatePlayerTextDraw(playerid, BasePriceX, BasePriceY, sprintf("~g~$%i", MarketData[i][ItemPrice]));
		PlayerTextDrawFont(playerid, Market_ProductPrice[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, Market_ProductPrice[playerid][i], 0.233332, 1.349999);
		PlayerTextDrawTextSize(playerid, Market_ProductPrice[playerid][i], 220.500000, 29.500000);
		PlayerTextDrawSetOutline(playerid, Market_ProductPrice[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, Market_ProductPrice[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, Market_ProductPrice[playerid][i], 2);
		PlayerTextDrawColor(playerid, Market_ProductPrice[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, Market_ProductPrice[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, Market_ProductPrice[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, Market_ProductPrice[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, Market_ProductPrice[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, Market_ProductPrice[playerid][i], 0);
		PlayerTextDrawShow(playerid, Market_ProductPrice[playerid][i]);

		right_tracker++;
		if(right_tracker == (first_row < 2 ? 2 : 4)) right_tracker = 0, down_tracker = 1;
	}

	SetPVarInt(playerid, "Viewing_StoreList", 1);
	SetPVarInt(playerid, "PriceCount", 0);
	return 1;
}

Player_PurchaseItem(playerid, type)
{
	switch(type)
	{
	    //case 0: PlayerData[playerid][pGascan]++;
	    case 1: PlayerData[playerid][pHasBoombox] = true;
	    case 2: GivePlayerWeapon(playerid, 5, 1);
	    case 3: GivePlayerWeapon(playerid, 14, 1);
	    case 4: GivePlayerWeapon(playerid, 15, 1);
		case 5: GivePlayerWeapon(playerid, 43, 9999);
		case 6: PlayerData[playerid][pHasMask] = true;
		case 7: PlayerData[playerid][pDrinks]++;
		case 8: PlayerData[playerid][pCigarettes]++;
		case 9: PlayerData[playerid][pHasRadio] = true;
	}
	return 1;
}