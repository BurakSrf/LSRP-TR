/*
CMD:acikarttirmalar(playerid, params[]) 
{
	new primary_str[756], sub_str[90];
	strcat(primary_str, "Kapý Numarasý\tAdres\tApartman\tGaraj\n");

    for (new i; i < sizeof(Auctions); i++)
    {
    	format(sub_str, sizeof(sub_str), "Auction: %i | Item: %s | Highest Bid: $%i\n", i+1, Auctions[i][BiddingFor], Auctions[i][Bid]);
    	strcat(primary_str, sub_str);
    }

	Dialog_Show(playerid, DIALOG_AUCTIONS, DIALOG_STYLE_TABLIST_HEADERS, "Ev Açýk Arttýrmalarý", szDialog, "Ýncele", "Kapat");
	return 1;
}
*/