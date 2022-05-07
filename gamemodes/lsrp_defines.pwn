#define REVISION "LS-RP 2.0.0"

#define BLOCK_NONE 0
#define LESS_DAMAGE_FIST 1
#define BLOCK_FIST 2
#define LESS_DAMAGE_MELEE 3
#define BLOCK_PHYSICAL 4

#define KEY_AIM 132

#define SLOT_HANDCUFF 6
#define SLOT_PHONE 7
#define SLOT_MEAL 8
#define SLOT_MISC 9

new taxi_vehicles[3],
	dmv_vehicles[4]; 

#if !defined IsNaN
    #define IsNaN(%0) ((%0) != (%0))
#endif

#define SPECTATE_TYPE_PLAYER 0
#define SPECTATE_TYPE_VEHICLE 1


new oc_ws[MAX_PLAYERS];
new blacklisted_weaps[4] = {35, 36, 37, 38};

new CCTVID[MAX_PLAYERS],
	SpectateID[MAX_PLAYERS],
 	SpectateType[MAX_PLAYERS];

new Iterator:SpectatePlayers<MAX_PLAYERS>;

native WP_Hash(buffer[], len, const str[]);
native gpci(playerid, serial[], len);
native IsValidVehicle(vehicleid);

forward Float: GetVehicleCondition(vehid, type);

Float:vericek_float(row, const field_name[])
{
	new Float:str;
	cache_get_value_name_float(row, field_name, str);
	return str;
}

vericek_int(row, const field_name[])
{
    new str;
    cache_get_value_name_int(row, field_name, str);
    return str;
}

#define randomEx(%1,%2) (random(%2-%1)+%1)
#define Server:%0(%1) forward %0(%1); public %0(%1)
#define SendErrorMessage(%0,%1) SendClientMessageEx(%0, COLOR_ADM, "HATA: "%1)
#define SendServerMessage(%0,%1) SendClientMessageEx(%0, COLOR_RED, "SERVER: "%1)
#define SendInfoMessage(%0,%1) SendClientMessageEx(%0, COLOR_RED, "BÝLGÝ:{FFFFFF} "%1)
#define SendUsageMessage(%0,%1) SendClientMessageEx(%0, COLOR_RED, "KULLANIM:{FFFFFF} "%1)

#define	BIRLIK_BASLIK 		"{3498DB}Birlik: {FFFFFF}"

#define MAX_CLOTHING_SHOW (25)

//Keys:
#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// 987.5984 -1252.2427 16.9844
#define MECHANIC_COMP_PRICE (30)
#define MECHANIC_POS_X 		(93.1775)
#define MECHANIC_POS_Y 		(-164.7851)
#define MECHANIC_POS_Z 		(2.5938)
#define MECHANIC_POS_RANGE  (3.0)
#define MECHANIC_PICKUP_ID  (1239)
#define MECHANIC_LABEL_TEXT "[Mekanik Mesleði]\n/meslek mekanik"

#define TRASH_PRICE 	(5)
#define TRASH_X 		(2573.7185)
#define TRASH_Y 		(-2222.4182)
#define TRASH_Z 		(13.3316)
#define TRASH_RANGE  	(3.0)
#define TRASH_PICKUPS  	(1239)
#define TRASH_TEXT "[Çöpçülük]\n/cop sat"

// 2430.4795 -2512.8518 13.6562
#define MECHANIC_COMP_POS_X 		(2430.4795)
#define MECHANIC_COMP_POS_Y 		(-2512.8518)
#define MECHANIC_COMP_POS_Z 		(13.6562)
#define MECHANIC_COMP_POS_RANGE  	(3.0)
#define MECHANIC_COMP_PICKUP_ID  	(1239)
#define MECHANIC_COMP_LABEL_TEXT 	"[Mekanik Mesleði]\n/parcaal"

#define EXTERIOR_TUNING_X 				(418.0252)
#define EXTERIOR_TUNING_Y 				(-1324.3462)
#define EXTERIOR_TUNING_Z 				(14.9415)

#define INTERIOR_TUNING_X 				(434.0549)
#define INTERIOR_TUNING_Y 				(-1299.4264)
#define INTERIOR_TUNING_Z 				(15.3104)

#define DEFAULT_TEXTURE (1000)
#define DEFAULT_SKIN (264)
#define MDC_ERROR	(21001)
#define MDC_SELECT	(21000)
#define MDC_OPEN	(45400)

#define DOTS_ADD                (3)
#define MAX_VLOG_PER_PAGE (20)
#define MAX_PLOG_PER_PAGE (21)
#define MAX_PLAYER_PER_PAGE (10)

// Max defines:
#define MAX_ENTRANCES (60)
#define MAX_FACTIONS (30)
#define MAX_CCTVS (50)
#define MAX_FACTION_RANKS (21)
#define MAX_PROPERTY_ADDRESS  (70)
#define MAX_PROPERTY (500)
#define MAX_BUSINESS (300)
#define MAX_ATM_MACHINES (50)
#define MAX_IMPOUND_LOTS (20)
#define MAX_PAYNSPRAY (9)
#define MAX_SIKICILER (35)
#define MAX_OWNED_CARS (10)
#define MAX_TOLLS (9)
#define MAX_CHOPSHOP (15)
#define MAX_DAMAGES (100)
#define MAX_DROP_ITEMS (200)
#define MAX_GATES (100)
#define MAX_ANTENNAS (70)
#define MAX_SERVER_OBJECTS (100)
#define MAX_SERVER_PICKUPS (100)
#define MAX_MEALS (55)
#define MAX_DOORS (200)
#define MAX_PLAYER_NOTES (5)
#define MAX_APBS (25)
#define MAX_REPORTS (200)
#define MAX_SUPPORTS (200)
#define MAX_STREETS (276)
#define MAX_DEALERSHIP_CAT (15)
#define MAX_DEALERSHIPS (129)
#define MAX_PLAYER_CONTACTS (15)
#define MAX_GARAGES (150)
#define MAX_XMR_CATEGORIES (40)
#define MAX_XMR_SUBCATEGORY (100)
#define MAX_ADMIN_NOTES (6)
#define MAX_CLOTHING_ITEMS (15)
#define MAX_PROPERTY_DRUGS (21)
#define MAX_COMMAND_LOG (21)
#define MAX_CHAT_LOG (21)
#define MAX_BOOMBOXS (30)
#define MAX_ROADBLOCKS (200)
#define MAX_FINES  (30)
#define MAX_GARBAGE_BINS (425)
#define MAX_FIRES (30)
#define MAX_LABELS (30)
#define MAX_DOSIGN (60)
#define MAX_ADVERTS (10)
#define MAX_TELEPORTS (50)
#define MAX_SPRAYS (50)
#define MAX_BILLBOARDS (50)

#define MAX_TRUCK_CARGO (70)
#define MAX_TRUCK_PACK (26)
#define MAX_CARGO_OBJ (100)
#define MAX_TRUCK_PRODUCT (26)

#define TRUCKER_FUEL 		0 //Vehicle
#define TRUCKER_FOOD		1
#define TRUCKER_DRINK 		2
#define TRUCKER_CLOTHES 	3
#define TRUCKER_CARS 		4 //Vehicle
#define TRUCKER_FURNITURE   5
#define TRUCKER_MEAT        6
#define TRUCKER_EGGS        7
#define TRUCKER_MILK 		8 //Vehicle
#define TRUCKER_CEREAL      9 //Vehicle
#define TRUCKER_COTTON      10 //Vehicle
#define TRUCKER_DYES        11 //Vehicle
#define TRUCKER_COMPONENTS  12
#define TRUCKER_MALT        13 //Vehicle
#define TRUCKER_MONEY       14
#define TRUCKER_PAPER       15
#define TRUCKER_AGGREGATE   16 //Vehicle
#define TRUCKER_WOODS	 	17 //Vehicle
#define TRUCKER_GUNPOWDER   18
#define TRUCKER_SCRAP       19 //Vehicle
#define TRUCKER_STEEL       20
#define TRUCKER_GUNS        21
#define TRUCKER_BRICKS 		22 //Vehicle
#define TRUCKER_APPLIANCES  23
#define TRUCKER_FRUITS      24
#define TRUCKER_TRANSFORMS	25

//Numbers:
#define TAXI_NUMBER (544)
#define MECHANIC_NUMBER (556)

//Player states:
#define STATE_ALIVE (1)
#define STATE_WOUNDED (2)
#define STATE_DEAD (3)

//Body parts:
#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

//Object bones:
#define OBJECT_BONE_SPINE (1)
#define OBJECT_BONE_HEAD (2)
#define OBJECT_BONE_LUPPER_A (3)
#define OBJECT_BONE_RUPPER_A (4)
#define OBJECT_BONE_LHAND (5)
#define OBJECT_BONE_RHAND (6)
#define OBJECT_BONE_LTHIGH (7)
#define OBJECT_BONE_RTHIGH (8)
#define OBJECT_BONE_LFOOT (9)
#define OBJECT_BONE_RFOOT (10)

//Property types:
#define PROPERTY_COMPLEX (1)
#define PROPERTY_APARTMENT (2)
#define PROPERTY_HOUSE (3)

//Jobs:
#define MECHANIC_JOB (1)
#define TAXI_JOB (2)
#define TRUCKER_JOB (3)

//LS Telefonica pages:
#define PAGE_NONE (-1)
#define PAGE_HOME (0)
#define PAGE_MENU (1)
#define PAGE_NOTEBOOK (2)
#define PAGE_CONTACT (3)
#define PAGE_SETTING (4)
#define PAGE_RINGTONE (5)
#define PAGE_PHONECOLOR (6)
#define PAGE_PHONEMODE (7)
#define PAGE_USERS (8)

//LS Telefonica colors:
#define PHONE_TYPE_BLACK 	(0) // 18868
#define PHONE_TYPE_GREY  	(1) // 18874
#define PHONE_TYPE_RED   	(2) // 18870
#define PHONE_TYPE_YELLOW 	(3) // 18873
#define PHONE_TYPE_BLUE		(4) // 18866
#define PHONE_TYPE_GREEN	(4) // 18871
#define PHONE_TYPE_ORANGE	(5) // 18865
#define PHONE_TYPE_PINK		(6) // 18869

//Spawn points:
#define SPAWN_POINT_AIRPORT (0)
#define SPAWN_POINT_PROPERTY (1)
#define SPAWN_POINT_RENTING (2)
#define SPAWN_POINT_FACTION (3)

//Drug types:
#define DRUG_TYPE_MARIJUANA (1)
#define DRUG_TYPE_CRACK (2)
#define DRUG_TYPE_COCAINE (3)
#define DRUG_TYPE_ECSTASY (4)
#define DRUG_TYPE_LSD (5)
#define DRUG_TYPE_METH (6)
#define DRUG_TYPE_PCP (7)
#define DRUG_TYPE_HEROIN (8)
#define DRUG_TYPE_ASPIRIN (9)
#define DRUG_TYPE_HALOP (10)
#define DRUG_TYPE_MORPHINE (11)
#define DRUG_TYPE_XANAX (12)
#define DRUG_TYPE_MDMA (13)
#define DRUG_TYPE_PHENETOLE (14)
#define DRUG_TYPE_STEROIDS (15)
#define DRUG_TYPE_MESCALIN (16)
#define DRUG_TYPE_QUAALUDES (17)
#define DRUG_TYPE_PEYOTE (18)

//Fuel
#define FUEL_TYPE_PETROL (1)
#define FUEL_TYPE_DIESEL (2)
#define FUEL_TYPE_ELECTRIC (3)

//Colors:
#define COLOR_WHITE 	(0xFFFFFFFF)
#define COLOR_ADM   	(0xFF6347FF)
#define COLOR_GREY 		(0xAFAFAFFF)
#define COLOR_DARKGREEN (0x33AA33FF)
#define COLOR_TAXIDUTY	(0xFBA16CFF)
#define COLOR_YELLOW	(0xFFFF00FF)
#define COLOR_EMOTE		(0xC2A2DAFF)
#define COLOR_PMREC		(0xFFDC18FF)
#define COLOR_PMSEN		(0xEEE854FF)
#define COLOR_ORANGE	(0xFF9900AA)
#define COLOR_ADMIN		(0x587B95FF)
#define COLOR_FADE1 	(0xE6E6E6E6)
#define COLOR_FADE2 	(0xC8C8C8C8)
#define COLOR_FADE3 	(0xAAAAAAAA)
#define COLOR_FADE4 	(0x8C8C8C8C)
#define COLOR_FADE5 	(0x6E6E6E6E)
#define COLOR_SAMP		(0xADC3E7FF)
#define COLOR_RED		(0xFF6347FF)
#define COLOR_DARKRED 	(0xa71010FF)
#define COLOR_RADIO		(0xFFEC8BFF)
#define COLOR_SPLX      (0xB6AA96FF)
#define COLOR_RADIOEX	(0xB5AF8FFF)
#define COLOR_GRAD1		(0xCCE6E6FF)
#define COLOR_GRAD2		(0xE2FFFFFF)
#define COLOR_BLUE		(0x33CCFFFF)
#define COLOR_TESTER 	(0xA52A2AFF)
#define COLOR_COP		(0x8D8DFFFF)
#define COLOR_PINK		(0xFF00FFFF)
#define COLOR_DEPT		(0xF07A7AFF)
#define COLOR_TEXTDRAW	(0xAC7A32FF)
#define COLOR_EMT		(0xFF8282FF)
#define COLOR_STATS		(0x85A82BFF)
#define COLOR_ACTION	(0xF8E687FF)
#define COLOR_CYAN		(0x33CCFFFF)
//#define COLOR_NINER		(0x55C4D9FF)
#define COLOR_NINER		(0x31B9F9FF)
#define COLOR_GOLD 		(0xFFD700FF)
#define COLOR_REPORT 	(0xFFFF91FF)
#define COLOR_LGREEN    (0x33FF33AA)
#define COLOR_SADOC		(0x554273FF)
#define COLOR_SOFTPINK  (0xffC0B0FF)

enum
{
    DIALOG_NONE,
    DIALOG_DEFAULT,
	DIALOG_CONFIRM_SYS,
	DIALOG_USE,

	DIALOG_RACE,
	DIALOG_REMOVE_COMP,

	DIALOG_SPRAY_MAIN,
	DIALOG_SPRAY_IMAGE,
	DIALOG_SPRAY_INPUT,
	DIALOG_SPRAY_FONT,
	DIALOG_SPRAY_CREATE,

	DIALOG_VEHICLE_WEAPONS,
	
	DIALOG_TP_LIST,
	
	DIALOG_INTERIORS,


	DIALOG_DEALERSHIP_APPEND,
	DIALOG_DEALERSHIP_APPEND_ALARM,
	DIALOG_DEALERSHIP_APPEND_LOCK,
	DIALOG_DEALERSHIP_APPEND_INS,
	DIALOG_DEALERSHIP_APPEND_IMMOB,
	DIALOG_DEALERSHIP_PURCHASE,

	DIALOG_XMR,
	DIALOG_XMR_SELECT,
	DIALOG_XMR_URL,

	DIALOG_CLOTHING_MENU,

	DIALOG_ADMIN_MSG,

	DIALOG_SECRETWORD_CREATE,
	DIALOG_SECRETWORD_APPROVE,

	DIALOG_FOOD_CONFIG,
	DIALOG_FOOD_TYPE,
	DIALOG_FOOD_PRICE_1,
	DIALOG_FOOD_PRICE_2,
	DIALOG_FOOD_PRICE_3,

	DIALOG_GRAFFITI_MENU,
	DIALOG_GRAFFITI_TEXT,
	DIALOG_GRAFFITI_FONT,

	DIALOG_MDC,
	DIALOG_MDC_FINISH_QUEUE,

	DIALOG_MDC_NAME,
	DIALOG_MDC_PLATE,
	DIALOG_MDC_PLATE_LIST,
	
	DIALOG_MDC_PLATE_FULL,
	DIALOG_MDC_PLATE_PARTIAL,

	DIALOG_MDC_NUMBER_SEARCH,

	DIALOG_VEHICLE_FINES,


	DIALOG_ADMIN_NAME,

	DIALOG_VLOG_LIST,
	DIALOG_PLOG_LIST,
	
	DIALOG_HACKSYS,

	DIALOG_ASYS_OFFLINEBAN,
	DIALOG_ASYS_BANREASON,

	DIALOG_ASYS_OFFLINEAJAIL,
	DIALOG_ASYS_OJAILTIME,
	DIALOG_ASYS_OJAILREASON,

	DIALOG_APANEL,
	DIALOG_ASYS_UNBAN,

	DIALOG_LOOKUP_JAILS,
	DIALOG_LOOKUP_KICKS,
	DIALOG_LOOKUP_BANS,

	DIALOG_DECRYPTMASK,

	DIALOG_FINDMASK,
	DIALOG_SKINSEARCH,

	DIALOG_ANOTE_LOOKUP,
	DIALOG_ANOTE_SELECT,

	DIALOG_ANOTE_EDIT,
	DIALOG_ANOTE_EDIT_YES,
	DIALOG_ANOTE_EDIT_YES2,
	DIALOG_ANOTE_EDIT_YES3,

	DIALOG_ANOTE_ADD,
	DIALOG_ANOTE_ADD_REASON,

	DIALOG_ANOTE_DELETE,
	DIALOG_ANOTE_DELETE_SELECT,
	DIALOG_ANOTE_DELETE_CONFIRM,

	DIALOG_PASSWORD_CHANGE,
	DIALOG_PASSWORD_SECURITY_WORD,

	DIALOG_GPS,
	DIALOG_CALL,
	DIALOG_SMS_1,
	DIALOG_SMS_2,

	DIALOG_CONTACT_1,
	DIALOG_CONTACT_2,

	DIALOG_CONTACT_EDIT_1,
	DIALOG_CONTACT_EDIT_2,
	DIALOG_CONTACT_EDIT_3,

	DIALOG_CONTACT_DELETE,

	DIALOG_SMS_OR_CALL,
    DIALOG_SMS_OR_CALL2,

	DIALOG_FACTIONMENU,
	DIALOG_FACTIONMENU_NAME,
	DIALOG_FACTIONMENU_ABBREV,
	DIALOG_FACTIONMENU_ALTER,
	DIALOG_FACTIONMENU_TOW,
	DIALOG_FACTIONMENU_CHAT,
	DIALOG_FACTIONMENU_JOIN,
	DIALOG_FACTIONMENU_EDIT,
	DIALOG_FACTIONMENU_EDITALT,

	DIALOG_FACTIONMENU_EDITSAL,
	DIALOG_FACTIONMENU_EDITALTSAL
}

new PlayerTutorialStep[MAX_PLAYERS],
	PlayerTutorialTimer[MAX_PLAYERS];

//Enumerators:
enum P_MASTER_ACCOUNTS
{
	mSQLID,
	mLastIP[16]
}

new AccountData[MAX_PLAYERS][P_MASTER_ACCOUNTS]; 

//Enumerators:
enum E_PLAYER_DATA
{
	pSQLID,
	pFirstLogin,

	pAdmin,
	pAdminName[24],
	bool:pAdminDuty,
	bool:pAdminHide,

	pTester,
	pTesterName[24],
	bool:pTesterDuty,

	pExp,
	pLevel,
	pMoney,
	pBank,
	pPaycheck,
	pSavings,

	pUpgradePoints,

	pBirthdate,
	pBirthplace[35],
	pAttributes[128],
	pSecurityNumber,

	Float: pPos[4],
	pInterior,
	pWorld,

	pMaxHealth,
	Float: pLastHealth,
	Float: pLastArmor,

	pSkin,
	pDutySkin,

	pDonator,
	pDonateTime,

	pOnlineTime,
	pRep,

	pHelpupTime,
	pReportTime,
	pSupportTime,

	pRegTime,
	pLastTime,
	pLastTimeLength,

	pPauseCheck,
	pPauseTime,

	pRegIP[16],
	pLastIP[16],
	
	pPlayTime,
	pCrashed,

	pHWID[60],
	pCarKey,
	pRentCarKey,

	pHouseKey,
	pHouseFurniture,

	pGrantBuild,
	p3DMenu,

	bool: pDriversLicense,
	bool: pWeaponsLicense,
	bool: pMedicalLicense,

	pFaction,
	pFactionRank,
	pBadge,

	pJob,
	pJobTime,
	pJobLevel,
	
	pSideJob,
	pSideJobTime,
	pSideJobLevel,

	pICJailed,
	pICJailTime,
	pICJailNotify,
	Text3D: pICJail3D,
	
	pPrisonTimes,
	pActiveListing,

	pOffAjail,
	pOffAjailReason[128],

	pAjailed,
	pAjailTime,
	pJailTimes,

	pAdminMsgBy,
	pAdminMsg[128],
	bool: pAdmMsgConfirm,

	pLegShot,
	pLowSkill,
	pBrutallyWounded,
	pExecuteTime,

	pChatstyle,
	pWalkstyle,
	pFightstyle,
	pHudstyle,
	pStreetstyle,

	bool: pChatStatus,
	bool: pHudStatus,
	bool: pStreetStatus,
	bool: pPMStatus,
	bool: pOOCStatus,
	bool: pFactionStatus,
	bool: pNewsStatus,
	bool: pColorStatus,
	bool: pDeathStatus,
	bool: pNickStatus,
	bool: pConnectStatus,

	pCheckpoint,
	pCarCheckpoint,

	pInsideComplex,	
	pInsideHouse,
	pInsideApartment,
	pInsideBusiness,
	pInsideGarage,
	pInsideEntrance,
	
	pInsideDoor,
	pInsidePNS,

	bool: pHasMask,
	bool: pHasRadio,
	bool: pHasBurner,
	bool: pHasBoombox,

	pMaskID,
	pMaskIDEx,
	bool: pMaskOn,

	pOwnedCar[10],
	
	pMainSlot,
	pRadio[9],
	pRadioSlot[9],

	pPhone,
	pPhoneOff,
	pPhoneType,
	pPhoneRingtone,
	pPhoneSilent,

	pCalling,
	pPhoneline,
	pPhoneCooldown,
	pLoudspeaker,
	
	bool: pUseGUI,
	bool: pUseCaseGUI,

	pBurnerPhone,
	bool: pUsingBurner,
	bool: pBurnerPhoneOff,

	pRenting,
	pWorkOn,

	pSpawnPoint,
	pSpawnPointHouse,
	pSpawnPrecinct,
	
	pLAWduty,
	pSWATduty,
	pMEDduty,
	pSDCduty,

	pComponents,
	pCigarettes,
	pDrinks,

	bool: pBlindFolded,
	bool: pHandcuffed,
	bool: pHandcuffing,
	pHandcuffCount,

	bool: pTaser,
	bool: pTackle,
	bool: pRubberbullet,
	bool: pLethalbullet,
	pCallsign[60], // birim kodu pd
	pDep,

	pWeapons[4], 
	pWeaponsAmmo[4],

	bool: pBuyingClothing,
	bool: pEditingClothing,
	pClothingName[20],
	pClothingPrice,

	pDrugUse,
	pDrugTime,
	pDrugChgWeather,
	pDrugTimer,
	pDrugLoop,

	pConvoID,
	pLiveBroadcast,
	
	pLiveOffer,
	pFactionOffer,

	pFishTime,
	pFishWeight,
	pFishCheckpoint,

	pSetTime, // offline jail þeysi
	pSetReason[128], // offline jail þeysi

	pItemCache[10], // market þeysi

	pInTuning,
	pTuningCount,
	pTuningComponent,
	pTuningCategoryID,
	
 	pSprayPoint,
    pSprayLength,
    pSprayText[128],
    pSprayFont,
    pSprayTarget,
    pSprayAllow,
    pSprayTimer[2],

	bool: pUnscrambling,
	pUnscramblerTime,
	pUnscrambleTimer,
	pUnscrambleID,
	pScrambleSuccess,
	pScrambleFailed,

	pGreetRequest,
	pGreetType,

	pFriskRequest,
	pFrisking,
	pAllowedFrisk,

	pLastChat,
	pLastCMD[128],
	pLastCMDTime,
	pLastEmoteTime,
	
	pTestCar,
	pTestStage,
	pTestTime,
	bool: pDrivingTest,
	bool: pTaxiDrivingTest,

	bool: pAutoLow,
	
	bool: pKickDoor,
	pTraceNum,
	pIsTracing,


	pAtDealership,
	
	p911Steps,
	p911Text[128],
	p911Location[128],
	p911CallTimer[2],

	bool: pCarryTrash,
	pCarryMeal,

	pCargoID,
	pCargoListed[MAX_TRUCK_PRODUCT],
	pPDAListed[MAX_TRUCK_CARGO],

	pChopshopCooldown,


	bool: pPlayingAnimation,

	TempTweak,

	pContacts[3]
}


new PlayerDirection[8][MAX_PLAYERS];

enum    e_sazone
{
    SAZONE_NAME[28],
    Float: SAZONE_AREA[6]
};

enum 	e_sacity
{
    SACITY_NAME[28],
    Float: SACITY_AREA[6]
};

enum E_CONTACTS_DATA
{
	contactSQLID,
	contactPlayerSQLID,
	contactID,
	contactName[128],
	contactNumber
}

enum E_XMR_CATEGORY_DATA
{
	XMRID,
	XMRCategoryName[90],
	XMRCategory
}

enum E_XMR_SUB_CATEGORY_DATA
{
	xmrID,
	xmrCategory,
	xmrName[90],
	xmrStationURL[128],
}

enum E_ADMIN_NOTES_DATA
{
	anote_SQLID,
	anote_playerDBID,
	anote_reason[128],
	anote_issuer[60],
	anote_date,
	anote_active
}

enum e_fine
{
	fine_id,
	Float: fine_x,
	Float: fine_y,
	Float: fine_z,
	fine_issuer[24],
	fine_reason[128],
	fine_faction,
	fine_amount,
	fine_date
}

enum E_CACHE_DATA
{
	pCurrentPage
}


new Fines[MAX_PLAYERS][MAX_FINES][e_fine];
new PhoneData[MAX_PLAYERS][E_CACHE_DATA];

new VehicleFines[MAX_VEHICLES][MAX_FINES][e_fine];
new XMRData[MAX_XMR_SUBCATEGORY][E_XMR_SUB_CATEGORY_DATA];
new XMRCategoryData[MAX_XMR_CATEGORIES][E_XMR_CATEGORY_DATA];
new aNotesData[MAX_PLAYERS][MAX_ADMIN_NOTES][E_ADMIN_NOTES_DATA];


new Text3D:VME[MAX_PLAYERS];
new HaveVME[MAX_PLAYERS] = {0, ...};
new TimerVME[MAX_PLAYERS];

//rental add
forward RentalCheck();

new CheckingPlayerFine[MAX_PLAYERS];

// [ ADMIN NOTE VARIABLES ]
new anote_idsave[MAX_PLAYERS];


// [ XMR VARIABLES ]
new CatXMRHolder[MAX_PLAYERS], SubXMRHolder[MAX_PLAYERS];
new SubXMRHolderArr[MAX_PLAYERS][MAX_XMR_CATEGORIES];

// [ GLOBAL VARIABLES ]
new OOC;
new TotalJailees;

new weather = 10;
new year,
    hour,
    minute,
    second,
    month,
    day;

new g_MysqlRaceCheck[MAX_PLAYERS];

new bool: pSpawnedIn[MAX_PLAYERS];
new bool: pLoggedIn[MAX_PLAYERS], PlayerData[MAX_PLAYERS][E_PLAYER_DATA];
new Float:oldHealth[MAX_PLAYERS], phoneTimer[MAX_PLAYERS];

new _pay_security_timer[MAX_PLAYERS];
new _respawn_timer[MAX_PLAYERS];
new _has_vehicle_spawned[MAX_PLAYERS], _has_spawned_vehicleid[MAX_PLAYERS];
new contact_save_id[MAX_PLAYERS];

new _has_player_reviving[MAX_PLAYERS], _has_player_reviver[MAX_PLAYERS];
new playerHelpingPlayer[MAX_PLAYERS], playerHelpingTimer[MAX_PLAYERS];
new Text3D: playerHelpSign[MAX_PLAYERS], playerHelpCount[MAX_PLAYERS];


new playerTowingVehicle[MAX_PLAYERS], playerTowTimer[MAX_PLAYERS];
new Text3D:vehicleTowSign[MAX_VEHICLES], playerVehicleTowCount[MAX_PLAYERS];

new bool: PlayerUpgradingVehicle[MAX_PLAYERS], PlayerUpgradeTimer[MAX_PLAYERS];
new Text3D: VehicleUpgradeSign[MAX_VEHICLES], PlayerVehicleUpgradeCount[MAX_PLAYERS];


new PlayerMDCText[MAX_PLAYERS][32], PlayerMDCPlateHolder[MAX_PLAYERS][5][32];
new PlayerStolenCarTimer[MAX_PLAYERS], PlayerStolenCarPrompt[MAX_PLAYERS];
new PlayerStolenCarPlate[MAX_PLAYERS][32];

new PlayerBillboardTimer[MAX_PLAYERS];

new playerTaserAmmo[MAX_PLAYERS];

new PlayerLoginTick[MAX_PLAYERS];

//Legshot
new LegShotTimer[MAX_PLAYERS];

//Lock Breaking
new PlayerBreakingIn[MAX_PLAYERS];
new PlayerBreakInVehicle[MAX_PLAYERS];

new Text3D:BreakInTextDraw[MAX_PLAYERS];
new BreakInTDTimer[MAX_PLAYERS];
new ActiveLockTD[MAX_PLAYERS];

new BreakInError[MAX_PLAYERS];

//SMS
new PlayerSMS[MAX_PLAYERS][128];

//Death
new DeathTimeNotice[MAX_PLAYERS];

//
new MainPhone[MAX_PLAYERS];

//Vehicle Logs
new PlayerVlogPage[MAX_PLAYERS];
new PlayerVlogVehicle[MAX_PLAYERS];

//Player Logs
new PlayerLogPage[MAX_PLAYERS];
new PlayerLogPlayer[MAX_PLAYERS];

//Calling Mechanic
new MechanicText[MAX_PLAYERS][128];
new MechanicCallTimer[MAX_PLAYERS];

//Calling Taxi
new TaxiText[MAX_PLAYERS][128];
new TaxiCallTimer[MAX_PLAYERS];


//Taxi Job
new bool:StartedTaxiJob[MAX_PLAYERS];
new TaxiDriver[MAX_PLAYERS]; //Taxi driver's ID when player enters;
new TaxiDurationTimer[MAX_PLAYERS];
new TaxiDuration[MAX_PLAYERS];
new TaxiPrice[MAX_PLAYERS];
new InTaxiRide[MAX_PLAYERS];
new TaxiDriverTimer[MAX_PLAYERS];
new TaxiFair[MAX_PLAYERS];
new TaxiTotalFair[MAX_PLAYERS];
new TaxiFairStarted[MAX_PLAYERS];

//
new PlayerIsTased[MAX_PLAYERS];

//Vehicle Sell
new VehicleOfferedTo[MAX_PLAYERS]; //Player who uses /v sell;
new VehicleOfferBy[MAX_PLAYERS]; //Target of /vsell;
new VehicleDBIDOffered[MAX_PLAYERS]; //Vehicle of /vsell;
new VehiclePrice[MAX_PLAYERS]; //Price of /vsell;

//Fuel Station Refill
new PlayerRefilling[MAX_PLAYERS]; //When uses /v refill, starts.
new RefillPoint[MAX_PLAYERS]; // The refill point counter;
new Text3D:RefillTextdraw[MAX_PLAYERS]; // TD refill;
new RefillTimer[MAX_PLAYERS];
new RefillPrice[MAX_PLAYERS];
new Float:RefillAmount[MAX_PLAYERS];
new RefillVehicle[MAX_PLAYERS];

//Mechanic Offer

//Hire Business
new OfferedHireTo[MAX_PLAYERS];
new OfferedHireBusinessID[MAX_PLAYERS];
new OfferedHireBy[MAX_PLAYERS];

//Admin System
new OfflineBanName[MAX_PLAYERS][60];
new OfflineJailName[MAX_PLAYERS][60], OfflineJailTime[MAX_PLAYERS];
new AdminPanelName[MAX_PLAYERS][60];

new AdminNoteSelect[MAX_PLAYERS][MAX_ADMIN_NOTES];
new AdminNoteSelected[MAX_PLAYERS], AdminNoteIssuer[MAX_PLAYERS][90];

//Password Change
new CanChangePassword[MAX_PLAYERS];

new CarEngine[MAX_VEHICLES], CarLights[MAX_VEHICLES];

new CarlastDriver[MAX_VEHICLES], CarlastPassenger[MAX_VEHICLES];

// [ FACTION VEHICLE VARIABLES ]
new Text3D:vehicleTextdraw[MAX_PLAYERS], playerTextdraw[MAX_PLAYERS];


new
	EditingID[MAX_PLAYERS],
	EditingObject[MAX_PLAYERS];

// [ CONTACT VARIABLES ]
new ContactsData[MAX_PLAYERS][MAX_PLAYER_CONTACTS][E_CONTACTS_DATA];

// [ DEALERSHIP VARIABLES ]
new SubDealershipHolder[MAX_PLAYERS];

new bool:PlayerPurchasingVehicle[MAX_PLAYERS];
new g_aVehicleSpawned[MAX_PLAYERS], g_aVehicleColor[MAX_PLAYERS][2];
new g_aLockLevel[MAX_PLAYERS], g_aAlarmLevel[MAX_PLAYERS], g_aImmobLevel[MAX_PLAYERS], bool: g_aXMR[MAX_PLAYERS], g_aInsurance[MAX_PLAYERS];
new g_aTotalAmount[MAX_PLAYERS];

// [ MECHANIC JOB VARIABLES ]
new PaintJobTimer[MAX_PLAYERS];
new PlayerText: PlayerOffer[MAX_PLAYERS];

new PlayerText: PropertyLightsTXD[MAX_PLAYERS];

new CharacterHolder[MAX_PLAYERS][3];
new PlayerText:Character_Logo[MAX_PLAYERS];
new PlayerText:Character_Preview[MAX_PLAYERS][3],
	PlayerText:Character_Preview_Name[MAX_PLAYERS][3];

new
	PlayerText: PhoneCase[MAX_PLAYERS][10],
    PlayerText: ColorPanel[MAX_PLAYERS][10],
	PlayerText: PhoneFrame[MAX_PLAYERS][3],
	PlayerText: PhoneLogo[MAX_PLAYERS],
	PlayerText: PhoneSwitch[MAX_PLAYERS],
	PlayerText: PhoneInfo[MAX_PLAYERS],
	PlayerText: PhoneDisplay[MAX_PLAYERS],
	PlayerText: PhoneBtnL[MAX_PLAYERS],
	PlayerText: PhoneBtnR[MAX_PLAYERS],
	PlayerText: PhoneArrowUp[MAX_PLAYERS],
	PlayerText: PhoneArrowDown[MAX_PLAYERS],
	PlayerText: PhoneArrowLeft[MAX_PLAYERS],
	PlayerText: PhoneArrowRight[MAX_PLAYERS],
	PlayerText: PhoneBtnMenu[MAX_PLAYERS],
	PlayerText: PhoneBtnBack[MAX_PLAYERS],
	PlayerText: PhoneDate[MAX_PLAYERS],
	PlayerText: PhoneTime[MAX_PLAYERS],
	PlayerText: PhoneSignal[MAX_PLAYERS],
	PlayerText: PhoneNotify[MAX_PLAYERS],
	PlayerText: PhoneList[MAX_PLAYERS][3],
	PlayerText: PhoneListName[MAX_PLAYERS],
	PlayerText: PhoneSMSInfo[MAX_PLAYERS],
 	PlayerText: PlayerOffer2[MAX_PLAYERS],
	PlayerText: SpectatorTD[MAX_PLAYERS],
	PlayerText: Trace_PTD[MAX_PLAYERS][1],
	PlayerText: Unscrambler_PTD[MAX_PLAYERS][3],
	PlayerText: TaxiFair_PTD[MAX_PLAYERS][5],
	PlayerText:	FoodOrder[MAX_PLAYERS][13];

new PlayerText: Player_Hud[MAX_PLAYERS][5],
	PlayerText: Street_Hud[MAX_PLAYERS][7];

new Text: blindfoldTextdraw,
	Text: Masktd;



new const VehicleColoursTableRGBA[256] =
{
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

enum E_UNSCRAMBLER_DATA
{
	scrambledWord[60],
	unscrambledWord[60]
}

// [ UNSCRAMBLER VARIABLES ]
new const g_aUnscrambleInfo[][E_UNSCRAMBLER_DATA] = {
    {"sfire", "Sifre"},
    {"bigli", "Bilgi"},
    {"sphea", "Sehpa"},
    {"mazan", "Zaman"},
    {"serim", "Resim"},
    {"rnek", "Renk"},
    {"argaj", "Garaj"},
    {"ve", "Ev"},
    {"blekliik", "Bileklik"},
    {"Rhbeer", "Rehber"},
    {"Yaakkabi", "Ayakkabi"},
    {"yunocak", "Oyuncak"},
    {"tob", "Bot"},
    {"lfrot", "Flort"},
    {"kmera", "Kamera"},
    {"lzear", "Lazer"},
    {"dvelet", "Devlet"},
    {"klyoe", "Kolye"},
    {"mbilyao", "Mobilya"},
    {"knepea", "Kanepe"},
    {"mkenia", "Makine"},
    {"sgarai", "Sigara"},
    {"lakol", "Alkol"},
    {"abyrak", "Bayrak"},
    {"kvvetu", "Kuvvet"},
    {"psor", "Spor"},
    {"anhtara", "Anahtar"}
};

enum 	e_dealership_categories
{
	CategoryID,
	CategoryModelName[25],
	CategoryModel
}

new DealershipCatData[MAX_DEALERSHIP_CAT][e_dealership_categories];
new Iterator:DealershipCats<MAX_DEALERSHIP_CAT>;

enum INTERIOR_MAIN
{
	INT_NAME[28],
	Float:INT_POS[3],
	INT_ID
}

new Interiors[][INTERIOR_MAIN] =
{
	// Interior Name // Positions ( X, Y, Z) // Interior ID
	{"Ryder's House", {2468.8411,-1698.2228,1013.5078}, 2},
	{"CJ's House", {2495.8916,-1692.5658,1014.7422}, 3},
	{"Madd Dog Mansion", {1299.14, -794.77, 1084.00}, 5},
	{"Safe House 1", {2233.6919,-1112.8107,1050.8828}, 5},
	{"Safe House 2", {2196.8374,-1204.5576,1049.0234}, 6},
	{"Safe House 3", {2317.5347,-1026.7506,1050.2178}, 9},
	{"Safe House 4", {2259.4021,-1136.0243,1050.6403}, 10},
	{"Burglary X1", {234.6087,1187.8195,1080.2578}, 3},
	{"Burglary X2", {225.5707,1240.0643,1082.1406}, 2},
	{"Burglary X3", {224.288,1289.1907,1082.1406}, 1},
	{"Burglary X4", {226.2955,1114.3379,1080.9929}, 5},
	{"Burglary Houses", {295.1391,1473.3719,1080.2578}, 15},
	{"Motel Room", {446.3247,509.9662,1001.4195}, 12},
	{"Pair Burglary", {446.626,1397.738,1084.3047}, 2},
	{"Burglary X11", {226.8998,0.2832,1080.9960}, 5},
	{"Burglary X12", {261.1165,1287.2197,1080.2578}, 4},
	{"Michelle's Love Nest", {309.4319,311.6189,1003.3047}, 4},
	{"Burglary X14", {24.3769,1341.1829,1084.375}, 10},
	{"Burglary X13", {221.6766,1142.4962,1082.6094}, 4},
	{"Unused House", {2323.7063,-1147.6509,1050.7101}, 12},
	{"Millie's Room", {344.9984,307.1824,999.1557}, 6},
	{"Burglary X15", {-262.1759,1456.6158,1084.3672}, 4},
	{"Burglary X16", {22.861,1404.9165,1084.4297}, 5},
	{"Burglary X17", {140.3679,1367.8837,1083.8621}, 5},
	{"House X18", {234.2826,1065.229,1084.2101}, 6},
	{"House X19", {-68.6652,1351.2054,1080.2109}, 6},
	{"House X20", {-283.4464,1470.8777,1084.3750}, 15},
	{"Colonel Furhberger", {2807.4458,-1174.2394,1025.5703}, 8},
	{"The Camel's Safehouse", {2218.0737,-1076.0438,1050.4844}, 1},
	{"Verdant Bluffs House", {2365.1042,-1135.5898,1050.8826}, 8},
	{"Burglary X21", {-42.6339,1405.4767,1084.4297}, 8},
	{"Willowfield House", {2282.8049,-1140.2722,1050.8984}, 11},
	{"House X20", {82.9119,1322.4266,1083.8662}, 9},
	{"Burglary X22", {260.7421,1238.2261,1084.2578}, 9},
	{"Burglary X23", {266.5074,305.1129,999.1484}, 2},
	{"Katie's Lovenest", {322.5014,303.6906,999.1484}, 5},
	{"Barbara's Love nest", {244.0007,305.1925,999.1484}, 1}
};

new PlatePossible[][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

new const g_aPreloadLibs[][] =
{
	"AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
	"BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
	"CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
	"DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
	"FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
	"GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
	"GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
	"INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
	"KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
	"MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
	"MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
	"PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
	"POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
	"QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
	"ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
	"SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
	"SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
	"STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
	"SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
	"TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
	"WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};


enum impoundData
{
	impoundID,
	impoundExists,
	Float:impoundLot[3],
	Float:impoundRelease[4],
	impoundPickup
}

new ImpoundData[MAX_IMPOUND_LOTS][impoundData];
    
new const getMonth[][] = {
    "", "Ocak", "Þubat", "Mart", "Nisan", "Mayýs", "Haziran", "Temmuz", "Aðustos", "Eylül", "Ekim",
    "Kasým", "Aralýk"
};

new const getMonthEN[][] = {
    "", "Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim",
    "Kasim", "Aralik"
};

new const g_arrTaxiDrivingPickupTexts[][] = {
	{"Hýzlý sür, durum acil."},
	{"Selam, aciliyetim yüksek."},
	{"Ne bekliyorsun hala, acelem var!"},
	{"Sanýrým çok yavaþýz, biraz daha hýzlanabilir miyiz?"},
	{"Sanýrým gideceðim yer uzak deðil."},
	{"Santos Deðiþik bir yer, ama acelem var."}
};

new const g_arrTaxiDrivingTexts[][] = {
	{"Tanrý seni korusun dostum, sað ol."},
	{"Taksi için sað olun."},
	{"Teþekkürler, iyi günler!"},
	{"Tek parça buraya ulaþtýðýma inanamýyorum!"}
};

new const g_arrTaxiDrivingBotTexts[][] = {
	{""},
	{""},
	{""},
	{"All Saints Hospital Otoparký"},
	{"Glazier sokaðý, stüdyonun önüne at beni."},
	{""},
	{"Galloway Sokaðý, Subway Önü"},
	{"Sahildeki skate parka gidelim, lütfen."},
	{""},
	{"313 Santa Maria Bulvarý, Apartmanlarý"},
	{"Havalimanýna lütfen, uçaðý kaçýrmak istemiyorum!"},
	{""},
	{"38. Sokak, El Corona"},
	{"Commerce'deki stüdyolara gidelim, iç çamaþýrý çekimlerim var."},
	{""},
	{"Sunset Avenue, Downtown, Ammunation Arkasý"},
	{"Vinewood tabelasýndan yukarýya ve ardýndan iki ev ileride, gidelim."},
	{""},
	{"Mulholland, Camino del Sol, 806"},
	{"Rodeo'daki banka lütfen, bugün talih kuþu bana kondu!"},
	{""},
	{"Rodeo, Tableu Önü"},
	{"Verona Mall'a gidelim, kendime biraz pahalý kýyafetler alacaðým."},
	{""},
	{"East Beach, Bankanýn Yaný"},
	{"Central Parka sürer misin? Sevgilimi basacaðým."},
	{""},
	{""}
};
   
new const Float:g_arrTaxiDrivingCheckpoints[][] = {
	{1277.8317,-1569.0668,13.2877}, // anlatým 1 0
	{1198.5482,-1514.6963,13.3060}, // anlatým 2 1	
	{1198.4982,-1417.3740,13.1774}, // anlatým 3 2
	{1263.3442,-1365.1315,13.1979}, // 1. yolcu çaðrý 3
 	{1210.1345,-1329.1127,13.4073}, // 1. yolcu alýþ 4
 	{955.8081,-1217.9022,16.6731}, // 1. yolcu býrakýþ 5
 	{938.6342,-1267.3850,15.3438}, // 2. yolcu çaðrý 6
 	{810.6131,-1317.1333,13.3530}, // 2. yolcu alýþ 7
 	{334.1356,-1810.1005,4.4097}, // 2. yolcu býrakýþ 8
 	{389.8937,-1776.0398,5.3263}, // 3. yolcu çaðrý 9
 	{883.8313,-1789.9419,13.5621}, // 3. yolcu alýþ 10
 	{1646.3754,-2323.1208,-2.9127}, // 3. yolcu býrakýþ 11
 	{1705.4163,-2323.0090,-2.9230}, // 4. yolcu çaðrý 12
 	{1895.5288,-2056.2686,13.3217}, // 4. yolcu alýþ 13
 	{1712.7489,-1589.8347,13.2960}, // 4. yolcu býrakýþ 14
 	{1612.7808,-1322.3861,17.2353}, // 5. yolcu çaðrý 15
 	{1458.5671,-1280.5707,13.3247}, // 5. yolcu alýþ 16
 	{1472.4779,-885.1282,56.7636}, // 5. yolcu býrakýþ 17
 	{1507.1527,-772.8579,82.0956}, // 6. yolcu çaðrý 18
 	{1106.1022,-731.8591,100.8048}, // 6. yolcu alýþ 19
 	{591.3793,-1234.9360,17.7612}, // 6. yolcu býrakýþ 20
 	{574.0125,-1394.9546,14.2177}, // 7. yolcu çaðrý 21
 	{525.5950,-1564.8011,15.6820}, // 7. yolcu alýþ 22
 	{1158.7169,-1411.2120,13.4408}, // 7. yolcu býrakýþ 23
 	{1217.4080,-1409.8450,13.0950}, // 8. yolcu çaðrý 24
 	{2869.6414,-1457.9335,10.8084}, // 8. yolcu alýþ 25
 	{1510.0813,-1696.0083,13.3060}, // 8. yolcu býrakýþ 26

	{1267.3070,-1568.7356,13.3849} // bitiþ 27
};   


new const Float:g_arrDrivingCheckpoints[][] = {

    {1210.3262,-1570.0897,13.1084},
	{1116.0262,-1570.1940,13.1131},
	{1049.5703,-1570.1040,13.1087},
	{1049.3064,-1509.7079,13.1000},
	{931.9813,-1486.8065,13.0950},
	{919.8348,-1419.9318,12.9488},
	{919.6249,-1380.8132,12.9505},
	{944.7567,-1291.2830,14.0406},
	{944.7017,-1162.4944,22.7318},
	{1011.9506,-1152.0228,23.3994},
	{1094.9423,-1151.6755,23.3760},
	{1327.6660,-1151.4548,23.3720},
	{1444.5645,-1163.0797,23.3796},
	{1452.5798,-1227.8743,13.4458},
	{1452.1144,-1286.8938,13.1042},
	{1590.1855,-1303.6564,17.0521},
	{1601.5413,-1425.9412,13.1760},
	{1527.7880,-1438.9318,13.1051},
	{1441.1506,-1438.3518,13.1053},
	{1371.2999,-1397.8710,13.1076},
	{1335.8217,-1455.2852,13.1023},
	{1295.5664,-1559.3916,13.1141},
	{1257.8253,-1566.5979,13.1927}
};

enum E_CHOPSHOP_DATA
{
	chopshop_id,
	chopshop_wanted[10],
    Float: chopshop_pos[6],
    chopshop_object[2],
    chopshop_money,
    chopshop_exist
}

new ChopshopData[MAX_CHOPSHOP][E_CHOPSHOP_DATA];

new playerEnteringVehicle[MAX_PLAYERS] = INVALID_VEHICLE_ID;

new ChopshopTimer[MAX_PLAYERS] = {-1, ...},
	Chopshopping[MAX_PLAYERS];
	
new PlayerText:TDTuning_Component[MAX_PLAYERS],
	PlayerText:TDTuning_Dots[MAX_PLAYERS],
	PlayerText:TDTuning_Price[MAX_PLAYERS],
	PlayerText:TDTuning_ComponentName[MAX_PLAYERS],
	PlayerText:TDTuning_YN[MAX_PLAYERS];

new const Float:RandomTuningSpawn[][] =
{
    {345.8079, -1358.1921, 14.1357, 118.4599},
	{344.5041, -1355.7866, 14.1322, 118.4599},
	{343.1835, -1353.3506, 14.1286, 118.4599},
	{341.8597, -1350.9081, 14.1250, 118.4599},
	{340.5688, -1348.5264, 14.1215, 118.4599},
	{339.2497, -1346.0927, 14.1179, 118.4599},
	{338.0098, -1343.8055, 14.1145, 118.4599},
	{336.7597, -1341.4994, 14.1111, 118.4599}
};

new const TuningCategories[11][32] =
{
	"Spoiler",
	"Air-vents",
	"Exhaust",
	"Bumper A",
	"Bumper P",
	"Roof",
	"Wheels",
	"Hydraulic",
	"Nitro",
	"Side Skirts",
	"Paintjob"
};

new playerReport[MAX_PLAYERS][128];

#define MAX_WEP_SLOT (6)
#define MAX_PACK_SLOT (21)


enum E_PROPERTY_WEAP
{
	data_id,
	property_id,
	prop_wep,
	prop_ammo,
	bool: is_exist
}

new property_weap_data[MAX_PROPERTY][MAX_PACK_SLOT][E_PROPERTY_WEAP];


enum E_VEHICLE_WEAP
{
	data_id,
	veh_id,
	Float: wep_offset[6],
	veh_wep,
	veh_ammo,
	temp_object,
	bool:is_exist
}

new vehicle_weap_data[MAX_VEHICLES][MAX_WEP_SLOT][E_VEHICLE_WEAP];


enum
{
	REGULAR_PLAYER = 0,
	DONATOR_BRONZE,
	DONATOR_SILVER,
	DONATOR_GOLD
};

enum e_phonecase
{
	caseModel
}

new g_aPhoneCaseData[][e_phonecase] = {
	//{18868},
	{18874},
	{18870},
	{18873},
	{18866},
	{18871},
	{18865},
	{18869}
};

enum 	spraytag_data
{
	tag_name[64],
	tag_modelid
}

enum 	e_font_config
{
	font_name[64]
}

new const g_spraytag[][spraytag_data] =
{
	{"Grove Street Families", 18659},
	{"Seville BLVD Families", 18660},
	{"Varrio Los Aztecas", 	  18661},
	{"Kilo Tray Ballas", 	  18662},
	{"San Fiero Rifa", 		  18663},
	{"Temple Drive Ballas ",  18664},
	{"Los Santos Vagos", 	  18665},
	{"Front Yard Ballaz", 	  18666},
	{"Rollin Heights Ballas", 18667}
};

new const font_data[][e_font_config] =
{
	{"Arial"},
	{"Courier"},
	{"Comic Sans MS"},
	{"Levi Brush"},
	{"Dripping"},
	{"Diploma"}
};

enum	_:e_garbagetypes
{
	TYPE_BIN,
	TYPE_DUMPSTER
}

enum 	e_clothings
{
	ClothingID,
	ClothingOwnerID,
	ClothingName[20],

	ClothingSlotID,
	ClothingModelID,
	ClothingBoneID,

	Float: ClothingPos[3],
	Float: ClothingRot[3],
	Float: ClothingScale[3],

	bool: ClothingAutoWear,

	ClothingColor,
	ClothingColor2
}

new ClothingData[MAX_PLAYERS][MAX_CLOTHING_ITEMS][e_clothings];

enum 	e_notes
{
	NoteID,
	NoteDetails[128],
	NoteTime
}

new NoteData[MAX_PLAYERS][MAX_PLAYER_NOTES][e_notes];

enum 	e_vehicles
{
	carID,
	carModel,	
	carOwnerID, // 0
	carFaction, // -1
	carRental, // 0
	carRentalPrice,
	carRentedBy,
	carTerminate,

	carPlates[20],
	carName[35],

	carSign[45],
	Text3D: carSign3D,

	Float: carPos[4],
	carInterior,
	carWorld,

	carColor1,
	carColor2,

	bool: carXMR,
	bool: carXMROn,
	carXMRUrl[128],

	bool: carSiren,
	bool: carSirenOn,
	carSirenObject,

	bool: carLocked,
	carImpounded,

	Float: carFuel,
	Float: carMileage,
	Float: carArmour,
	Float: carEngine,
	Float: carBattery,

	carLock,
	carAlarm,
	carImmob,
	carInsurance,
	carInsuranceTime,
	carInsurancePrice,
	carTimeDestroyed,

	carPaintjob,
	carMods[14],
	carDoors[4],
	carWindows[4],

	carlastDriver,
	carlastPassenger,

	Float: carLastHealth,
	carPanelStatus,
	carDoorsStatus,
	carLightsStatus,
	carTiresStatus,

	bool: carExists,
	bool: carTweak,
	carRev,

	carCargoObj[6],
	carCargoAmount[MAX_TRUCK_PRODUCT],
	carTrashCount,

	bool: carPhysicalAttack,
	carDoorHealth,
	carDoorEffect,
	bool: carCooldown,
}

new CarData[MAX_VEHICLES][e_vehicles];


enum 	e_properties
{
	PropertyID,
	PropertyOwnerID,

	PropertyType, // 1- Complex, 2- Apartment, 3- House
	PropertyComplexLink,
	PropertyFaction,

	PropertyLevel,
	PropertyPickup,
	PropertyMoney, // kasadaki para

	PropertyAddress[MAX_PROPERTY_ADDRESS],
	
	Float: PropertyEnter[4],
	PropertyEnterInterior,
	PropertyEnterWorld,
	
	Float: PropertyExit[4],
	PropertyExitInterior,
	PropertyExitWorld,
		
	Float: PropertyCheck[3],
	PropertyCheckInterior,
	PropertyCheckWorld,

	PropertyMarketPrice,
	Text3D: PropertyMarketLabel,

	PropertyRentPrice,
	bool: PropertyRentable,
	bool: PropertyLocked,
	
	bool: PropertyHasXMR,
	Float: PropertyXMR[6],

	PropertyXMRObject,
	bool: PropertyXMROn,
	PropertyXMRUrl[128],

	PropertyTime,
	bool: PropertyLights,

	PropertySwitchID,
	bool: PropertySwitch,

	PropertyAreaID[2]
}

new PropertyData[MAX_PROPERTY][e_properties];
new Iterator:Properties<MAX_PROPERTY>;

enum 	e_factions
{
	FactionID,

	FactionName[128],
	FactionAbbrev[128],

	FactionMaxRanks,

	FactionEditrank,
	FactionChatrank,
	FactionTowrank,

	FactionChatColor,
	FactionChatStatus,

	FactionCopPerms,
	FactionSheriffPerms,
	FactionMedPerms,
	FactionSanPerms,

	Float: FactionSpawn[4],
	FactionSpawnInterior,
	FactionSpawnVW,
	
	Float: FactionSpawnEx1[4],
	FactionSpawnEx1Interior,
	FactionSpawnEx1VW,
	
	Float: FactionSpawnEx2[4],
	FactionSpawnEx2Interior,
	FactionSpawnEx2VW,
	
	Float: FactionSpawnEx3[4],
	FactionSpawnEx3Interior,
	FactionSpawnEx3VW,

	FactionBank
}

new FactionData[MAX_FACTIONS][e_factions];
new Iterator:Factions<MAX_FACTIONS>;

new FactionRanks[MAX_FACTIONS][MAX_FACTION_RANKS][60];
new FactionRanksSalary[MAX_FACTIONS][MAX_FACTION_RANKS];

enum    e_label
{
	Text3D: label_3D,
	label_placedby[25],
	label_location[40],
	Float: label_pos[3],
	label_virtualworld,
	label_interior,

	LabelAreaID
}

new LabelData[MAX_LABELS][e_label];
new Iterator:Labels<MAX_LABELS>;

enum    e_dosign
{
	Text3D: DosignLabel,
	DosignPlacedBy[25],
	Float: DosignPos[3],
	DosignInterior,
	DosignWorld,
	DosignTimer
}

new DosignData[MAX_DOSIGN][e_dosign];
new Iterator:Dosigns<MAX_DOSIGN>;

enum    e_fire
{
	fire_object,
	fire_placedby[25],
	fire_location[40],
	Float: fire_pos[6],
	fire_virtualworld,
	fire_interior,
	bool: f_is_editing,
	bool: f_is_extinguished
}

new FireData[MAX_FIRES][e_fire];
new Iterator:Fires<MAX_FIRES>;

enum    e_entrances
{
	EntranceID,
	EntranceName[32],
	EntranceIcon,
	EntranceFaction,
	bool: EntranceLocked,
	
	Float: EntrancePos[4],
	EntranceInteriorID,
	EntranceWorld,
	
	Float: EntranceInt[4],
	ExitInteriorID,
	ExitWorld,

	EntrancePickup[2],
	EntranceAreaID[2]
}

new EntranceData[MAX_ENTRANCES][e_entrances];
new Iterator:Entrances<MAX_ENTRANCES>;

enum    e_garages
{
	GarageID,
	GarageFaction,
	GaragePropertyID,
	bool: GarageLocked,
	
	Float: GaragePos[4],
	EnterInteriorID,
	EnterWorld,
	
	Float: GarageInt[4],
	ExitInteriorID,
	ExitWorld,
	
	GarageAreaID[2]
}

new GarageData[MAX_GARAGES][e_garages];
new Iterator:Garages<MAX_ENTRANCES>;

enum    e_paynsprays
{
	PnsID,
	PnsPickup,
	PnsPrice,
	PnsName[45],
	PnsEarnings,
	
	Float: PnsPos[4],
	EnterInteriorID,
	EnterWorld,
	
	Float: PnsInt[4],
	ExitInteriorID,
	ExitWorld,
	
	bool: PnsOccupied,
	PnsAreaID
}

new PNSData[MAX_PAYNSPRAY][e_paynsprays];
new Iterator:Sprays<MAX_PAYNSPRAY>;

enum    e_adverts
{
    AdvertType,
    AdvertText[256],
   	AdvertPlaceBy,
    AdvertContact,
    PublishTime,
    AdvertTimer
}
new AdvertData[MAX_ADVERTS][e_adverts];
new Iterator:Adverts<MAX_ADVERTS>;

enum    e_actors
{
	ActorID,
	ActorModel,
	ActorName[45],
	ActorObject,

	Float: ActorPos[4],
	ActorInterior,
	ActorWorld,
	
	Text3D: ActorLabel
}

new ActorData[MAX_SIKICILER][e_actors];
new Iterator:Actors<MAX_SIKICILER>;

enum    e_atms
{
	AtmID,
	AtmObject,
	
	Float: AtmPos[6],
	AtmInterior,
	AtmWorld,

	AtmAreaID
}

new ATMData[MAX_ATM_MACHINES][e_atms];
new Iterator:ATMs<MAX_ATM_MACHINES>;

enum 	e_garbages
{
	GarbageID,
	GarbageType,
	GarbageCapacity,
	GarbageTakenCapacity,
	Float: GarbagePos[3],
	GarbageInterior,
	GarbageWorld,
	GarbageArea
}

new GarbageData[MAX_GARBAGE_BINS][e_garbages];
new Iterator:Garbages<MAX_GARBAGE_BINS>;

enum    e_doors
{
	DoorID,
	DoorFaction,
	DoorName[35],
	bool: DoorLocked,
	
	Float: EnterPos[4],
	EnterInterior,
	EnterWorld,
	
	Float: ExitPos[4],
	ExitInterior,
	ExitWorld,
	
	DoorAreaID[2]
}

new DoorData[MAX_DOORS][e_doors];
new Iterator:Doors<MAX_DOORS>;

enum    e_gates
{
	GateID,
	GateModel,
	GateLinkID,
	GateFaction,
	
	bool: GateStatus,
	Float: GateSpeed,
	Float: GateRadius,
	
	GateTime,
	GateTimer,
	GateObject,
	
	GateTIndex,
	GateTModel,
	GateTXDName[33],
	GateTextureName[33],
	
	Float: GateMovePos[6],
	Float: GatePos[6],
	GateInterior,
	GateWorld,
	
	GateAreaID
}

new GateData[MAX_GATES][e_gates];
new Iterator:Gates<MAX_GATES>;

enum    e_objects
{
	ObjectID,
	ObjectModel,
	ObjectHolder,
	Float: ObjectPos[6],
	ObjectInterior,
	ObjectWorld,

	ObjectAreaID
}

new ObjectData[MAX_SERVER_OBJECTS][e_objects];
new Iterator:Objects<MAX_SERVER_OBJECTS>;

enum    e_reports
{
	ReportPlayer,
	ReportText[128]
}

new ReportData[MAX_REPORTS][e_reports];
new Iterator:Reports<MAX_REPORTS>;

enum    e_supports
{
	SupportPlayer,
	SupportText[128]
}

new SupportData[MAX_SUPPORTS][e_supports];
new Iterator:Supports<MAX_SUPPORTS>;

enum    e_sprays
{
	SprayID,
	Float: SprayLocation[6],
	SprayText[128],
	SprayModel,
	SprayBy,
	SprayInterior,
	SprayWorld,
	SprayObject,
	SprayAreaID
}

new SprayData[MAX_SPRAYS][e_sprays];
new Iterator:Tags<MAX_SPRAYS>;

enum    e_billboards
{
	BillboardID,
	BillboardModel,
	Float: BillboardLocation[6],
	BillboardText[128],
	BillboardInterior,
	BillboardWorld,
	BillboardObject,

	BillboardRentedBy,
	BillboardRentExpiresAt,
	BillboardInArea
}

new BillboardData[MAX_BILLBOARDS][e_billboards];
new Iterator:Billboards<MAX_BILLBOARDS>;

/*enum 	e_pickups
{
	PickupID,
	PickupText[128],
	Float: PickupLocation[3],
	PickupInterior,
	PickupWorld,
	PickupIcon,
	
	Text3D: PickupText3D,
	PickupPickup
}

new PickupData[MAX_SERVER_PICKUPS][e_pickups];
new Iterator:Pickups<MAX_SERVER_PICKUPS>;*/

enum 	e_antennas
{
	AntennaID,
	Float: AntennaLocation[6],
	AntennaObject,
	AntennaAreaID
}

new AntennaData[MAX_ANTENNAS][e_antennas];
new Iterator:Antennas<MAX_ANTENNAS>;

enum 	e_boomboxs
{
	BoomboxID,
	BoomboxOwnerID,
	BoomboxURL[256],
	bool: BoomboxStatus,
	Float: BoomboxLocation[6],
	BoomboxInterior,
	BoomboxWorld,
	BoomboxObject,
	BoomboxAreaID
}

new BoomboxData[MAX_BOOMBOXS][e_boomboxs];
new Iterator:Boomboxs<MAX_BOOMBOXS>;

enum 	e_streets
{
	StreetID,
	StreetName[35],
	MaxPoints,
	StreetX,
	StreetY,
	StreetAreaID
}

new StreetData[MAX_STREETS][e_streets];
new Iterator:Streets<MAX_STREETS>;

new PropertyNameHolder[MAX_PLAYERS][35];

enum 	e_dealerships
{
	DealershipID,
	DealershipCategory,
	DealershipModelName[45],
	DealershipModel,
	DealershipPrice,
	DealershipIsEnabled
}

new DealershipData[MAX_DEALERSHIPS][e_dealerships];
new Iterator:Dealerships<MAX_DEALERSHIPS>;

enum 	e_dealerships_player
{
	DealershipID,
	DealershipCategory,
	DealershipModelName[45],
	DealershipModel,
	DealershipPrice,
	DealershipIsEnabled
}

new DealershipPData[MAX_DEALERSHIPS][e_dealerships_player];

enum 	e_tolls
{
	TollID,
	TollName[25],
	TollModel,
	TollPrice,

	Float: TollPos[6],
	Float: TollMovePos[6],
	TollInterior,
	TollWorld,

	bool: TollLocked,
	bool: TollStatus,

	TollTimer,
	TollObject,
	TollAreaID
}

new TollData[MAX_TOLLS][e_tolls];
new Iterator:Tolls<MAX_TOLLS>;

new TotalTollPayment, TollTimesLocked;

enum 	e_businesses
{
	BusinessID,
	BusinessPrice,
	BusinessOwnerSQLID,
	BusinessName[128],
	BusinessMOTD[128],
	BusinessPickup,

	BusinessType,
	BusinessRestaurantType,
	BusinessLevel,

	Float: EnterPos[4],
	EnterInterior,
	EnterWorld,
	
	Float: ExitPos[4],
	ExitInterior,
	ExitWorld,

	BankPickup,
	Float: BankPos[3],
	BankInterior,
	BankWorld,

	BusinessFee,
	BusinessCashbox,
	bool: BusinessLocked,
	
	bool: BusinessHasXMR,
	bool: BusinessXMROn,
	BusinessXMRUrl[128],

	BusinessTime,
	bool: BusinessLights,

	BusinessRake,

	BusinessProduct,
	BusinessWantedProduct,
	BusinessProductPrice,

	BusinessFood[3],
	BusinessFoodPrice[3],

	BusinessAreaID[2]
}

new BusinessData[MAX_BUSINESS][e_businesses];
new Iterator:Businesses<MAX_BUSINESS>;


#define TYPE_PIZZA    (0)
#define TYPE_BURGER   (1)
#define TYPE_CHICKEN  (2)
#define TYPE_DONUT    (3)

enum 	e_foods
{
	FoodType,
	FoodModel,
    FoodName[128],
    Float: FoodHealth,
	FoodPrice
}

new const FoodData[][e_foods] = 
{
	{TYPE_PIZZA, 2218, "Buster", 50.0, 150},
	{TYPE_PIZZA, 2219, "Double_D-Luxe", 100.0, 350},
	{TYPE_PIZZA, 2220, "Full_Rack", 150.0, 500},
	
	{TYPE_BURGER, 2213, "Moo_Kids_Meal", 50.0, 150},
	{TYPE_BURGER, 2214, "Beef_Tower", 100.0, 350},
	{TYPE_BURGER, 2212, "Meat_Stack", 150.0, 500},

	{TYPE_CHICKEN, 2215, "Cluckin'_Little_Meal", 50.0, 150},
	{TYPE_CHICKEN, 2216, "Cluckin'_Big_Meal", 100.0, 350},
	{TYPE_CHICKEN, 2217, "Cluckin'_Huge_Meal", 150.0, 500},
	
	{TYPE_DONUT, 2221, "Donut_Small_Pack", 50.0, 150},
	{TYPE_DONUT, 2223, "Donut_Medium_Pack", 100.0, 350},
	{TYPE_DONUT, 2222, "Donut_Large_Pack", 150.0, 500}
};

enum 	e_cctvs
{
    CameraID,
    CameraName[30],

    Float: CameraLocation[6],
    CameraInterior,
    CameraWorld,

    CameraObject,
    CameraAreaID
}

new CameraData[MAX_CCTVS][e_cctvs];
new Iterator:Cameras<MAX_CCTVS>;

enum 	e_roadblocks
{
	RoadblockID,
	RoadblockModelID,

	RoadblockName[25],
	RoadblockPlacedBy[25],
	RoadblockLocation[40],

	Float: RoadblockPos[6],
	RoadblockInterior,
	RoadblockWorld,

	RoadblockObject,
	bool: RoadblockSpikes,
	RoadblockAreaID
}

new RoadblockData[MAX_ROADBLOCKS][e_roadblocks];
new Iterator:Roadblocks<MAX_ROADBLOCKS>;

enum 	e_damages
{
	DamageTaken,
	DamageWeaponID,
	DamageBodypart,
	DamageArmor,
	DamageTime,
	DamageBy[25]
}

new DamageData[MAX_PLAYERS][MAX_DAMAGES][e_damages];
new TotalDamages[MAX_PLAYERS];

enum 	e_apbs
{
	BulletinID,
	BulletinDetails[128],
	BulletinBy,
	BulletinDate
}

new APBData[MAX_APBS][e_apbs];
new Iterator:Bullettins<MAX_APBS>;

enum 	e_meals
{
	MealModelID,
	MealObjectID,
	Float: MealPos[3],
	MealInterior,
	MealWorld,
	MealPlayerID,
	bool: MealEditing
}

new MealData[MAX_MEALS][e_meals];
new Iterator:Meals<MAX_MEALS>;

enum 	e_server_data
{
	FakeLicenseX,
	FakeLicenseY,
	FakeLicenseZ,
	FakeLicenseIcon,
	FakeLicenseMsg[35],

	MOTDLineMsg[128],
	MOTDBy[25],
	MOTDTime
}

new ServerData[e_server_data];

/*enum 	e_frequnces
{
	FrequenceID,
	rPassword[32],
	rOwner,
	rFaction,
	rHour
}

new FrequenceData[MAX_FREQUENCES][e_frequnces];*/

enum 	e_interiors 
{
	InteriorID,
	Float: InteriorX,
	Float: InteriorY,
	Float: InteriorZ,
	Float: InteriorA
}

new const Float:g_PropertyInteriors[][e_interiors] =
{
	{6, -68.4895, 1351.9392, 1080.2109, 4.9288},
	{8, -42.7541, 1405.8185, 1084.4297, 5.6207},
	{8, 2365.0811, -1135.0891, 1050.8750, 356.3250},
	{10, 24.1655, 1340.7227, 1084.3750, 5.4987},
	{9, 82.9670, 1322.9552, 1083.8662, 356.1895},
	{5, 140.4513, 1366.6266, 1083.8594, 0.5439},
	{15, 295.4811, 1472.6935, 1080.2578, 0.1319},
	{15, 328.0272, 1478.3373, 1084.4375, 351.9041},
	{15, 386.8175, 1471.8048, 1080.1875, 93.6497},
	{15, 376.6169, 1417.2181, 1081.3281, 87.2736},
	{2, 447.0533, 1397.6222, 1084.3047, 354.5509},
	{3, 234.4825, 1187.5370, 1080.2578, 351.8747},
	{6, 744.7277, 1436.7284, 1102.7031, 356.5667},
	{4, 261.0772, 1285.7340, 1080.2578, 0.9978},
	{1, 223.0771, 1287.5623, 1082.1406, 356.1723},
	{9, 260.8456, 1237.6703, 1084.2578, 357.6443},
	{4, 221.9221, 1141.2719, 1082.6094, 357.8791},
	{5, 318.4733, 1115.0323, 1083.8828, 354.3979},
	{5, 226.8602, 1113.9534, 1080.9958, 271.1856},
	{6, 233.9391, 1065.1996, 1084.2101, 357.1651},
	{7, 225.6747, 1022.4135, 1084.0149, 355.0293},
	{10, 2259.8987, -1136.3250, 1050.6328, 260.3416},
	{11, 2283.1563, -1139.6979, 1050.8984, 352.2724},
	{2, 2237.4204, -1081.0305, 1049.0234, 353.0650},
	{10, 2269.9692, -1210.5177, 1047.5625, 88.4630},
	{6, 2196.2432, -1204.6271, 1049.0234, 83.5406},
	{6, 2332.9946, -1076.7656, 1049.0234, 355.0737},
	{12, 2324.1787, -1148.5645, 1050.7101, 6.3439},
	{1, 244.1331, 304.6698, 999.1484, 265.7339},
	{2, 266.9661, 305.1599, 999.1484, 268.2738},
	{6, 343.9665, 304.7900, 999.1484, 262.2185},
	{1, 2217.6323, -1076.1080, 1050.4844, 91.8692},
	{5, 2233.4324, -1114.7819, 1050.8828, 1.5213},
	{10, 2259.9482, -1136.1741, 1050.6328, 265.8125}
};

new const Float:g_PropertyInteriorsWOF[][e_interiors] =
{
	{12, -79.9853, 1383.8722, 1078.9551, 359.2260},
	{12, -48.4819, 1458.6091, 1085.6138, 83.1559},
	{12, 45.4596, 1439.5059, 1082.4120, 83.5161},
	{12, 7.4747, 1305.6910, 1082.8309, 356.8497},
	{12, 82.7974, 1272.2775, 1079.8889, 357.2918},
	{12, 156.0716, 1410.4082, 1086.4325, 359.9312},
	{12, 290.1055, 1502.0847, 1078.4204, 352.5016},
	{12, 329.4342, 1513.3496, 1085.8153, 354.3874},
	{12, 390.1448, 1506.0529, 1080.0925, 88.6414},
	{12, 375.4148, 1378.2706, 1079.8022, 81.0770},
	{12, 448.3159, 1354.4695, 1082.2172, 3.5341},
	{12, 509.4346, 1354.3772, 1076.7826, 1.2146},
	{12, 745.3787, 1412.6329, 1102.4248, 353.5140},
	{12, 294.8513, 1285.7087, 1078.4471, 354.7286},
	{12, 191.4486, 1289.4285, 1082.1399, 359.3893},
	{12, 290.8055, 1242.6372, 1082.6812, 0.3083},
	{12, 244.2509, 1146.1193, 1081.1672, 3.6838},
	{12, 325.9058, 1075.5295, 1082.2539, 351.0508},
	{12, 199.2260, 1111.4883, 1083.2163, 2.4402},
	{12, 278.0576, 1058.3812, 1083.4525, 355.1205},
	{12, 263.6036, 978.8312, 1083.6869, 352.5047},
	{12, 2261.1641, -1121.3912, 1048.8778, 255.3701},
	{12, 2284.8135, -1126.0341, 1050.9229, 353.1727},
	{12, 2370.3208, -1094.9351, 1049.6207, 176.5558},
	{12, 2243.9141, -1028.6069, 1047.7676, 175.4189},
	{12, 2272.4177, -1242.5837, 1048.5969, 88.4237},
	{12, 2150.0820, -1217.1633, 1049.1169, 178.0771},
	{12, 2364.5439, -1074.2340, 1047.7673, 4.2320},
	{12, 2373.7942, -1183.1560, 1053.2129, 358.0608},
	{12, 242.6349, 323.0294, 999.5914, 265.0761},
	{12, 265.9531, 321.2301, 997.1435, 269.0159},
	{12, 360.9103, 303.9177, 996.8972, 268.0442},
	{12, 2189.0684, -1073.8127, 1050.4823, 81.6114},
	{12, 2255.0740, -1112.2137, 1049.1305, 357.7246},
	{12, 2297.7805, -1093.3923, 1048.8734, 83.3229}
};

new g_aAnimList[][15] = 
{
	{"Ground Sitting"},
	{"Seat"},
    {"Proned/Laying"},
    {"Hand"},
    {"Leaning"},
    {"Gang Sign"},
    {"Contact/Hit"},
    {"Greeting/Wave"},
    {"Hand Motion"},
    {"Movement"},
    {"Poiting"},
    {"Crouching"},
    {"Reloading"},
    {"Shotting"},
    {"Lose/Win Cheer"},
	{"Basketball"},
	{"Mechanic"},
	{"Boxing"},
	{"Kung Fu"},
	{"Swaying"},
	{"Standing Up"},
	{"Dancing"},
	{"Stance"}
};


/*
new const g_BusinessInteriors[][e_InteriorList] =
{
	{0,  0000.0000, 0000.0000, 0000.0000, 000.0000},
	{17, -25.884498, -185.868988, 1003.546875, 0.0},
	{10, 6.091179,-29.271898,1003.549438, 0.0},
	{1, 286.148986,-40.644397,1001.515625, 0.0},
	{7, 314.820983,-141.431991,999.601562, 0.0},
	{3, 1038.531372,0.111030,1001.284484, 0.0},
	{15, 2215.454833,-1147.475585,1025.796875, 0.0},
	{3, 833.269775,10.588416,1004.179687, 0.0},
	{3, -103.559165,-24.225606,1000.718750, 0.0},
	{6, -2240.468505,137.060440,1035.414062, 0.0},
	{0, 663.836242,-575.605407,16.343263, 0.0},
	{1, 2169.461181,1618.798339,999.976562, 0.0},
	{1, -2159.122802,641.517517,1052.381713, 0.0},
	{15, 207.737991,-109.019996,1005.132812, 0.0},
	{14, 204.332992,-166.694992,1000.523437, 0.0},
	{17, 207.054992,-138.804992,1003.507812, 0.0},
	{11, 501.980987,-69.150199,998.757812, 0.0},
	{18, -227.027999,1401.229980,27.765625, 0.0},
	{4, 457.304748,-88.428497,999.554687, 0.0},
	{10, 375.962463,-65.816848,1001.507812, 0.0},
	{9, 369.579528,-4.487294,1001.858886, 0.0},
	{5, 373.825653,-117.270904,1001.499511, 0.0},
	{5, 772.111999,-3.898649,1000.728820, 0.0},
	{6, 774.213989,-48.924297,1000.585937, 0.0},
	{7, 773.579956,-77.096694,1000.655029, 0.0},
	{3, 1212.019897,-28.663099,1000.953125, 0.0},
	{2, 1204.809936,-11.586799,1000.921875, 0.0},
	{3, 964.106994,-53.205497,1001.124572, 0.0},
	{3, -2640.762939,1406.682006,906.460937, 0.0},
	{1, -794.806396,497.738037,1376.195312, 0.0},
	{0, 2315.952880,-1.618174,26.742187, 0.0}
};*/

#define MAX_ROWS_PER_OFFLINE 25


// Default Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03
#define ACCEL_MODE              true

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

// Enumeration for storing data about the player
enum noclipenum
{
	cameramode,
	flyobject,
	mode,
	lrold,
	udold,
	lastmove,
	Float:accelmul,
    
    Float:accelrate,
    Float:maxspeed,
    bool:accel
}
new noclipdata[MAX_PLAYERS][noclipenum];

new bool:FlyMode[MAX_PLAYERS];


new obj_ship,
	obj_gate[2],
	obj_lamp[9],
	obj_board[2],
	ship_arrived,
	ship_depart,
	ship_next,
	ship_docked,
	ship_steps,
	time_truck;

stock Ship_Init()
{
	ship_steps = 0;
    ship_docked = 1;
    ship_arrived = Time();
	ship_depart = Time() + 1800;
	ship_next = Time() + 1800 + 450;

    obj_ship = CreateDynamicObject(-20014, 2838.7153, -2438.1294, 18.00, 0.0, 0.0, -90.0, 0, 0, -1);

	obj_lamp[0] = CreateDynamicObject(19123, 2810.770, -2389.310, 13.189,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[1] = CreateDynamicObject(19123, 2810.774, -2385.650, 13.180,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[2] = CreateDynamicObject(19123, 2810.774, -2390.509, 13.180,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[3] = CreateDynamicObject(19123, 2810.770, -2435.500, 13.189,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[4] = CreateDynamicObject(19123, 2810.770, -2437.900, 13.189,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[5] = CreateDynamicObject(19123, 2810.774, -2434.160, 13.180,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[6] = CreateDynamicObject(19123, 2809.958, -2392.959, 12.529,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[7] = CreateDynamicObject(19123, 2810.774, -2439.020, 13.180,0.000,0.000,0.000, 0, 0, -1);
	obj_lamp[8] = CreateDynamicObject(19123, 2810.770, -2387.310, 13.189,0.000,0.000,0.000, 0, 0, -1);

	obj_gate[0] = CreateDynamicObject(3069, 2810.893,-2388.025, 12.6151, -21.00000, 0.00000, -90.00000, 0, 0, -1);
	obj_gate[1] = CreateDynamicObject(3069, 2810.893,-2436.518, 12.61510, -21.00000, 0.00000, -90.00000, 0, 0, -1);

	obj_board[0] = CreateObject(3077, 2810.302, -2393.040, 12.621, 0.000, 0.000, -90.000);
	obj_board[1] = CreateObject(19482, 2810.302-0.1, -2393.040, 12.621+2.0, 0.000, 0.000, 180.000);
	SetObjectMaterialText(obj_board[1], sprintf("OCEAN DOCKS GEMI\nGELDIGI SAAT: %s\nKALKIS SAATI: %s\nDONUS SAATI: %s", GetShipHour(ship_arrived), GetShipHour(ship_depart), GetShipHour(ship_next)), 0, OBJECT_MATERIAL_SIZE_512x256, "Arial", 26, 1, -1, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	time_truck = 3600;
	return 1;
}

enum    e_furniture
{
	SQLID,

	ArrayID, // Ana Kategori g_aFurnitureSubCategories[ data[ArrayID] ][MainCategory];
	SubArrayID, // Alt Kategori g_aFurnitureData[ data[SubArrayID] ][SubCategory];

	ObjectID,
	TempObjectID,
	
	PropertyID,
	BusinessID,

	furnitureName[64],
	furnitureCategory,
	furnitureSubCategory,
	furniturePrice,

	Float: furnitureX,
	Float: furnitureY,
	Float: furnitureZ,
	Float: furnitureRX,
	Float: furnitureRY,
	Float: furnitureRZ,
	
	bool: furnitureLocked,
	bool: furnitureOpened,

	furnitureTexture[5]
}

enum CARGO_OBJECT_ENUM
{
	oOn,
	oObj,
	Text3D:oLabel,
	Float:oX,
	Float:oY,
	Float:oZ,
	oInt,
	oVW,
	oProduct
}

new CargoObject[MAX_CARGO_OBJ][CARGO_OBJECT_ENUM];

enum TRUCK_CARGO_ENUM
{
	tID,
	tType,
	tName[64],
	tStorage,
	tStorageSize,
	tPrice,
	tProductID,
	tProductAmount,
	tPack,
	tGps,
	tLocked,
	Float: tPosX,
	Float: tPosY,
	Float: tPosZ,
	Text3D:tLabel,
	tPickup
}	

new TruckerData[MAX_TRUCK_CARGO][TRUCK_CARGO_ENUM];
new Iterator:Trucker<MAX_TRUCK_CARGO>;

enum 	e_weapons
{
	WeaponBone,
    bool: WeaponHidden,
    Float: WeaponPos[6]
}

new WeaponSettings[MAX_PLAYERS][17][e_weapons];
new PlayerConnectionTick[MAX_PLAYERS], EditingDisplay[MAX_PLAYERS];

stock IsTakeProduct(prod)
{
	switch(prod)
	{
	    case TRUCKER_FUEL, TRUCKER_CARS, TRUCKER_MILK, TRUCKER_CEREAL, TRUCKER_COTTON, TRUCKER_DYES, TRUCKER_MALT, TRUCKER_AGGREGATE, TRUCKER_WOODS, TRUCKER_SCRAP, TRUCKER_BRICKS, TRUCKER_TRANSFORMS: return 0;
	}
	return 1;
}

new TruckerData_type[4][32] = 
{
	"özel",
	"birincil", 
	"ikincil", 
	"gemi"
};


Trucker_GetType(id)
{
	new type[14];
	switch(id)
	{
		case 0, 11: type = "metreküp";
		case 1, 2, 3, 5, 6, 7, 12, 15, 18, 20, 23 ,24: type = "kasa";
		case 4: type = "araç";
		case 8: type = "litre";
		case 9, 10, 13, 16, 19: type = "ton";
		case 14, 21: type = "çelik kasa";
		case 17: type = "kütük";
		case 22: type = "palet";
		case 25: type = "transformatör";
	}
	return type;
}

new TruckerData_product[MAX_TRUCK_PRODUCT][32] = 
{
	"yakýt", 
	"yiyecek", 
	"içecek", 
	"kýyafet", 
	"araç", 
	"mobilya", 
	"et", 
	"yumurta", 
	"süt", 
	"tahýl", 
	"pamuk", 
	"boya", 
	"araç parçasý", 
	"malt", 
	"madeni para", 
	"kaðýt", 
	"çakýl taþý", 
	"aðaç kütükleri", 
	"barut", 
	"hurda metal", 
	"çelik metal", 
	"silah", 
	"tuðla", 
	"alet edevat", 
	"meyve",
	"transformatör"
};

new biz_prod_types[12] =
	{
		23, 
		23, 
		5, 
		1, 
		21, 
		3, 
		14, 
		2, 
		-1, 
		0, 
		15,
		-1
	};

enum
{
	BUSINESS_STORE, // alet
	BUSINESS_GENERAL, // alet
	BUSINESS_PAWNSHOP, // mobilya
	BUSINESS_RESTAURANT, // yiyecek
	BUSINESS_AMMUNATION, // silah
	BUSINESS_CLOTHING, // kýyafet
	BUSINESS_BANK, // para
	BUSINESS_CLUB, // içecek
	BUSINESS_DEALERSHIP, // -1
	BUSINESS_GASSTATION, // 0
	BUSINESS_ADVERT,
	BUSINESS_CUSTOM
}

new Float: dft_attach[4] = {-0.04656, -4.26884, 0.81490, 3.54000};

new Float: forklift_attach[3][3] =
{
	{0.300000,  0.449999, -0.075000},
	{-0.449999, 0.449999, -0.075000},
	{-0.075000, 0.449999,  0.599999}
};

new Float: dft_attach_brick[3][3] =
{
    {0.04380, 1.17068, -0.46367},
	{0.04380, -1.35450, -0.46370},
	{0.04380, -3.79490, -0.4637}
};

new Float: paker_attach[2][4] =
{
	{0.00000, 0.40200, 1.85540, 15.18000},
	{-0.00730, -6.36940, 0.00000, 15.18000}
};

new Float: picador_attach[2][3] =
{
	{0.13280, -1.10310, -0.17710},
	{0.01329, -1.86198, -0.17710}
};

new Float: sadler_attach[2][3] =
{
	{0.13280, -1.10310, -0.21710},
	{0.01330, -1.86200, -0.21710}
};

new Float: bobcat_attach[3][3] =
{
	{-0.31250, -0.80650, -0.31710},
	{0.42700, -0.80650, -0.31710},
	{0.04260, -1.84000, -0.31710}
};

new Float: walton_attach[4][3] =
{
	{-0.44386, -1.00283, -0.07710},
	{0.51337, -1.10535, -0.07710},
	{0.46038, -1.85669, -0.07710},
	{-0.36452, -1.87622, -0.07710}
};

new Float: yosemite_attach[6][3] =
{
	{-0.31250, -1.00700, -0.23710},
	{0.42700, -1.00650, -0.23710},
	{0.06740, -1.70740, -0.23710},
	{0.06560, -2.40020, -0.23710},
	{0.06553, -0.99522, 0.46057},
	{0.07971, -1.69164, 0.46057}
};

new Float: yosemite_attach_brick[3] = {0.00995, -1.59382, 0.26984};//1685

enum E_PLAYER_DRUG
{
	data_id,
	player_dbid,
	drug_id,
	drug_name[64],
	Float: drug_amount,
	drug_quality,
	drug_size,
	bool: is_exist
}

new player_drug_data[MAX_PLAYERS][MAX_PACK_SLOT][E_PLAYER_DRUG];

enum e_player_packages
{
	data_id,
	player_dbid,
	weapon_id,
	weapon_ammo,
	bool: is_exist
}

new player_package_data[MAX_PLAYERS][MAX_PACK_SLOT][e_player_packages];

enum E_PROPERTY_DRUG
{
	data_id,
	property_id,
	prop_drug_id,
	prop_drug_name[64],
	Float: prop_drug_amount,
	prop_drug_quality,
	prop_drug_size,
	bool: is_exist
}

new property_drug_data[MAX_PROPERTY][MAX_PACK_SLOT][E_PROPERTY_DRUG];

enum E_VEHICLE_DRUG
{
	data_id,
	veh_id,
	veh_drug_id,
	veh_drug_name[64],
	Float: veh_drug_amount,
	veh_drug_quality,
	veh_drug_size,
	bool: is_exist
}

new vehicle_drug_data[MAX_VEHICLES][MAX_PACK_SLOT][E_VEHICLE_DRUG];

new PlayerText: drug_effect[MAX_PLAYERS];

new drug_effect_color[] =
{
    0xE07F8E20,
    0xFFFFAA20,
	0xF3AEFF20,
	0xFFCE7B20,
	0xCCFFCC20,
	0xA8E05120,
	0xFF1D9820
};

enum 	e_dropped_drugs
{
	DropType, // 1 - Silah, 2 - Uyuþturucu

	// 1 - Silah
	DropWeaponID,
	DropWeaponAmmo,
	
	// 2 - Uyuþturucu
	DropDrugID,
	Float: DropDrugAmount,
	DropDrugName[64],
	DropDrugQuality,
	DropDrugSize,

	Float: DropLocation[3],
	DropInterior,
	DropWorld,

	DroppedBy,
	DropObjID,
	DropTimer,
	DropAreaID
}

new DropData[MAX_DROP_ITEMS][e_dropped_drugs];
new Iterator:Drops<MAX_DROP_ITEMS>;

new trunk_weapons[6][2] =
{
	{0, 0},
	{25, 100},
	{29, 250},
	{31, 200},
	{43, 100},
	{34, 10}
};

new trunk_weapons_swat[6][2] =
{
	{0, 0},
	{25, 100},
	{29, 250},
	{31, 200},
	{17, 5},
	{34, 10}
};