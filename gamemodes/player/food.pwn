Food_Type(id)
{
	new 
		str[21];

	switch(id)
	{
	    case TYPE_PIZZA: str = "The_Well_Pizza_Stack";
	    case TYPE_BURGER: str = "Cluckin_Bell";
	    case TYPE_CHICKEN: str = "Burger_King";
	    case TYPE_DONUT: str = "Donut";
	    default: str = "Unknown";
	}
	return str;
}

Restaurant_Type(id)
{
	new 
		str[21];

	switch(id)
	{
	    case TYPE_PIZZA: str = "Pizza Restaurant";
	    case TYPE_BURGER: str = "Burger Fast-Food";
	    case TYPE_CHICKEN: str = "Chicken Fast-Food";
	    case TYPE_DONUT: str = "Donut Fast-Food";
	    default: str = "Unknown";
	}
	return str;
}

Food_Menu(playerid, bool:toggle = true)
{
	if(toggle == true)
	{
		new
		    id = IsPlayerInBusiness(playerid);

		new str[512];

	    format(str, sizeof(str), "%s", Food_Type(FoodData[ BusinessData[id][BusinessFood][0] ][FoodType]));
	    PlayerTextDrawSetString(playerid, FoodOrder[playerid][1], str);

	    for(new i = 0; i < 3; i++) 
	    {
			format(str, sizeof(str), "~r~Saglik:_+%d~n~~b~Ucret:_$%d", floatround(FoodData[ BusinessData[id][BusinessFood][i] ][FoodHealth]), BusinessData[id][BusinessFoodPrice][i] ? BusinessData[id][BusinessFoodPrice][i] : FoodData[ BusinessData[id][BusinessFood][i] ][FoodPrice]);
			PlayerTextDrawSetString(playerid, FoodOrder[playerid][i+10], str);
	   
			format(str, sizeof(str), "%s", FoodData[ BusinessData[id][BusinessFood][i] ][FoodName]);
			PlayerTextDrawSetString(playerid, FoodOrder[playerid][i+7], str);
	    }

		PlayerTextDrawSetPreviewModel(playerid, FoodOrder[playerid][4], FoodData[ BusinessData[id][BusinessFood][0] ][FoodModel]);
		PlayerTextDrawSetPreviewModel(playerid, FoodOrder[playerid][5], FoodData[ BusinessData[id][BusinessFood][1] ][FoodModel]);
		PlayerTextDrawSetPreviewModel(playerid, FoodOrder[playerid][6], FoodData[ BusinessData[id][BusinessFood][2] ][FoodModel]);
	    SelectTextDraw(playerid, COLOR_GREY);

		for(new i = 0; i < 13; i++) PlayerTextDrawShow(playerid, FoodOrder[playerid][i]);
		SetPVarInt(playerid, "Viewing_FoodList", 1);
	}
	else
	{
		CancelSelectTextDraw(playerid);
		for(new i = 0; i < 13; i++) PlayerTextDrawHide(playerid, FoodOrder[playerid][i]);
		SetPVarInt(playerid, "Viewing_FoodList", 0);
	}
	return 1;
}

Meal_Drop(id)
{
	MealData[id][MealPlayerID] = -1;
	DestroyDynamicObject(MealData[id][MealObjectID]);
	MealData[id][MealModelID] = MealData[id][MealObjectID] = -1;
	MealData[id][MealPos][0] = MealData[id][MealPos][1] = MealData[id][MealPos][2] = 0.0;
	MealData[id][MealInterior] = MealData[id][MealWorld] = 0;
	MealData[id][MealEditing] = false;
	Iter_SafeRemove(Meals, id, id);
	return 1;
}

Meal_FreeID()
{
	if(Iter_Count(Meals) >= MAX_MEALS) foreach(new j : Meals) if(MealData[j][MealPlayerID] == -1)
 	{
 		Meal_Drop(j); 
 		return j;
	}

	return Iter_Free(Meals);
}

GetNearestMeal(playerid)
{
    new mealid = PlayerData[playerid][pCarryMeal];
	if(mealid != -1) return PlayerData[playerid][pCarryMeal];

    foreach(new i : Meals) if(IsPlayerInRangeOfPoint(playerid, 2.5, MealData[i][MealPos][0], MealData[i][MealPos][1], MealData[i][MealPos][2]) && GetPlayerInterior(playerid) == MealData[i][MealInterior] && GetPlayerVirtualWorld(playerid) == MealData[i][MealWorld])
	{
		if(MealData[i][MealPlayerID] == -1) return i;
	}
	return -1;
}

OnPlayerFoodPurchase(playerid, food_id)
{
	new id = Meal_FreeID();
	if(id == -1) return SendErrorMessage(playerid, "Þu anda sýra gözüküyor, biraz bekleteceðim.");

	new Float: health;
	GetPlayerHealth(playerid, health);
	health += FoodData[food_id][FoodHealth];
	SetPlayerHealth(playerid, (health > 100) ? 100.0 : health);
	SetPlayerAttachedObject(playerid, SLOT_MEAL, FoodData[food_id][FoodModel], 1, 0.004999, 0.529999, 0.126999, -83.200004, 115.999961, -31.799890);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	MealData[id][MealModelID] = FoodData[food_id][FoodModel];
	MealData[id][MealPlayerID] = playerid;
	PlayerData[playerid][pCarryMeal] = id;

	SendClientMessage(playerid, COLOR_ADM, "ÝPUCU: Yemeðini /tepsi at komutuyla býrakabilirsin.");
	Iter_Add(Meals, id);
	return 1;
}

Food_Config(playerid)
{
	static id = -1;
	if((id = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir iþyeri içerisinde deðilsin.");
	if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu iþyerine sahip deðilsin.");
	if(BusinessData[id][BusinessType] != BUSINESS_RESTAURANT) return SendErrorMessage(playerid, "Bu iþyeri restaurant deðil.");

	new primary[512], sub[90];
	format(sub, sizeof(sub), "Restaurant Tipi {C3C3C3}[%s]{FFFFFF}\n", Restaurant_Type(BusinessData[id][BusinessRestaurantType]));
	strcat(primary, sub);

	format(sub, sizeof(sub), "1. Ürün {C3C3C3}[%s, $%d]{FFFFFF}\n", FoodData[ BusinessData[id][BusinessFood][0] ][FoodName], BusinessData[id][BusinessFoodPrice][0]);
	strcat(primary, sub);

	format(sub, sizeof(sub), "2. Ürün {C3C3C3}[%s, $%d]{FFFFFF}\n", FoodData[ BusinessData[id][BusinessFood][1] ][FoodName], BusinessData[id][BusinessFoodPrice][1]);
	strcat(primary, sub);

	format(sub, sizeof(sub), "3. Ürün {C3C3C3}[%s, $%d]{FFFFFF}\n", FoodData[ BusinessData[id][BusinessFood][2] ][FoodName], BusinessData[id][BusinessFoodPrice][2]);
	strcat(primary, sub);

	ShowPlayerDialog(playerid, DIALOG_FOOD_CONFIG, DIALOG_STYLE_LIST, "Restaurant: Yönetim Paneli", primary, "Tamam", "Kapat <<<");
	return 1;
}