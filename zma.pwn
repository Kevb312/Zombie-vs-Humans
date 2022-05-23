/*
	Created by [SCraZy]CaNeTa[JeFe]
	Date created 9/28/12
	Time created 5:50 PM Mountain Time Zone
*/

// Evac 0 = Can't fit the evac type || Evac 1 = Vehicle or Land Area || Evac 2 = Helicopter Vehicle on Land nor Air Area

native WP_Hash(buffer[], len, const str[]);

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#include <YSI\y_ini>

// Defines
#define function%0(%1) forward%0(%1);public%0(%1)
#define NON_IMMUNE 144,119,5,281,276,230,274,161,27,25,275,8,29,260,149,123,44,188,261,16,279,294,287
#define MAX_MAPTIME 250
#define MAX_RESTART_TIME 10000
#define MAX_MAPUPDATE_TIME 5000
#define MAX_SHOW_CP_TIME 1000
#define MAX_END_TIME 60000
#define MAX_BALANCERUPDATE_TIME 6000
#define MAX_MAP_FILES 18

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PATH "/ZMA/Users/%s.ini"
#define NAME "ZOMBIE SURVIVAL 2022"
#define SCRIPT "0.2"
#define SCRIPTER "Mr.Death"
#define SITE "samp.com"
#define chat "{FFFFFF}"
#define PLAYER_MUTE_TIME_MINUTES (5)

//Sistema de armas
static armedbody_pTick[MAX_PLAYERS];
#define ARMEDBODY_USE_HEAVY_WEAPON               (false)

#define DIALOG_REGISTER 0
#define DIALOG_LOGIN 1
#define DIALOG_RADIO 2
#define DIALOG_KICK 3
#define DIALOG_TOP 4
#define DIALOG_WARN 5
#define DIALOG_BANNED 6
#define DIALOG_CMDS 7
#define DIALOG_HELP 8
#define DIALOG_HOWTOXP 9
#define DIALOG_ACMDS 10
#define DIALOG_RULES 11
#define DIALOG_CLASS 12
#define DIALOG_CLASS_2 13
#define DIALOG_CLASS_3 14
#define DIALOG_ADMINS 15
#define DIALOG_VIPS 16
#define DIALOG_REPORT 17
#define DIALOG_REPORT_2 18
#define DIALOG_SHOUT 19
#define DIALOG_VIPINFO 20
#define DIALOG_VIP 21
#define DIALOG_VIP_CLASS 22
#define DIALOG_COINS 23

#define TEAM_ZOMBIE 0
#define TEAM_HUMAN 1

#define COLOR_PINK 0xFFC0CB77
#define COLOR_HUMAN 0x33CCFF44
#define COLOR_ZOMBIE 0x9ACD3244
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_CHAT_SERVER "{df4d49}"
#define COLOR_SERVER "{d34240}"

// Humano Clases
#define CIVILIAN 1501 // pistola con silenciador, escopeta - 0 XP
#define POLICEMAN 1502 // Shotgun,Deagle - 500 XP
#define MEDIC 1503 // Escopeta,silenciada,Pistola,Armour,curar infectados - 1000 XP
#define SCOUT 1504 // Francotirador,pistola con silenciador - 1500 XP
#define HEAVYMEDIC 1505 // Deagle,Escopeta,Armour,curar infectados - 5000 XP
#define FARMER 1506 // Deagle,AK,Condado de Rifle,Armour - 6000 XP
#define ENGINEER 1507 // Pistola con silenciador,escopeta,Armour,Cajas Build - 7500 XP
#define SWAT 1508 // MP5,Deagle,Armour,Inmunidad - 10,000 XP
#define HEAVYSHOTGUN 1509 // Escopeta,Deagle,Armour,más daño escopeta - 20,000 XP
#define ADVANCEDMEDIC 1510 // M4,Deagle,Shotgun,Cure all - 25,000 XP
#define ADVANCEDENGINEER 1511 // Deagle,M4,Armour,Build Boxes - 30,000 XP
#define FEDERALAGENT 1512 // M4,Deagle,Shotgun,Armour,Immunity - 35,000 XP
#define KICKBACK 1513 // Silenced Pistol,Shotgun,MP5 - 45000 XP
#define ADVANCEDSCOUT 1514 // Sniper,Deagle,High jump,Half Armour - 100,000 XP
#define ASSASSIN 1515 // M4,Shotgun - Plant C4's - 120,000 XP
#define VIPENGINEER 1516
#define VIPMEDIC 1517
#define VIPSCOUT 1518
#define E_ENGINEER 1519 // Deagle,Shotgun,Armour - Build Ladders - 35,000 XP
#define SOLIDER 1520 // Solider - AK47,Deagle - 6500 XP
#define DOCTOR 1521 // Silenced Pistol - Heal,Cure,Shield Heal - Rank 22
#define HERSEL 1522 //Shotgun,Armour,more shotgun - 1,000,000 xp rank 32

// Zombies Clases
#define STANDARDZOMBIE 2501 // LALT Infect a Player - 0 XP
#define MUTATEDZOMBIE 2502 // LALT Infect Drunk Vision - 500 XP
#define FASTZOMBIE 2503 // High Jump - 5000 XP
#define REAPERZOMBIE 2504 // More damage with chainsaw - 10,000 XP
#define WITCHZOMBIE 2505 // LALT 75 Damage - 18,000 XP
#define BOOMERZOMBIE 2506 // Explodes on death and infect - 20,000 XP
#define STOMPERZOMBIE 2507 // LALT Throw all around you - 25,000 XP
#define SCREAMERZOMBIE 2508 // LALT Throw everyone around you on the floor  - 35,000 XP
#define ADVANCEDMUTATED 2509 // LALT Infect all around - 65,000 XP
#define ADVANCEDSCREAMER 2510 // LALT Throw all +5hp - 70,000 XP
#define FLESHEATER 2511 // LALT Infect a player kills faster - 100,000 XP
#define ADVANCEDWITCH 2512 // LALT 99 Damage - 150,000 XP
#define ADVANCEDBOOMER 2513 // LALT Explode - 200,000 XP

#define COL_WHITE          "{FFFFFF}"
#define COL_GREY           "{C3C3C3}"
#define COL_GREEN          "{37DB45}"
#define COL_RED            "{F81414}"
#define COL_YELLOW         "{F3FF02}"
#define COL_ORANGE         "{F9B857}"
#define COL_BLUE           "{0049FF}"
#define COL_PINK           "{FF00EA}"
#define COL_LIGHTBLUE      "{00C0FF}"
#define COL_LGREEN         "{C9FFAB}"

// Variables
new time;
new mapvar;
new balvar;
new mapid;
new gateobj;
new playerOnline;
new playersAliveCount;
new DocShield;
new meatDrops[MAX_PLAYERS];
new LastMapStarted = -1;

new playedtimer[MAX_PLAYERS];
new team[MAX_PLAYERS];
new c4Obj[MAX_PLAYERS];
new PlayerShotPlayer[MAX_PLAYERS][MAX_PLAYERS];

new Text:EventText;
new Text:CurrentMap;
new Text:remadeText;
new Text:remadeText2;
new Text:AliveInfo;
new Text:TimeLeft;
new Text:UntilRescue;
new Text:XP;
new Text:Infected[MAX_PLAYERS];
new Text:iKilled[MAX_PLAYERS];
new Text:myXP[MAX_PLAYERS];
new Text:ServerIntroOne[MAX_PLAYERS];
new Text:ServerIntroTwo[MAX_PLAYERS];

new pubstring[256];
new shoutstring[256];

enum mapinfo
{
	MapName[128],
	FSMapName[128],
	Float:HumanSpawnX,
	Float:HumanSpawnY,
	Float:HumanSpawnZ,
	Float:HumanSpawn2X,
	Float:HumanSpawn2Y,
	Float:HumanSpawn2Z,
	Float:ZombieSpawnX,
	Float:ZombieSpawnY,
	Float:ZombieSpawnZ,
	Float:GateX,
	Float:GateY,
	Float:GateZ,
	Float:GaterX,
	Float:GaterY,
	Float:GaterZ,
	Float:CPx,
	Float:CPy,
	Float:CPz,
	GateID,
	MoveGate,
	AllowWater,
	Interior,
	Weather,
	Time,
	EvacType,
	IsStarted,
	XPType,
};
new Map[mapinfo];

enum playerinfo
{
	pPassword[129],
	pXP,
	pKills,
	pDeaths,
	pRank,
	pEvac,
	pAdminLevel,
	pVipLevel,
	pHour,
	pMin,
	pSec,
	pMapsPlayed,
	pCoins,
	pLogged,
	pWarnings,
	pPM,
	IsPlayerMuted,
	Killstreak,
	pHumanClass,
	pZombieClass,
	IsPlayerInfected,
	IsPlayerInfectedTimer,
	Boxes,
	BoxesAdvanced,
	C4,
	pVipKickBack,
	pVipFlash,
	pVipBoxes,
	pLadders,
	pKickBackCoin,
	pDamageShotgunCoin,
	pDamageDeagleCoin,
	pDamageMP5Coin,
	pDoctorShield
};
new pInfo[MAX_PLAYERS][playerinfo];

enum aname
{
	HighJumpScout,
	HighJumpZombie,
	StomperPushing,
	WitchAttack,
	ScreamerZombieAb,
	ScreamerZombieAb2,
	InfectionNormal,
	InfectionMutated,
	ShoutCooldown,
	HealCoolDown,
	AdvancedMutatedCooldown,
	WitchAttack2,
	InfectionFleshEater
}
new Abilitys[MAX_PLAYERS][aname];

new randomMessages[][] =
{
	"{d34240} [SERVER] {FFFFFF} Recuerda que si usas {FF0000}Cheats{FFFFFF} seras baneado Permanente mente",
 	"{d34240} [SERVER] {FFFFFF} Quieres jugar con mas realismo? descarga Mod Zombies de www.gtainside.com",
  	"{d34240} [SERVER] {FFFFFF} Recuerda sobrevivir de las ordas de zombie con tu equipo asta que la ayuda llegue",
  	"{d34240} [SERVER] {FFFFFF} ¿Te has perdido ¿Eres nuevo? prueva el comando {FF0000}/ayuda{FFFFFF}",
  	"{d34240} [SERVER] {FFFFFF} Recuerda que debe reportar los hackers y los infractores a /reportar > Elige una razón > y el ID del jugador!",
  	"{d34240} [SERVER] {FFFFFF} Invita a tus amigos y podras ganar {FF0000}VIP{FFFFFF} Y muchas mas cosas",
  	"{d34240} [SERVER] {FFFFFF} Recuerda leer las reglas para evitar que recibas baneos /reglas"
};

forward load_Map_basic(Mapid, name[], value[]);
forward LoadUser_data(playerid,name[],value[]);
forward TimeOnServer(playerid);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward GetClosestPlayer(p1);
forward RandomZombie();

main()
{
	print("\n---------------------------------------");
	print(""NAME" Cargado con la versión de "SCRIPT"");
	print("---------------------------------------\n");
}

function StartMap()
{
    foreach(Player,i)
	{
	    SetCameraBehindPlayer(i);
	    ClearAnimations(i);
		HumanSetup(i);
		SpawnPlayer(i);
		CurePlayer(i);
		SetPlayerDrunkLevel(i,0);
		DisablePlayerCheckpoint(i);
		pInfo[i][Boxes] = 10;
		pInfo[i][BoxesAdvanced] = 15;
		pInfo[i][pVipBoxes] = 100;
		pInfo[i][pLadders] = 4;
		pInfo[i][C4] = 2;
		pInfo[i][pDoctorShield] = 5;
		pInfo[i][pMapsPlayed]++;
		TextDrawHideForPlayer(i, ServerIntroOne[i]);
		TextDrawHideForPlayer(i, ServerIntroTwo[i]);
		DestroyPickup(meatDrops[i]);
		DestroyObject(DocShield);
		TogglePlayerControllable(i,1);
	}

	time = MAX_MAPTIME;

	SetWeather(Map[Weather]);
	SetWorldTime(Map[Time]);
	UpdateMapName();

    SetTimer("RandomZombie",1000,false);
    gateobj = CreateObject(Map[GateID],Map[GateX],Map[GateY],Map[GateZ],Map[GaterX],Map[GaterY],Map[GaterZ],500.0);
	mapvar = SetTimer("OnMapUpdate",MAX_MAPUPDATE_TIME,true);
	balvar = SetTimer("OnMapBalance",MAX_BALANCERUPDATE_TIME,true);
	return 1;
}

function EndMap()
{
    ClearObjects();
    DestroyAllVehicle();
	UnloadFilterScript(Map[FSMapName]);
    LoadMap(LoadNewMap());
	LoadFilterScript(Map[FSMapName]);

	SetTimer("StartMap",MAX_RESTART_TIME,false);
	GameTextForAll("~n~~n~~n~~n~~n~~g~Cargando~w~ siguiente mapa",3500,5);

	foreach(Player,i)
	{
	    ChangeCameraView(i);
	    TogglePlayerControllable(i,0);
    	TextDrawShowForPlayer(i, ServerIntroOne[i]);
		TextDrawShowForPlayer(i, ServerIntroTwo[i]);
	}

	SendClientMessageToAll(-1,""chat""COL_YELLOW" Creación de objetos...");
	return 1;
}

function OnMapUpdate()
{
	time -= 5;

	new str[64];
	format(str,sizeof(str),"%d",time);
	TextDrawSetString(TimeLeft,str);

	if(time <= 0) TextDrawSetString(TimeLeft," ..."),KillTimer(mapvar),KillTimer(balvar),SetTimer("ShowCheckpoint",MAX_SHOW_CP_TIME,false);
	return 1;
}

function ShowCheckpoint()
{
    CreateEvacMaps();
	MoveObject(gateobj,Map[GateX],Map[GateY],Map[MoveGate],3.0);
	foreach(Player,i) SetPlayerCheckpoint(i,Map[CPx],Map[CPy],Map[CPz],6.0);
	SetTimer("EndMap",MAX_END_TIME,false);
	return 1;
}

function OnMapBalance()
{
	if(playerOnline >= 2)
	{
		if(GetTeamPlayersAlive(TEAM_HUMAN) == 0)
		{
			KillTimer(balvar);
			KillTimer(mapvar);
			TextDrawSetString(TimeLeft,"~r~Zombies Ganan");
			SetTimer("EndMap",4000,false); // No se puede utilizar MAX_END_TIME porque de MAX_END_TIME se establece en 1 minuto no 4 segundos * NOTA PARA MÍ*
			foreach(Player,i)
			{
				if(team[i] == TEAM_ZOMBIE)
				{
					pInfo[i][pXP] += 30;
					GivePlayerXP(i,30);
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
	    new string[256];
	    if(Map[EvacType] == 1)
	    {
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,-1408.2051,-970.8841,198.9738);
			format(string,sizeof(string), ""chat""COL_LGREEN" %s llegado al punto de evacuación y ha recibido 1 moneda!",PlayerName(playerid));
			SendClientMessageToAll(-1,string);
			DisablePlayerCheckpoint(playerid);
			CurePlayer(playerid);
			GivePlayerXP(playerid,50);
			pInfo[playerid][pEvac]++;
			pInfo[playerid][pCoins]++;
			SetPlayerColor(playerid,COLOR_YELLOW);
		}

	    if(Map[EvacType] == 2)
	    {
			SetPlayerPos(playerid,3024.4983,447.9744,14.7813);
			SetPlayerInterior(playerid,0);
			format(string,sizeof(string), ""chat""COL_LGREEN" %s llegado al punto de evacuación del agua y ha recibido 1 moneda!",PlayerName(playerid));
			SendClientMessageToAll(-1,string);
			DisablePlayerCheckpoint(playerid);
			CurePlayer(playerid);
			GivePlayerXP(playerid,50);
			pInfo[playerid][pEvac]++;
			pInfo[playerid][pCoins]++;
			SetPlayerColor(playerid,COLOR_YELLOW);
		}

  		if(Map[EvacType] == 3)
	    {
	        SetPlayerPos(playerid,285.5,2510.30004882817,121.5);
	        SetPlayerInterior(playerid,0);
			format(string,sizeof(string), ""chat""COL_LGREEN" %s llegado al punto de evacuación por helicóptero y ha recibido 1 moneda!",PlayerName(playerid));
			SendClientMessageToAll(-1,string);
			DisablePlayerCheckpoint(playerid);
			CurePlayer(playerid);
			GivePlayerXP(playerid,50);
			pInfo[playerid][pEvac]++;
			pInfo[playerid][pCoins]++;
			SetPlayerColor(playerid,COLOR_YELLOW);
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	new string[256];
	DestroyPickup(meatDrops[playerid]);
	if(team[playerid] == TEAM_ZOMBIE)
	{
		if(pInfo[playerid][pZombieClass] == BOOMERZOMBIE) { SetPlayerHealth(playerid,50); }
		else { SetPlayerHealth(playerid,100.0); }
	}

	if(team[playerid] == TEAM_HUMAN)
	{
	    if(pInfo[playerid][pHumanClass] == ENGINEER || pInfo[playerid][pHumanClass] == ADVANCEDENGINEER || pInfo[playerid][pHumanClass] == VIPENGINEER || pInfo[playerid][pHumanClass] == E_ENGINEER)
	    {
			switch(pInfo[playerid][pHumanClass])
			{
			    case ENGINEER: pInfo[playerid][Boxes]++,GameTextForPlayer(playerid,"~g~Fundar~w~: 1 Caja",4000,5),DestroyPickup(meatDrops[playerid]);
			    case ADVANCEDENGINEER: pInfo[playerid][BoxesAdvanced] += 2,GameTextForPlayer(playerid,"~g~Fundar~w~: 2 Cajas",4000,5),DestroyPickup(meatDrops[playerid]);
			    case VIPENGINEER: pInfo[playerid][pVipBoxes] += 3,GameTextForPlayer(playerid,"~g~Fundar~w~: 3 Cajas",4000,5),DestroyPickup(meatDrops[playerid]);
			    case E_ENGINEER: pInfo[playerid][pLadders] += 1,GameTextForPlayer(playerid,"~g~Fundar~w~: 1 Escaleras",4000,5),DestroyPickup(meatDrops[playerid]);
			}
		}
		else
		{
		    if(pInfo[playerid][IsPlayerInfected] == 0)
			{
			    new slot, weap, ammo;
			    for ( slot = 0; slot < 14; slot++ )
			    {
			        GetPlayerWeaponData(playerid,slot,weap,ammo);
			        if(IsValidWeapon(weap))
			        {
			            new randomselect = random(2);
			            switch(randomselect)
			            {
			                case 0:
							{
					            new randomammo = random(50);
					            GivePlayerWeapon(playerid,weap,randomammo);
				           		format(string,sizeof(string),"~g~Fundar~w~: %d munición",randomammo);
								GameTextForPlayer(playerid,string,4000,5);
								DestroyPickup(meatDrops[playerid]);
							}
							case 1:
							{
	      						new randomxp = random(35);
				           		format(string,sizeof(string),"~g~Fundar~w~: %d XP",randomxp);
								GameTextForPlayer(playerid,string,4000,5);
        						pInfo[playerid][pXP] += randomxp;
        						DestroyPickup(meatDrops[playerid]);
							}
						}
					}
				}
			}
		}
	}
    return 1;
}

public OnGameModeInit()
{
    //UsePlayerPedAnims();
	SetGameModeText("Zombie vs Humans");
	SendRconCommand("hostname "NAME"");
	SendRconCommand("weburl "SITE"");
	SendRconCommand("language Español/English");

	AddPlayerClass(181, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AllowInteriorWeapons(1);
    DisableInteriorEnterExits();
    SetTimer("RandomMessages",59000,true);
    SetTimer("OnServerUpdate", 1000, true);

    SetTeamCount(2);

	Map[IsStarted] = 0;
	Map[XPType] = 1;
	mapid = 0;
	SetWorldTime(0);
	SetWeather(12);
	DefaultTextdraws();
	return 1;
}

function OnServerUpdate()
{
    foreach(Player, i)
    {
   		if(GetPlayerMoney(i) >= 1) return ResetPlayerMoney(i);
		SetPlayerScore(i,pInfo[i][pXP]);
		UpdateXPTextdraw(i);

		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			
		}

		new Float:armor;
		GetPlayerArmour(i,armor);
		if(armor >= 96)
		{
			
		}

		if(team[i] == TEAM_ZOMBIE)
		{
	 		switch(GetPlayerWeapon(i))
			{
				case 2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46:
				{
					ResetPlayerWeapons(i);
					GivePlayerWeapon(i,9,1);
				}
			}
	  	}

		if(team[i] == TEAM_ZOMBIE)
		{
		    if(armor > 0.0)
		    {
				SetPlayerArmour(i,0.0);
			}
		}

		if(IsPlayerInAnyVehicle(i))
	    {
			if(pInfo[i][pAdminLevel] == 0)
			{
				Kick(i);
			}
		}

		if(pInfo[i][pVipFlash] == 1)
  		{
    		switch(random(2))
   			{
				case 0: SetPlayerColor(i,COLOR_YELLOW);
				case 1: SetPlayerColor(i,COLOR_RED);
			}
		}

		DoctorShield();
		UpdateAliveInfo();
	}
	return 1;
}

public OnGameModeExit()
{
	TextDrawHideForAll(TimeLeft);
	TextDrawDestroy(TimeLeft);
	TextDrawHideForAll(UntilRescue);
	TextDrawHideForAll(AliveInfo);
	TextDrawDestroy(AliveInfo);
	TextDrawHideForAll(remadeText);
	TextDrawDestroy(remadeText);
	TextDrawHideForAll(remadeText2);
	TextDrawDestroy(remadeText2);
	TextDrawHideForAll(CurrentMap);
	TextDrawDestroy(CurrentMap);
 	TextDrawHideForAll(XP);
	TextDrawDestroy(XP);
	TextDrawHideForAll(EventText);
	TextDrawDestroy(EventText);

	for(new i; i < MAX_PLAYERS; i ++)
	{
		TextDrawHideForAll(Infected[i]);
		TextDrawHideForAll(iKilled[i]);
		TextDrawDestroy(iKilled[i]);
		TextDrawHideForAll(myXP[i]);
		TextDrawDestroy(myXP[i]);
		TextDrawHideForAll(ServerIntroOne[i]);
		TextDrawDestroy(ServerIntroOne[i]);
		TextDrawHideForAll(ServerIntroTwo[i]);
		TextDrawDestroy(ServerIntroTwo[i]);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 2416.0110,-51.3177,28.1535);
	SetPlayerFacingAngle(playerid,22.4579);
	SetPlayerCameraPos(playerid, 2412.3711,-39.9486,28.8258);
	SetPlayerCameraLookAt(playerid, 2416.0110,-51.3177,28.1535);

	if(classid == 0)
	{
	    SetPlayerTeam(playerid,TEAM_ZOMBIE);
	    team[playerid] = TEAM_ZOMBIE;
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(pInfo[playerid][pLogged] == 0)
	{
	    new string[128];
	    GameTextForPlayer(playerid,"~r~Debes entrar JUGAR",1000,4);
	 	if(fexist(UserPath(playerid)))
	    {
	        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	  		format(string,sizeof(string),""chat" Bienvenido de nuevo %s",PlayerName(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,string,""chat" Nuestro sistema ha detectado que su nombre de usuario registrado introduzca su login para entrar","Entrar","Salir");
	    }
	    else
	    {
	        format(string,sizeof(string),""chat" Hola %s a "NAME"",PlayerName(playerid));
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,string,""chat" Bienvenido a "NAME" te verás obligado a registrarse pulse crear una cuenta!","Crear","Salir");
	    }
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	playerOnline++;
    ResetVars(playerid);
    ConnectVars(playerid);
	new string[128];
 	if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_data", .bExtra = true, .extra = playerid);
  		format(string,sizeof(string),""chat" Bienvenido de nuevo %s",PlayerName(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,string,""chat" Enter your login","Login","Exit");
    }
    else
    {
        format(string,sizeof(string),""chat" Hola %s",PlayerName(playerid));
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,string,""chat" Bienvenido a "NAME" te verás obligado a registrarse pulse crear una cuenta!","Crear","Salir");
    }
	return 1;
}



public OnPlayerDisconnect(playerid, reason)
{
	if(pInfo[playerid][pLogged] == 1) { SaveStats(playerid); } else return 0;
    ResetVars(playerid);
    playersAliveCount--;
	playerOnline--;
	if(playerOnline == 0) return SendRconCommand("Nombre mapa Loading"),KillTimer(mapvar),KillTimer(balvar),Map[IsStarted] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
    playersAliveCount++;
	CheckToStartMap();
    SetPlayerInterior(playerid,Map[Interior]);

	if(team[playerid] == TEAM_ZOMBIE)
	{
		ZombieSetup(playerid);
		SetPlayerPos(playerid,Map[ZombieSpawnX],Map[ZombieSpawnY],Map[ZombieSpawnZ]);
	}

	if(team[playerid] == TEAM_HUMAN)
	{
		HumanSetup(playerid);
		switch(random(2))
		{
			case 0: SetPlayerPos(playerid,Map[HumanSpawnX],Map[HumanSpawnY],Map[HumanSpawnZ]);
			case 1: SetPlayerPos(playerid,Map[HumanSpawn2X],Map[HumanSpawn2Y],Map[HumanSpawn2Z]);
		}
	}
	sendClassMessage(playerid);
	setClass(playerid);
	SpawnVars(playerid);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
        	if(!response)
	        {
 				ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_MSGBOX,"Espulsado",""chat" Usted debe registrarse para jugar en "NAME"","Cerrar","");
				Kick(playerid);
	        }
        	if(response)
            {
                new str[256],IP[16],buf[129];
			    GetPlayerIp(playerid, IP, sizeof(IP));
                if(!strlen(inputtext))
                {
                	format(str,sizeof(str),""chat"Bienvenido a "NAME"",PlayerName(playerid));
					ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,str,""chat" Bienvenido a "NAME" te verás obligado a registrarse pulse crearse una cuenta!","Crear","Salir");
				}

                new INI:File = INI_Open(UserPath(playerid));
                WP_Hash(buf, sizeof(buf), inputtext);
                INI_SetTag(File,"data");
                INI_WriteString(File, "pPassword", buf);
			    INI_WriteInt(File,"pXP",0);
			    INI_WriteInt(File,"pKills",0);
			    INI_WriteInt(File,"pDeaths",0);
			    INI_WriteInt(File,"pRank",0);
			    INI_WriteInt(File,"pEvac",0);
			    INI_WriteInt(File,"pAdminLevel",0);
			    INI_WriteInt(File,"pVipLevel",0);
			    INI_WriteInt(File,"pHour",0);
			    INI_WriteInt(File,"pMin",0);
			    INI_WriteInt(File,"pSec",0);
			    INI_WriteInt(File,"pMapsPlayed",0);
			    INI_WriteInt(File,"pMonedas",0);
			    INI_WriteString(File,"pIP",IP);
                INI_Close(File);

				playedtimer[playerid] = SetTimerEx("TimeOnServer", 1000, 1, "i", playerid);
			    pInfo[playerid][pLogged] = 1;
            }
		}
    
    	case DIALOG_LOGIN:
        {
  			if(!response)
	        {
 				ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_MSGBOX,"Espulsado",""chat" Debes entrar a jugar en "NAME"","Cerrar","");
				Kick(playerid);
	        }
            if(response)
            {
                new buf[129];
				WP_Hash(buf, sizeof(buf), inputtext);
				if(!strcmp(buf,pInfo[playerid][pPassword]))
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_data", .bExtra = true, .extra = playerid);
                    pInfo[playerid][pLogged] = 1;
				    playedtimer[playerid] = SetTimerEx("TimeOnServer", 1000, 1, "i", playerid);
				    SendClientMessage(playerid,-1,""chat""COL_LGREEN" Conectado!");
				    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 10.0);
				    printf("%s",pInfo[playerid][pPassword]);
                }
                else
                {
                	new string[256];
			        format(string,sizeof(string),""chat" Bienvenido de nuevo %s",PlayerName(playerid));
			        ShowPlayerDialog(playerid, DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,string,""chat" Nuestro sistema ha detectado que su nombre de usuario registrado introduzca su login para entrar","Entrar","Salir");
                }
                return 1;
            }
        }

	    case DIALOG_RADIO:
	    {
	        if(response)
	        {
	            switch(listitem)
				{
		        	case 0: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/DancePop.pls");
		        	case 1: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/JPop.pls");
		        	case 2: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/Kpop.pls");
		        	case 3: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/heavyrock.pls");
		        	case 4: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/hiphop.pls");
		        	case 5: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/hiphop2.pls");
		        	case 6: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/hiphop3.pls");
		        	case 7: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/pop.pls");
		        	case 8: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/rock.pls");
		        	case 9: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/rock2.pls");
		        	case 10: PlayAudioStreamForPlayer(playerid,"http://zombie-mod.com/radio/techno.pls");
		        	case 11: StopAudioStreamForPlayer(playerid);
				}
			}
		}

		case DIALOG_CLASS:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(team[playerid] == TEAM_HUMAN)
		                {
		                	new string[1800];
		                	strcat(string,"Civil - Pistola con Silenciador,Escopeta - 0 XP\nPolicia - Deagle,Shotgun - 500 XP\nMedico -Escopeta,Pistola con Silenciador,Armour,Curar infectados - 1000 XP\n\
		                	Explorar - Francotirador,Pistola con Silenciador - 1500 XP\nPesado Medico - Deagle,Escopeta,Armour,Curar infectados - 5000 XP\nAgricultor - Deagle,AK, Condado de Rifle,Armour - 6000 XP\n");
		                	strcat(string,"Soldado - AK47,Deagle - 6500 XP\nIngeniero - Pistola con Silenciador,Escopeta,Armour,Cajas Build - 7500 XP\nS.W.A.T - MP5,Deagle,Armour,Inmunidad - 15,000 XP\n\
							Shotgun Pesado - Escopeta,Deagle,Armour,Más daño Escopeta - 20,000 XP\nAvanzado Medico - M4,Deagle,Escopeta,curar todas las infecciones - 25,000 XP\n");
		                	strcat(string,"Ingeniero Avanzado - Deagle,M4,Armour,Cajas Build - 30,000 XP\nIngeniero con Experiencia -Deagle,Shotgun,Armour - Escaleras Build - 35,000 XP\n\
							Kick Back - Silenciado Pistola,Inmunidad,escopeta,MP5 - 45000 XP\nAgente Federal - M4,Deagle,Shotgun,Armour,Inmunidad - 50,000 XP\n\
							Avanzado Explorador - Francotirador,Deagle,Salto de altura,Media Armour - 100,000 XP\nDoctor - Pistola con Silenciador - cure,curación,Escudo Heal,Media Inmunidad - 500,000 XP - rango 22");

		                	ShowPlayerDialog(playerid,DIALOG_CLASS_2,DIALOG_STYLE_LIST,"Selección de Clases (Humano)",string,"Seleccionar","Cerrar");
						}
						else return SendClientMessage(playerid,-1,""chat" Usted debe ser un ser humano para utilizar las clases humanas!");
					}

     				case 1:
		            {
              			if(team[playerid] == TEAM_ZOMBIE)
		                {
			                new string[1000];
		                    strcat(string,"Zombie Estándar - LALT Infectar a un jugador - 0 XP\nZombie Mutado - LALT Infecta Vision Drunk - 500 XP\nZombie Fast - salto alto - 5,000 XP\n\
							Reaper Zombie - Más daño con motosierra - 10,000 XP\nZombie Witch - LALT 75 Daño - 18,000 XP\n");
							strcat(string,"Boomer Zombie - Explota sobre la muerte e infectar - 20,000 XP\n\
							Stomper Zombie - LALT tiro a tu alrededor - 25,000 XP\nScreamer - LALT todos Desplegar - 35000 XP & LVL 15\nAdvanced Mutated - LALT Infecta a todos - 65,000 XP\n\
							Advanced Screamer - LALT Deseche a todos 5 hp - 70,000 XP\n");
							strcat(string,"Flesh Eater - LALT Infecta un jugador y mata más rápido - 100,000 XP\nAdvanced Witch - LALT 99 Daño - 150,000 XP\nAdvanced Boomer - LALT Explota - 500,000 X");

							ShowPlayerDialog(playerid,DIALOG_CLASS_3,DIALOG_STYLE_LIST,"Selección de Clases (Zombies)",string,"Seleccionar","Cerrar");
						}
						else return SendClientMessage(playerid,-1,""chat" Usted debe ser un zombi utilizar las clases de zombies!");
					}

					case 2: SendClientMessage(playerid,-1,""chat""COL_LGREEN" El 24 de diciembre 2017 a tener un evento de 24 horas se habilitarán estas clases alrededor de 24 de diciembre!");
				}
			}
		}

		case DIALOG_CLASS_2:
		{
		    if(response)
		    {
			    switch(listitem)
			    {
					case 0: if(pInfo[playerid][pXP] >= 0) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = CIVILIAN,setClass(playerid); else { SendXPError(playerid,0); }
					case 1: if(pInfo[playerid][pXP] >= 500) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = POLICEMAN,setClass(playerid); else { SendXPError(playerid,500); }
					case 2: if(pInfo[playerid][pXP] >= 1000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = MEDIC,setClass(playerid); else { SendXPError(playerid,1000); }
					case 3: if(pInfo[playerid][pXP] >= 1500) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = SCOUT,setClass(playerid); else { SendXPError(playerid,1500); }
					case 4: if(pInfo[playerid][pXP] >= 5000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = HEAVYMEDIC,setClass(playerid); else { SendXPError(playerid,5000); }
					case 5: if(pInfo[playerid][pXP] >= 6000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = FARMER,setClass(playerid); else { SendXPError(playerid,6000); }
					case 6: if(pInfo[playerid][pXP] >= 6500) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = SOLIDER,setClass(playerid); else { SendXPError(playerid,6500); }
					case 7: if(pInfo[playerid][pXP] >= 7500) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = ENGINEER,setClass(playerid); else { SendXPError(playerid,7500); }
					case 8: if(pInfo[playerid][pXP] >= 15000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = SWAT,setClass(playerid); else { SendXPError(playerid,10000); }
					case 9: if(pInfo[playerid][pXP] >= 20000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = HEAVYSHOTGUN,setClass(playerid); else { SendXPError(playerid,20000); }
					case 10: if(pInfo[playerid][pXP] >= 25000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = ADVANCEDMEDIC,setClass(playerid); else { SendXPError(playerid,25000); }
					case 11: if(pInfo[playerid][pXP] >= 30000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = ADVANCEDENGINEER,setClass(playerid); else { SendXPError(playerid,30000); }
					case 12: if(pInfo[playerid][pXP] >= 35000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = E_ENGINEER,setClass(playerid); else { SendXPError(playerid,35000); }
					case 13: if(pInfo[playerid][pXP] >= 45000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = KICKBACK,setClass(playerid); else { SendXPError(playerid,45000); }
					case 14: if(pInfo[playerid][pXP] >= 50000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = FEDERALAGENT,setClass(playerid); else { SendXPError(playerid,50000); }
					case 15: if(pInfo[playerid][pXP] >= 100000) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = ADVANCEDSCOUT,setClass(playerid); else { SendXPError(playerid,100000); }
					case 16: if(pInfo[playerid][pRank] >= 22) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = DOCTOR,setClass(playerid); else { SendClientMessage(playerid,-1,""chat""COL_PINK" Tienes que ser rango 22 + para utilizar este personaje"); }
				}
			}
		}

		case DIALOG_CLASS_3:
		{
		    if(response)
		    {
			    switch(listitem)
			    {
					case 0: if(pInfo[playerid][pXP] >= 0) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = STANDARDZOMBIE,setClass(playerid); else { SendXPError(playerid,0); }
					case 1: if(pInfo[playerid][pXP] >= 500) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = MUTATEDZOMBIE,setClass(playerid); else { SendXPError(playerid,500); }
					case 2: if(pInfo[playerid][pXP] >= 5000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = FASTZOMBIE,setClass(playerid); else { SendXPError(playerid,5000); }
					case 3: if(pInfo[playerid][pXP] >= 10000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = REAPERZOMBIE,setClass(playerid); else { SendXPError(playerid,10000); }
					case 4: if(pInfo[playerid][pXP] >= 18000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = WITCHZOMBIE,setClass(playerid); else { SendXPError(playerid,18000); }
					case 5: if(pInfo[playerid][pXP] >= 20000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = BOOMERZOMBIE,setClass(playerid); else { SendXPError(playerid,20000); }
					case 6: if(pInfo[playerid][pXP] >= 25000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = STOMPERZOMBIE,setClass(playerid); else { SendXPError(playerid,25000); }
					case 7: if(pInfo[playerid][pXP] >= 35000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = SCREAMERZOMBIE,setClass(playerid); else { SendXPError(playerid,35000); }
					case 8: if(pInfo[playerid][pXP] >= 65000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = ADVANCEDMUTATED,setClass(playerid); else { SendXPError(playerid,65000); }
					case 9: if(pInfo[playerid][pXP] >= 70000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = ADVANCEDSCREAMER,setClass(playerid); else { SendXPError(playerid,70000); }
					case 10: if(pInfo[playerid][pXP] >= 100000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = FLESHEATER,setClass(playerid); else { SendXPError(playerid,100000); }
					case 11: if(pInfo[playerid][pXP] >= 150000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = ADVANCEDWITCH,setClass(playerid); else { SendXPError(playerid,150000); }
					case 12: if(pInfo[playerid][pXP] >= 500000) pInfo[playerid][pZombieClass] = 0,pInfo[playerid][pZombieClass] = ADVANCEDBOOMER,setClass(playerid); else { SendXPError(playerid,500000); }
				}
			}
		}

		case DIALOG_REPORT:
		{
			if(response)
			{
			    switch(listitem)
			    {
			        case 0: pubstring = "Racismo",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 1: pubstring = "Lenguaje ofensivo",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 2: pubstring = "Airbraking",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Enter the ID you are trying to report!","Informe","");
			        case 3: pubstring = "Hacks Salud",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 4: pubstring = "Armour Hacks",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 5: pubstring = "Hacks arma",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 6: pubstring = "Spawn Killing",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
			        case 7: pubstring = "Abusar Bug",ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Parte Final","Introduzca el ID que está tratando de informar!","Informe","");
				}
			}
		}

		case DIALOG_REPORT_2:
		{
		    new reportedID;
		    reportedID = strval(inputtext);
			if(reportedID >= 101)
			{
			    ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"ID no válida "," Introduzca el ID que está tratando de informar!","Informe","");
			}
			else
			{
			    if(IsPlayerConnected(reportedID))
			    {
					new string[256];
					format(string,sizeof(string),""COL_PINK"Jugador %s(%d) ha informado %s(%d) para %s",PlayerName(playerid),playerid,PlayerName(reportedID),reportedID,pubstring);
                    SendMessageToAllAdmins(string, -1);
				}
				else return ShowPlayerDialog(playerid,DIALOG_REPORT_2,DIALOG_STYLE_INPUT,"Invalido ID","Introduzca el ID que está tratando de informar!","Informe","");
			}
		}

		case DIALOG_SHOUT:
		{
		    if(response)
		    {
			    switch(listitem)
			    {
	  				case 0: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos MEDICO!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 1: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos BOOMER ENTRANTE!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 2: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos SCREAMER ENTRANTE!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 3: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos STOMPER ENTRANTE!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 4: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos está claro!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 5: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos Zombies cercanas!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
			    	case 6: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos ZOMBIES ENTRANTE!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
	                case 7: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos Necesita ayuda!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
	                case 8: format(shoutstring,sizeof(shoutstring),""chat""COL_LIGHTBLUE" %s Gritos Necesidad de seguridad!",PlayerName(playerid)), SendHMessage(shoutstring,-1);
				}
			}
		}

		case DIALOG_VIP:
		{
		    if(response)
		    {
				switch(listitem)
				{
		    		case 0: if(pInfo[playerid][pVipLevel] >= 1) SendPlayerMaxAmmo(playerid),SendClientMessage(playerid,-1,""chat""COL_PINK" Usted tiene todas las armas con max munición!"); else { SendVipError(playerid,1); }
		    		case 1: if(pInfo[playerid][pVipLevel] >= 1) GivePlayerWeapon(playerid,31,150),GivePlayerWeapon(playerid,24,100),GivePlayerWeapon(playerid,25,600); else { SendVipError(playerid,1); }
		    		case 2: if(pInfo[playerid][pVipLevel] >= 3) ShowPlayerDialog(playerid,DIALOG_VIP_CLASS,DIALOG_STYLE_LIST,"Vip Clases (Humanos)","Vip Ingeniero (LVL 3)\nVip Medico (LVL 4)\nVip Scout (LVL 4)","seleccionar","Cerrar"); else { SendVipError(playerid,3); }
					case 3: if(pInfo[playerid][pVipLevel] >= 3) pInfo[playerid][pVipKickBack] = 1,SendClientMessage(playerid,-1,""chat""COL_LGREEN" Se ha habilitado patada VIP!"); else { SendVipError(playerid,3); }
					case 4: if(pInfo[playerid][pVipLevel] >= 3) pInfo[playerid][pVipKickBack] = 0,SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted ha inhabilitado patada VIP!"); else { SendVipError(playerid,3); }
					case 5: if(pInfo[playerid][pVipLevel] >= 2) SetPlayerAttachedObject(playerid,0,19142,1,0.028000,0.034000,0.000000,0.000000,0.000000,0.000000,1.063000,1.191999,1.285999); else { SendVipError(playerid,2); }
					case 6: if(pInfo[playerid][pVipLevel] >= 4) pInfo[playerid][pVipFlash] = 1,SendClientMessage(playerid,-1,""chat""COL_LGREEN" Su nombre está parpadeando!"); else { SendVipError(playerid,4); }
            		case 7: if(pInfo[playerid][pVipLevel] >= 4) pInfo[playerid][pVipFlash] = 0,SendClientMessage(playerid,-1,""chat""COL_LGREEN" Su nombre ha dejado de parpadear"); else { SendVipError(playerid,4); }
					case 8: if(pInfo[playerid][pVipLevel] >= 4) SetPlayerArmour(playerid,50.0),SendClientMessage(playerid,-1,""chat""COL_LGREEN" Tienes 50.0f VIP Armour"); else { SendVipError(playerid,4); }
				}
			}
		}

		case DIALOG_VIP_CLASS:
		{
			if(response)
			{
			    if(team[playerid] == TEAM_HUMAN)
			    {
					switch(listitem)
					{
					    case 0: if(pInfo[playerid][pVipLevel] >= 3) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = VIPENGINEER,setClass(playerid); else { SendVipError(playerid,3); }
		                case 1: if(pInfo[playerid][pVipLevel] >= 4) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = VIPMEDIC,setClass(playerid); else { SendVipError(playerid,4); }
		                case 2: if(pInfo[playerid][pVipLevel] >= 4) pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = VIPSCOUT,setClass(playerid); else { SendVipError(playerid,4); }

					}
				}
				else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted debe ser un ser humano para utilizar las clases VIP!");
			}
		}

		case DIALOG_COINS:
		{
			if(response)
			{
			    if(team[playerid] == TEAM_HUMAN)
			    {
			        switch(listitem)
			        {
						case 0: if(pInfo[playerid][pCoins] >= 45) pInfo[playerid][pCoins] -= 45,pInfo[playerid][pKickBackCoin] = 1; else { SendCoinError(playerid,45); }
						case 1: if(pInfo[playerid][pCoins] >= 40) pInfo[playerid][pCoins] -= 40,pInfo[playerid][pDamageShotgunCoin] = 1; else { SendCoinError(playerid,40); }
						case 2: if(pInfo[playerid][pCoins] >= 50) pInfo[playerid][pCoins] -= 50,pInfo[playerid][pDamageDeagleCoin] = 1; else { SendCoinError(playerid,50); }
						case 3: if(pInfo[playerid][pCoins] >= 30) pInfo[playerid][pCoins] -= 30,pInfo[playerid][pDamageMP5Coin] = 1; else { SendCoinError(playerid,30); }
						case 4: if(pInfo[playerid][pCoins] >= 25) pInfo[playerid][pCoins] -= 20,pInfo[playerid][pHumanClass] = 0,pInfo[playerid][pHumanClass] = FEDERALAGENT; else { SendCoinError(playerid,20); }
						case 5: if(pInfo[playerid][pCoins] >= 30) pInfo[playerid][pCoins] -= 25,SetPlayerAttachedObject(playerid,0,19142,1,0.028000,0.034000,0.000000,0.000000,0.000000,0.000000,1.063000,1.191999,1.285999); else { SendCoinError(playerid,25); }
						case 6: if(pInfo[playerid][pCoins] >= 800) pInfo[playerid][pCoins] -= 800,pInfo[playerid][pVipLevel] = 2; else { SendCoinError(playerid,800); }
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new string[256],gunname[32];

	SendDeathMessage(killerid, playerid, reason);
    playersAliveCount--;

	pInfo[playerid][pDeaths]++;
	pInfo[playerid][Killstreak] = 0;

	if(pInfo[playerid][IsPlayerInfected] == 1)
	{
		ZombieSetup(playerid);
	    CurePlayer(playerid);
	    printf("Obras humanas infectadas!");
	}

	if(team[playerid] == TEAM_HUMAN)
	{
 		ZombieSetup(playerid);
 		printf("Obras humanas suicidas!");
	}

	pInfo[killerid][pKills]++;
	pInfo[killerid][Killstreak]++;
	pInfo[playerid][pDeaths]++;
	pInfo[playerid][Killstreak] = 0;

	switch(Map[XPType])
	{
	    case 1:
	    {
			switch(random(2))
			{
			    case 0: GivePlayerXP(killerid,10);
			    case 1: GivePlayerXP(killerid,20);
			}
		}

  		case 2:
	    {
			switch(random(2))
			{
			    case 0: GivePlayerXP(killerid,20);
			    case 1: GivePlayerXP(killerid,30);
			}
		}

  		case 3:
	    {
			switch(random(2))
			{
			    case 0: GivePlayerXP(killerid,30);
			    case 1: GivePlayerXP(killerid,40);
			}
		}

		case 4:
	    {
			switch(random(2))
			{
			    case 0: GivePlayerXP(killerid,40);
			    case 1: GivePlayerXP(killerid,50);
			}
		}
	}

	if(pInfo[killerid][pVipLevel] >= 1)
	{
	    switch(Map[XPType])
	    {
			case 1:
			{
				switch(random(2))
				{
				    case 0: GivePlayerXP(killerid,15),SendClientMessage(killerid,-1,""chat" Trabajo 15 XP de VIP Doble XP! + normal xp 10 = 25 xp total");
				    case 1: GivePlayerXP(killerid,25),SendClientMessage(killerid,-1,""chat" Trabajo 25 XP de VIP Doble XP! + normal xp 20 = 45 xp total");
				}
			}

			case 2:
			{
				switch(random(2))
				{
				    case 0: GivePlayerXP(killerid,25),SendClientMessage(killerid,-1,""chat" Trabajo 25 XP de VIP Doble XP! + doble xp 20 = 45 xp total");
				    case 1: GivePlayerXP(killerid,35),SendClientMessage(killerid,-1,""chat" Trabajo 35 XP de VIP Doble XP! + doble xp 30 = 65 xp total");
				}
			}

			case 3:
			{
				switch(random(2))
				{
				    case 0: GivePlayerXP(killerid,35),SendClientMessage(killerid,-1,""chat" Trabajo 35 XP de VIP Doble XP! + triple xp 30 = 65 xp total");
				    case 1: GivePlayerXP(killerid,45),SendClientMessage(killerid,-1,""chat" Trabajo 45 XP de VIP Doble XP! + triple xp 40 = 85 xp total");
				}
			}

			case 4:
			{
				switch(random(2))
				{
				    case 0: GivePlayerXP(killerid,55),SendClientMessage(killerid,-1,""chat" Trabajo 55 XP de VIP Doble XP! + cuádruple xp 40 = 95 xp total");
				    case 1: GivePlayerXP(killerid,65),SendClientMessage(killerid,-1,""chat" Trabajo 65 XP de VIP Doble XP! + cuádruple xp 50 = 115 xp total");
				}
			}
		}
	}

	if(team[killerid] == TEAM_ZOMBIE)
	{
		if(reason == 9)
		{
			ZombieSetup(playerid);
			printf("Zombie mató obras humanas");
		}
	}

	KillTimer(pInfo[playerid][IsPlayerInfectedTimer]);

	GetWeaponName(reason,gunname,sizeof(gunname));
	format(string,sizeof(string),"Has matado~r~ %s~w~ con un %s",PlayerName(playerid),gunname);
	TextDrawSetString(iKilled[killerid],string);
	TextDrawShowForPlayer(killerid, iKilled[killerid]);
	SetTimerEx("Ocultar Killed", 3000, 0, "i", killerid);

	if(killerid != INVALID_PLAYER_ID)
	{
		if(!PlayerShotPlayer[killerid][playerid])
		{
			new Admin[24] = "Anti-cheat";
			new reason3[128] = "Fake Killing";
			BanPlayer(playerid,reason3,Admin);
		}
	}

	foreach(Player,i)
	{
		PlayerShotPlayer[i][playerid] = 0;
	}

	new Float:x,Float:y,Float:z;
	if(team[playerid] == TEAM_ZOMBIE)
	{
	    GetPlayerPos(playerid,Float:x,Float:y,Float:z);
	    meatDrops[playerid] = CreatePickup(2804,19,Float:x,Float:y,Float:z,0);

	    if(pInfo[playerid][pZombieClass] == BOOMERZOMBIE)
		{
	        GetPlayerPos(playerid,Float:x,Float:y,Float:z);
	        CreateExplosion(Float:x,Float:y,Float:z,0,6.0);
	        foreach(Player,i)
			{
	            GetClosestPlayer(i);
	            if(IsPlayerConnected(i))
				{
                 	switch(GetPlayerSkin(i))
	                {
                        case NON_IMMUNE:
						{
		                    if(IsPlayerInRangeOfPoint(i,7.0,Float:x,Float:y,Float:z))
							{
								if(pInfo[i][IsPlayerInfected] == 0)
								{
								    InfectPlayerStandard(i);
								}
		                    }
						}
	                }
	            }
	        }
	    }
	}

	new kstring[256];
	switch(pInfo[killerid][Killstreak])
	{
	    case 5: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 5 killstreak "COL_WHITE"(+50 XP) (1 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 50,pInfo[killerid][pCoins] += 1;
	    case 10: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 10 killstreak "COL_WHITE"(+80 XP) (2 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 80,pInfo[killerid][pCoins] += 2;
	    case 15: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 15 killstreak "COL_WHITE"(+100 XP) (3 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 100,pInfo[killerid][pCoins] += 3;
	    case 20: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 20 killstreak "COL_WHITE"(+150 XP) (4 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 150,pInfo[killerid][pCoins] += 4;
	    case 25: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 25 killstreak "COL_WHITE"(+200 XP) (5 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 200,pInfo[killerid][pCoins] += 5;
	    case 30: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 30 killstreak "COL_WHITE"(+250 XP) (6 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 250,pInfo[killerid][pCoins] += 6;
	    case 35: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 35 killstreak "COL_WHITE"(+350 XP) (7 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 350,pInfo[killerid][pCoins] += 7;
	    case 40: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 40 killstreak "COL_WHITE"(+500 XP) (8 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 500,pInfo[killerid][pCoins] += 8;
	    case 45: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 45 killstreak "COL_WHITE"(+600 XP) (9 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 600,pInfo[killerid][pCoins] += 9;
	    case 50: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 50 killstreak "COL_WHITE"(+800 XP) (10 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 800,pInfo[killerid][pCoins] += 10;
	    case 55: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 55 killstreak "COL_WHITE"(+950 XP) (11 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 950,pInfo[killerid][pCoins] += 11;
	    case 60: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 60 killstreak "COL_WHITE"(+1000 XP) (12 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1000,pInfo[killerid][pCoins] += 12;
	    case 65: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 65 killstreak "COL_WHITE"(+1200 XP) (13 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1200,pInfo[killerid][pCoins] += 13;
	    case 70: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 70 killstreak "COL_WHITE"(+1500 XP) (14 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1500,pInfo[killerid][pCoins] += 14;
	    case 75: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 75 killstreak "COL_WHITE"(+1600 XP) (15 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1600,pInfo[killerid][pCoins] += 15;
	    case 80: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 80 killstreak "COL_WHITE"(+1800 XP) (16 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1800,pInfo[killerid][pCoins] += 16;
	    case 85: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 85 killstreak "COL_WHITE"(+1900 XP) (17 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 1900,pInfo[killerid][pCoins] += 17;
	    case 90: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 90 killstreak "COL_WHITE"(+2000 XP) (18 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 2000,pInfo[killerid][pCoins] += 18;
	    case 95: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 95 killstreak "COL_WHITE"(+5000 XP) (19 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 5000,pInfo[killerid][pCoins] += 19;
	    case 100: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 100 killstreak "COL_WHITE"(+5500 XP) (20 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 5500,pInfo[killerid][pCoins] += 20;
	    case 105: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 105 killstreak "COL_WHITE"(+6000 XP) (21 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 6000,pInfo[killerid][pCoins] += 21;
 	    case 110: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 110 killstreak "COL_WHITE"(+6500 XP) (22 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 6500,pInfo[killerid][pCoins] += 22;
	    case 115: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 115 killstreak "COL_WHITE"(+7000 XP) (23 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 7000,pInfo[killerid][pCoins] += 23;
 	    case 120: format(kstring,sizeof(kstring),""chat""COL_PINK" %s ha logrado un 120 killstreak "COL_WHITE"(+7500 XP) (24 Monedas)",PlayerName(killerid)), SendClientMessageToAll(-1,kstring), pInfo[killerid][pXP] += 7500,pInfo[killerid][pCoins] += 24;
	}

	if(team[killerid] == TEAM_HUMAN)
	{
		if(GetPlayerSkin(killerid) == 0)
		{
			
	    }
	}

	hideTextdrawsAfterConnect(playerid);
	CheckToLevelOrRankUp(killerid);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
    PlayerShotPlayer[issuerid][playerid] = 1;

	if(team[issuerid] == TEAM_HUMAN)
	{
	    if(pInfo[issuerid][pHumanClass] == KICKBACK || pInfo[issuerid][pVipKickBack] == 1 || pInfo[issuerid][pKickBackCoin])
	    {
	        if(team[playerid] == TEAM_ZOMBIE)
	        {
        		if(weaponid == 23 || weaponid == 25 || weaponid == 24 || weaponid == 34 || weaponid == 31)
				{
				    new Float:x,Float:y,Float:z,Float:angle;
				    GetPlayerFacingAngle(playerid,Float:angle);
				    GetPlayerVelocity(playerid,Float:x,Float:y,Float:z);

		  			SetPlayerVelocity(playerid,Float:x+0.1,Float:y+0.1,Float:z+0.2);
		  			SetPlayerFacingAngle(playerid,Float:angle);
				}
		    }
		}
	}

	if(team[issuerid] == TEAM_HUMAN)
	{
	    if(pInfo[issuerid][pHumanClass] == VIPSCOUT)
	    {
	        if(team[playerid] == TEAM_ZOMBIE)
	        {
	            if(weaponid == 34)
	            {
	            	SetPlayerHealth(playerid, -0);
				}
			}
		}
	}

	if(team[issuerid] == TEAM_HUMAN)
	{
 		if(pInfo[issuerid][pHumanClass] == SCOUT || pInfo[issuerid][pHumanClass] == HEAVYSHOTGUN || pInfo[issuerid][pHumanClass] == KICKBACK || pInfo[issuerid][pDamageShotgunCoin] == 1)
		{
 			if(team[playerid] == TEAM_ZOMBIE)
	    	{
  				if(weaponid == 34 || 25)
				{
			        new Float:hp;
			        GetPlayerHealth(playerid,hp);
					SetPlayerHealth(playerid, hp - 45);
				}
			}
		}
	}

	if(team[issuerid] == TEAM_HUMAN)
	{
 		if(pInfo[issuerid][pDamageMP5Coin] == 1 || pInfo[issuerid][pDamageDeagleCoin] == 1)
		{
 			if(team[playerid] == TEAM_ZOMBIE)
	    	{
  				if(weaponid == 24 || 29)
				{
			        new Float:hp;
			        GetPlayerHealth(playerid,hp);
					SetPlayerHealth(playerid, hp - 45);
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid, "SPS Apagado") == 0)
	{
		SetPVarInt(playerid, "SPS Los mensajes enviados", GetPVarInt(playerid, "SPS Los mensajes enviados") + 1);
		SetTimerEx("SPS_eliminar_Mensajes_limitar", 1500, 0, "i", playerid);

		if(GetPVarInt(playerid, "SPS Los mensajes enviados") >= 4)
		{
		    if(!(((GetPVarInt(playerid, "SPS Advertencias de Spam") + 2) == 3)))
		    SetPVarInt(playerid, "SPS Advertencias de Spam", GetPVarInt(playerid, "SPS Advertencias de Spam") + 1);
		}

		if(pInfo[playerid][pLogged] == 1)
		{
	        new stringbig[356];
	        if(pInfo[playerid][IsPlayerMuted] == 1) {
	            SendClientMessage(playerid,-1,""chat" Usted está silenciado");
	            return 0;
			}

			format(stringbig,sizeof(stringbig),"(%d): %s",playerid, text);
	  		SendPlayerMessageToAll(playerid,stringbig);

	        if(strfind(text, ":", true) != -1) {
	            new i_numcount, i_period, i_pos;
	            while(text[i_pos]) {
	                if('0' <= text[i_pos] <= '9') i_numcount ++;
	                else if(text[i_pos] == '.') i_period ++;
	                i_pos++;
	            }
	            if(i_numcount >= 8 && i_period >= 3) {
		            new reason[128];
		            new Admin[24] = "Anti-Cheat";
					format(reason,sizeof(reason),"Anuncio %s",text);

					BanPlayer(playerid,reason,Admin);
	                return 0;
	            }
	        }
	    }
	}
	else
	{
		SendClientMessage(playerid, -1, ""chat""COL_LIGHTBLUE" Usted está silenciado, no puede hablar.");
		return 0;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(pInfo[playerid][pAdminLevel] >= 5)
	{
		SendClientMessage(playerid,-1,""chat" Bienvenida");
	}
	else
	{
		new Float:posxx[3];
		GetPlayerPos(playerid, posxx[0], posxx[1], posxx[2]);
		SetPlayerPos(playerid, posxx[0], posxx[1], posxx[2]+2);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
	    switch(GetPlayerWeapon(playerid))
	    {
	        case 2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,26,27,28,32,35,36,37,38,39,40,41,42,43,44,45,46:
	        {
	            
			}
		}
	}

	if(PRESSED(KEY_FIRE))
	{
 		if(team[playerid] == TEAM_HUMAN)
 		{
	    	switch(GetPlayerWeapon(playerid))
			{
	            case 9: ShowPlayerDialog(playerid,DIALOG_KICK,DIALOG_STYLE_MSGBOX,"Explulsado por bug","Has sido expulsado para el bug motosierra reconectar para resolver el problema","dejar",""),Kick(playerid);
			}
		}
	}

	if(PRESSED(KEY_YES))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(gettime() - 8 < Abilitys[playerid][ShoutCooldown]) return GameTextForPlayer(playerid,"~w~ Cannot shout wait 8 seconds!",1000,5);
			{
				ShowPlayerDialog(playerid,DIALOG_SHOUT,DIALOG_STYLE_LIST,"Seleccione un grito!","Medico\nBoomer Entrante\nScreamer Entrante\nStomper entrante\nEsta claro\nZOMBIES CERCA!\nZOMBIES ENTRANTE\nNecesita ayuda\nNecesidad de seguridad","Seleccionar","Cancelar");
        		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
                Abilitys[playerid][ShoutCooldown] = gettime();
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == E_ENGINEER)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][pLadders] >= 1)
				{
				    new string[128];
				    pInfo[playerid][pLadders] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
        			CreateObject(1437,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes% i escaleras que quedan",pInfo[playerid][pLadders]);
					SendClientMessage(playerid,-1,string);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin escalas!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == VIPENGINEER)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][pVipBoxes] >= 1)
				{
				    new string[128];
				    pInfo[playerid][pVipBoxes] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
        			CreateObject(1421,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes cajas que dejé",pInfo[playerid][pVipBoxes]);
					SendClientMessage(playerid,-1,string);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin cajas!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == ENGINEER)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][Boxes] >= 1)
				{
				    new string[128];
				    pInfo[playerid][Boxes] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
        			CreateObject(1421,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes cajas que dejé",pInfo[playerid][Boxes]);
					SendClientMessage(playerid,-1,string);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin cajas!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == ADVANCEDENGINEER)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][BoxesAdvanced] >= 1)
				{
				    new string[128];
				    pInfo[playerid][BoxesAdvanced] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
        			CreateObject(1421,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes cajas que dejé",pInfo[playerid][BoxesAdvanced]);
					SendClientMessage(playerid,-1,string);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin cajas!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == DOCTOR)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][pDoctorShield] >= 1)
				{
				    new string[128];
				    pInfo[playerid][pDoctorShield] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
        			DocShield = CreateObject(3534,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes a Doctor escudos dejó",pInfo[playerid][pDoctorShield]);
					SendClientMessage(playerid,-1,string);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin escudos!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_HUMAN)
	    {
	        if(pInfo[playerid][pHumanClass] == ASSASSIN)
	        {
         		new Float:pz, Float:x, Float:y, Float:z;
				GetPlayerFacingAngle(playerid, pz);
				GetPlayerPos(playerid, Float:x, Float:y, Float:z);

				if(pInfo[playerid][C4] >= 1)
				{
				    new string[128];
				    pInfo[playerid][C4] -= 1;
 					GetXYInFrontOfPlayer(playerid, Float:x,Float:y, 1.0);
 					ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 2000);
        			c4Obj[playerid] = CreateObject(1654,Float:x,Float:y,Float:z,0.0,0.0,pz,500.0);
					format(string,sizeof(string),""chat" Tienes% i izquierda del C4",pInfo[playerid][C4]);
					SendClientMessage(playerid,-1,string);

     				GameTextForPlayer(playerid,"~n~~n~~n~~n~~g~Plantado c4 explotó en 10 segundos",3500,5);
     				SetTimerEx("C4Explode",10000,0,"i",playerid);
					GivePlayerXP(playerid,5);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				}
				else return SendClientMessage(playerid,-1,""chat" Te has quedado sin c4 de!");
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_ZOMBIE)
	    {
			if(pInfo[playerid][pZombieClass] == STOMPERZOMBIE)
			{
                if(gettime() - 6 < Abilitys[playerid][StomperPushing]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
			    {
			        new Float:x,Float:y,Float:z,Float:Angle;
			        GetPlayerPos(playerid,Float:x,Float:y,Float:z);
			        GetPlayerFacingAngle(playerid,Float:Angle);
					foreach(Player,i)
					{
      					switch(GetPlayerSkin(i))
						{
       						case NON_IMMUNE,163,70:
							{
                        	    if(GetDistanceBetweenPlayers(playerid,i) < 6.0)
                        	    {
							    	GetClosestPlayer(i);
									GetPlayerFacingAngle(i,Float:Angle);
									GetPlayerVelocity(i,Float:x,Float:y,Float:z);
									SetPlayerVelocity(i,Float:x+0.3,Float:y+0.3,Float:z+0.2);
									SetPlayerFacingAngle(i,Float:Angle);
									GivePlayerXP(playerid,20);
									Abilitys[playerid][StomperPushing] = gettime();
								}
							}
						}
					}
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_ZOMBIE)
	    {
			if(pInfo[playerid][pZombieClass] == ADVANCEDMUTATED)
			{
                if(gettime() - 10 < Abilitys[playerid][AdvancedMutatedCooldown]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
			    {
					foreach(Player,i)
					{
      					switch(GetPlayerSkin(i))
						{
       						case NON_IMMUNE:
							{
                        	    if(GetDistanceBetweenPlayers(playerid,i) < 6.5)
                        	    {
							    	if(pInfo[i][IsPlayerInfected] == 0)
							    	{
										InfectPlayerStandard(i);
										GivePlayerXP(playerid,20);
										Abilitys[playerid][AdvancedMutatedCooldown] = gettime();
									}
								}
							}
						}
					}
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_ZOMBIE)
	    {
			if(pInfo[playerid][pZombieClass] == SCREAMERZOMBIE)
			{
			    if(gettime() - 9 < Abilitys[playerid][ScreamerZombieAb]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
			    {
					foreach(Player,i)
					{
          				switch(GetPlayerSkin(i))
     					{
     					    case NON_IMMUNE:
							{
	                            if(GetDistanceBetweenPlayers(playerid,i) < 5.0)
	                            {
							    	GetClosestPlayer(i);
	                                ApplyAnimation(i, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
	                                GameTextForPlayer(i,"~n~~n~~n~~n~~g~Screamer atacado",3500,5);
	                                SetTimerEx("ScreamerClearAnim",1500,0,"i",i);
									GivePlayerXP(playerid,15);
									Abilitys[playerid][ScreamerZombieAb] = gettime();
								}
							}
						}
					}
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
	    if(team[playerid] == TEAM_ZOMBIE)
	    {
			if(pInfo[playerid][pZombieClass] == ADVANCEDSCREAMER)
			{
			    if(gettime() - 12 < Abilitys[playerid][ScreamerZombieAb2]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
			    {
					foreach(Player,i)
					{
          				switch(GetPlayerSkin(i))
     					{
     					    case NON_IMMUNE:
							{
	                            if(GetDistanceBetweenPlayers(playerid,i) < 8.0)
	                            {
	                                new Float:hp;
							    	GetClosestPlayer(i);
	                                ApplyAnimation(i, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
	                                GameTextForPlayer(i,"~n~~n~~n~~n~~g~Advanced Screamer Atacado",3500,5);
	                                SetTimerEx("ScreamerClearAnim",1500,0,"i",i);
									GivePlayerXP(playerid,20);
									GetPlayerHealth(playerid,hp);
									Abilitys[playerid][ScreamerZombieAb2] = gettime();
									if(hp <= 80)
									{
										GetPlayerHealth(playerid,hp);
										SetPlayerHealth(playerid,hp+10);
									}
									else return SendClientMessage(playerid,-1,""chat""COL_PINK" Gritó con éxito, pero no fue capaz de ganar HP ya tiene suficiente HP (80)");
								}
							}
						}
					}
				}
			}
		}
	}

   	if(PRESSED(KEY_WALK))
 	{
 	    if(team[playerid] == TEAM_HUMAN)
 	    {
  			if(pInfo[playerid][pHumanClass] == ADVANCEDMEDIC)
  			{
  			    new victimid = GetClosestPlayer(playerid);
	       		if(IsPlayerConnected(victimid))
				{
     				switch(GetPlayerSkin(victimid))
					{
         				case NON_IMMUNE:
						{
							if(GetDistanceBetweenPlayers(playerid,victimid) < 10.0)
							{
		    					if(pInfo[victimid][IsPlayerInfected] == 1)
								{
							    	CurePlayer(victimid);
									GivePlayerXP(playerid,20);
								}
								else return SendClientMessage(playerid,-1,""chat" Nadie a su alrededor está infectado");
							}
						}
					}
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
 	{
 	    if(team[playerid] == TEAM_ZOMBIE)
 	    {
  			if(pInfo[playerid][pZombieClass] == FASTZOMBIE)
  			{
  			    if(gettime() - 6 < Abilitys[playerid][HighJumpZombie]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
  			    {
					new Float:x,Float:y,Float:z;
					GetPlayerVelocity(playerid,Float:x,Float:y,Float:z);
   					SetPlayerVelocity(playerid,Float:x,Float:y*1.0,Float:z+0.8* 1.2);
					Abilitys[playerid][HighJumpZombie] = gettime();
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
 	{
 	    if(team[playerid] == TEAM_HUMAN)
 	    {
  			if(pInfo[playerid][pHumanClass] == ADVANCEDSCOUT)
  			{
  			    if(gettime() - 6 < Abilitys[playerid][HighJumpScout]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",1000,5);
  			    {
					new Float:x,Float:y,Float:z;
					GetPlayerVelocity(playerid,Float:x,Float:y,Float:z);
   					SetPlayerVelocity(playerid,Float:x,Float:y*0.9,Float:z+0.5* 0.9);
   					Abilitys[playerid][HighJumpScout] = gettime();
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
		if(team[playerid] == TEAM_ZOMBIE)
		{
		    if(pInfo[playerid][pZombieClass] == WITCHZOMBIE)
		    {
  				new victimid = GetClosestPlayer(playerid);
	       		if(IsPlayerConnected(victimid))
				{
       		 		switch(GetPlayerSkin(victimid))
				    {
                        case NON_IMMUNE,70:
						{
							if(GetDistanceBetweenPlayers(playerid,victimid) < 1.5)
							{
	      						if(gettime() - 9 < Abilitys[playerid][WitchAttack]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",4000,5);
	            				{
	                				new Float:hp,zmstring[256];
					                GetPlayerHealth(victimid,hp);
									SetPlayerHealth(victimid, hp -45);
									GameTextForPlayer(victimid,"~n~~n~~n~~n~~y~Witched atacado",3000,5);
									GivePlayerXP(playerid,15);
									format(zmstring,sizeof(zmstring), ""chat""COL_PINK" %s ha sido atacado por bruja %s",PlayerName(victimid),PlayerName(playerid));
									SendClientMessageToAll(-1,zmstring);
									Abilitys[playerid][WitchAttack] = gettime();
								}
							}
						}
					}
				}
			}
		}
	}

	if(PRESSED(KEY_WALK))
	{
		if(team[playerid] == TEAM_ZOMBIE)
		{
		    if(pInfo[playerid][pZombieClass] == ADVANCEDWITCH)
		    {
  				new victimid = GetClosestPlayer(playerid);
	       		if(IsPlayerConnected(victimid))
				{
       		 		switch(GetPlayerSkin(victimid))
				    {
                        case NON_IMMUNE,70:
						{
							if(GetDistanceBetweenPlayers(playerid,victimid) < 1.5)
							{
	      						if(gettime() - 15 < Abilitys[playerid][WitchAttack2]) return GameTextForPlayer(playerid,"~w~ Aún recuperándose",4000,5);
	            				{
	                				new Float:hp,zmstring[256];
					                GetPlayerHealth(victimid,hp);
									SetPlayerHealth(victimid, hp -99);
									GameTextForPlayer(victimid,"~n~~n~~n~~n~~y~Avanzado Witched atacado",3000,5);
									GivePlayerXP(playerid,15);
									format(zmstring,sizeof(zmstring), ""chat""COL_PINK" %s ha sido atacado por bruja avanzada %s",PlayerName(victimid),PlayerName(playerid));
									SendClientMessageToAll(-1,zmstring);
									Abilitys[playerid][WitchAttack2] = gettime();
								}
							}
						}
					}
				}
			}
		}
	}

 	if(PRESSED(KEY_WALK))
	{
 		if(team[playerid] == TEAM_ZOMBIE)
	    {
	 		if(pInfo[playerid][pZombieClass] == STANDARDZOMBIE)
	   		{
				new victimid = GetClosestPlayer(playerid);
				if(gettime() - 7 < Abilitys[playerid][InfectionNormal]) return GameTextForPlayer(playerid,"~b~ Aún recuperándose",4000,5);
				{
		       		if(IsPlayerConnected(victimid))
					{
      					switch(GetPlayerSkin(victimid))
						{
                            case NON_IMMUNE:
							{
								if(GetDistanceBetweenPlayers(playerid,victimid) < 2.0)
								{
								    if(pInfo[victimid][IsPlayerInfected] == 0)
								    {
								    	new zmstring[256];
										InfectPlayerStandard(victimid);
										format(zmstring,sizeof(zmstring), ""chat""COL_PINK" %s ha sido infectado por %s",PlayerName(victimid),PlayerName(playerid));
										SendClientMessageToAll(-1,zmstring);
										GivePlayerXP(playerid,20);
										Abilitys[playerid][InfectionNormal] = gettime();
									}
									else return SendClientMessage(playerid,-1,""chat" Jugador ya está infectado!");
								}
							}
						}
					}
	            }
	        }
		 }
    }

   	if(PRESSED(KEY_WALK))
	{
 		if(team[playerid] == TEAM_ZOMBIE)
	    {
	 		if(pInfo[playerid][pZombieClass] == MUTATEDZOMBIE)
	   		{
				new victimid = GetClosestPlayer(playerid);
				if(gettime() - 7 < Abilitys[playerid][InfectionMutated]) return GameTextForPlayer(playerid,"~b~ Aún recuperándose",4000,5);
				{
		       		if(IsPlayerConnected(victimid))
					{
      					switch(GetPlayerSkin(victimid))
						{
                            case NON_IMMUNE:
							{
								if(GetDistanceBetweenPlayers(playerid,victimid) < 1.7)
								{
				    				if(pInfo[victimid][IsPlayerInfected] == 0)
								    {
									    new zmstring[256];
										InfectPlayerMutated(victimid);
										format(zmstring,sizeof(zmstring), ""chat""COL_PINK" %s ha sido infectado por %s",PlayerName(victimid),PlayerName(playerid));
										SendClientMessageToAll(-1,zmstring);
										GivePlayerXP(playerid,20);
										Abilitys[playerid][InfectionMutated] = gettime();
									}
									else return SendClientMessage(playerid,-1,""chat" Jugador ya está infectado!");
				                }
							}
						}
					}
	            }
	        }
		 }
    }

   	if(PRESSED(KEY_WALK))
	{
 		if(team[playerid] == TEAM_ZOMBIE)
	    {
	 		if(pInfo[playerid][pZombieClass] == FLESHEATER)
	   		{
				new victimid = GetClosestPlayer(playerid);
				if(gettime() - 18 < Abilitys[playerid][InfectionFleshEater]) return GameTextForPlayer(playerid,"~b~ Aún recuperándose",4000,5);
				{
		       		if(IsPlayerConnected(victimid))
					{
      					switch(GetPlayerSkin(victimid))
						{
                            case NON_IMMUNE,285,70:
							{
								if(GetDistanceBetweenPlayers(playerid,victimid) < 1.7)
								{
				    				if(pInfo[victimid][IsPlayerInfected] == 0)
								    {
									    new zmstring[256];
										InfectPlayerFleshEater(victimid);
										format(zmstring,sizeof(zmstring), ""chat""COL_PINK" %s ha sido mordido e infectado por %s",PlayerName(victimid),PlayerName(playerid));
										SendClientMessageToAll(-1,zmstring);
										GivePlayerXP(playerid,10);
										Abilitys[playerid][InfectionFleshEater] = gettime();
									}
									else return SendClientMessage(playerid,-1,""chat" Jugador ya está infectado!");
				                }
							}
						}
					}
	            }
	        }
		 }
    }

	if(PRESSED(KEY_WALK))
	{
		if(team[playerid] == TEAM_ZOMBIE)
	    {
			if(pInfo[playerid][pZombieClass] == ADVANCEDBOOMER)
			{
			    if(IsPlayerInRangeOfPoint(playerid,8.0,Map[ZombieSpawnX],Map[ZombieSpawnY],Map[ZombieSpawnZ]))
			    {
			        GameTextForPlayer(playerid,"~r~No se puede explotar cerca de desove Zombie!",4000,5);
				}
				else
				{
				    new Float:x,Float:y,Float:z;
			        GetPlayerPos(playerid,Float:x,Float:y,Float:z);
			        SetPlayerHealth(playerid,0.0);
			        CreateExplosion(Float:x,Float:y,Float:z,0,6.0);
			        foreach(Player,i)
					{
			            GetClosestPlayer(i);
			            if(IsPlayerConnected(i))
						{
		                 	switch(GetPlayerSkin(i))
			                {
		                        case NON_IMMUNE:
								{
				                    if(IsPlayerInRangeOfPoint(i,7.0,Float:x,Float:y,Float:z))
									{
										if(pInfo[i][IsPlayerInfected] == 0)
										{
										    InfectPlayerStandard(i);
										}
				                    }
								}
			                }
			            }
			        }
				}
		    }
		}
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{

}

public OnPlayerUpdate(playerid)
{
	new Float:hp;
	GetPlayerHealth(playerid,hp);
    if(hp <= 1.0) return SetPlayerHealth(playerid,-1.0);

	if(Map[AllowWater] == 0)
	{
    	if(IsPlayerInWater(playerid))
		{
		SetPlayerHealth(playerid,0.0);
		}
	}
	//Sistema de armas By Miwi
    if(GetTickCount() - armedbody_pTick[playerid] > 113){
    //GetPlayerWeaponData(giveplayerid, slot, xweapon, xbalas);
    new weaponid[13],weaponammo[13],pArmedWeapon;
    pArmedWeapon = GetPlayerWeapon(playerid);
    GetPlayerWeaponData(playerid,3,weaponid[3],weaponammo[3]);
    GetPlayerWeaponData(playerid,4,weaponid[4],weaponammo[4]);
    GetPlayerWeaponData(playerid,5,weaponid[5],weaponammo[5]);
    GetPlayerWeaponData(playerid,6,weaponid[6],weaponammo[6]);

              #if ARMEDBODY_USE_HEAVY_WEAPON
              GetPlayerWeaponData(playerid,7,weaponid[7],weaponammo[7]);
              #endif
              if(weaponid[3] && weaponammo[3] > 10){
              if(pArmedWeapon != weaponid[3]){
              if(!IsPlayerAttachedObjectSlotUsed(playerid,2)){
              SetPlayerAttachedObject(playerid,2,GetWeaponModel(weaponid[3]),1,0.193999,-0.168000,0.146999,7.299998,164.599929,-1.000000,1.000000,1.000000,1.000000);
              }
              }
              else
              {
              if(IsPlayerAttachedObjectSlotUsed(playerid,2)){
              RemovePlayerAttachedObject(playerid,2);
              }
              }
              }
              else if(IsPlayerAttachedObjectSlotUsed(playerid,2)){
              RemovePlayerAttachedObject(playerid,2);
              }
              if(weaponid[4] && weaponammo[4] > 10){
              if(pArmedWeapon != weaponid[4]){
              if(!IsPlayerAttachedObjectSlotUsed(playerid,3)){
              SetPlayerAttachedObject(playerid,3,GetWeaponModel(weaponid[4]),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
              }
              }
              else
              {
              if(IsPlayerAttachedObjectSlotUsed(playerid,3)){
              RemovePlayerAttachedObject(playerid,3);
              }
              }
              }
              else if(IsPlayerAttachedObjectSlotUsed(playerid,3))
              {
              RemovePlayerAttachedObject(playerid,3);
              }
              if(weaponid[5] && weaponammo[5] > 10){
              if(pArmedWeapon != weaponid[5]){
              if(!IsPlayerAttachedObjectSlotUsed(playerid,4)){
              SetPlayerAttachedObject(playerid,4,GetWeaponModel(weaponid[5]),1,0.189999,-0.148000,-0.050999,4.500000,-149.799987,0.000000,1.000000,1.000000,1.000000);
              }
              }
              else
              {
              if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
              RemovePlayerAttachedObject(playerid,4);
              }
              }
              }
              else if(IsPlayerAttachedObjectSlotUsed(playerid,4))
              {
              RemovePlayerAttachedObject(playerid,4);
              }
              if(weaponid[6] && weaponammo[6] > 10){
              if(pArmedWeapon != weaponid[6]){
              if(!IsPlayerAttachedObjectSlotUsed(playerid,5))
              {
              SetPlayerAttachedObject(playerid,5,GetWeaponModel(weaponid[6]),1,0.193999,-0.168000,0.146999,7.299998,164.599929,-1.000000,1.000000,1.000000,1.000000);
              }
              else
              {
              if(IsPlayerAttachedObjectSlotUsed(playerid,5)){
              RemovePlayerAttachedObject(playerid,5);
              }
              }
              }
              }
              else if(IsPlayerAttachedObjectSlotUsed(playerid,5)){
              RemovePlayerAttachedObject(playerid,5);
              }
              #if ARMEDBODY_USE_HEAVY_WEAPON
              if(weaponid[7] > 10){
              if(pArmedWeapon != weaponid[7]){
              if(!IsPlayerAttachedObjectSlotUsed(playerid,4)){
              SetPlayerAttachedObject(playerid,4,GetWeaponModel(weaponid[7]),1,-0.100000, 0.000000, -0.100000, 84.399932, 112.000000, 10.000000, 1.099999, 1.000000, 1.000000);
              }
              }
              else{
              if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
              RemovePlayerAttachedObject(playerid,4);
              }
              }
              }
              else if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
              RemovePlayerAttachedObject(playerid,4);
              }
              #endif
              armedbody_pTick[playerid] = GetTickCount();
              }
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		PlayerPlaySound(playerid,1054,0.0,0.0,0.0),
		SendClientMessage(playerid,-1,""chat" Comando incorrecta tratar /ayuda o /cmds");
	}
	return 1;
}

CMD:skip(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 5)
	{
		time = 5;
	}
	return 1;
}

// ****************** COMMANDS ********************** //
CMD:remove(playerid) return RemovePlayerAttachedObject(playerid,1);

CMD:dance1(playerid)
{
	if(team[playerid] == TEAM_ZOMBIE)
	{
 		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted debe ser un zombi para utilizar este comando!");
	return 1;
}

CMD:dance2(playerid)
{
	if(team[playerid] == TEAM_ZOMBIE)
	{
 		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted debe ser un zombi para utilizar este comando!");
	return 1;
}

CMD:dance3(playerid)
{
	if(team[playerid] == TEAM_ZOMBIE)
	{
 		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted debe ser un zombi para utilizar este comando!");
	return 1;
}

CMD:dance4(playerid)
{
	if(team[playerid] == TEAM_ZOMBIE)
	{
 		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Usted debe ser un zombi para utilizar este comando!");
	return 1;
}

CMD:stop(playerid) return ClearAnimations(playerid);

CMD:vipmenu(playerid)
{
	if(pInfo[playerid][pVipLevel] >= 1)
	{
	    new str[300];
	    strcat(str,"Vip Munición ilimitada (LVL1+)\nVip Armas (LVL1+)\nVip Clases (LVL3+)\nHabilitar Kick Back (LVL3+)\nDesactivar Kick Back (LVL3+)\n\
		Vip S.W.A.T Armour Objecto (LVL2+)\nVip Nombre Flash (LVL 4+)\nDesactivar Nombre flash Vip (LVL 4+)\nVip Armour (LVL 4+)");
	    ShowPlayerDialog(playerid,DIALOG_VIP,DIALOG_STYLE_LIST,"Vip Menu",str,"seleccionar","Cerrar");
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Necesita al menos un paquete VIP para utilizar este comando!");
	return 1;
}

CMD:rank(playerid)
{
	new str[800];
	strcat(str,"10 Kills - rango 1\n50 Kills - rango 2\n100 Kills - rango 3\n150 Kills - rango 4\n200 Kills - rango 5\n250 Kills - rango 6\n300 Kills - rango 7\n\
	350 Kills - rango 8\n400 Kills - rango 9\n450 Kills - rango 10\n500 Kills - rango 11\n550 Kills - rango 12\n600 Kills - rango 13\n650 Kills - rango 14\n\
	700 Kills - rango 15\n750 Kills - rango 16\n800 Kills - rango 17\n850 Kills - rango 18\n900 Kills - rango 19\n950 Kills - rango 20\n");

	strcat(str,"1000 Kills - rango 21\n1500 Kills - rango 22\n2000 Kills - rango 23\n2500 Kills - rango 24\n3000 Kills - rango 25\n3500 Kills - rango 26\n\
	4000 Kills - rango 27\n4500 Kills - rango 28\n5000 Kills - rango 29\n5500 Kills - rango 30\n6000 Kills - rango 31\n6500 Kills - rango 32");
	ShowPlayerDialog(playerid,5326,DIALOG_STYLE_MSGBOX,"rango lista",str,"cerrar","");
	return 1;
}

CMD:vip(playerid)
{
	new vipinfo[600];
	strcat(vipinfo,""chat" Hola cuando usted depende donar la cantidad que donó\nSe obtiene lo que se llama un paquete VIP que le permite configurar el paquete actual\nCon montón de características impresionantes\n\
	Para octener mas informacion sobre el paquete VIP hable con Miwi !");
	ShowPlayerDialog(playerid,DIALOG_VIPINFO,DIALOG_STYLE_MSGBOX,"Vip Info",vipinfo,"Cerrar","");
	return 1;
}

CMD:reglas(playerid)
{
	new rules[600];
    strcat(rules, "No uses {FF0000}Hack{FFFFFF} O seras baneado");
    strcat(rules, "\n");
    strcat(rules, "No insultes por el chat a otro jugador");
    strcat(rules, "\n");
    strcat(rules, "No insultes a un administrador o seras advertido o kickeado");
    strcat(rules, "\n");
    strcat(rules, "Respetas las normativas del servidor");
    strcat(rules, "\n");
    strcat(rules, "Cualquier tipo de spam/insulto/nombre de otro servidor seras baneado");
    strcat(rules, "\n");
    strcat(rules, "Recuerda evitar el SpawnKill o seras cambiado de equipo al instante");
    strcat(rules, "\n");
    strcat(rules, "Evita ser complice de un cheat y reportalo o tu tambien seras baneado");
    ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_MSGBOX, "Reglas del servidor", rules, "Aceptar", "");
}

CMD:ayuda(playerid)
{
	new helpstring[300];
    strcat(helpstring, "Hola Te habla {FF0000}Miwi{FFFFFF} Te dare una mano");
    strcat(helpstring, "\n");
    strcat(helpstring, "Para ganar scopre necesitas matar al equipo contrario");
    strcat(helpstring, "\n");
    strcat(helpstring, "Para ganar rango necesitas scopre usa /rangos para ver la informacion");
    strcat(helpstring, "\n");
    strcat(helpstring, "Cuando el cronometro llegue a 0 tienes que ir al punto de salida");
    strcat(helpstring, "\n");
    strcat(helpstring, "Recuerda invitar a tus amigos para que sea mas divertido :3");
    ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_MSGBOX, "Ayuda Del servidor", helpstring, "Aceptar", "");
}

CMD:cmds(playerid)
{
	new cmdstring[500];
    strcat(cmdstring,"/quitarprendas - Quitar los toys\n/compartirxp - Comparte con tus amigos tu scopre\n/rango - Lista de los rango\n/vip - Consulte nuestras características Donación!\nPulse la tecla 'Y' para gritar\n/bailar1 - animación Danza\n/bailar2 - animación Danza\n/bailar3 - animación Danza\n/bailar4 - animación Danza\n/reglas - Lista de reglas del servidor\n\
	/ayuda - para que no te pierdas\n/curar - Cura a un jugador infectado\n/sanar - Da vida a un humano\n");
	strcat(cmdstring,"/kill - Matarte a ti mismo\n/equipo - Revise su equipo\n\
	/radio - Lista de los géneros de radio\n/pm - Mensaje personal\n/bloquear - Bloquea a las personas del PM \n/desbloquear - desbloquear a las personas\n/ss - Guardar las estadísticas\n/stats - Revise sus estadísticas\n");
    ShowPlayerDialog(playerid,DIALOG_CMDS,DIALOG_STYLE_MSGBOX,"Comandos del servidor!",cmdstring,"Cerrar","");
	return 1;
}

CMD:level1(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/wslap, /a, /z, /h, /advertir, /kick");
		ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level2(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/nextmapa, /setzombie, /sethuman, /slap, /ann, /akill, /goto, /callar, /descallar ");
        ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level3(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/ann2, /clima, /tiempo, /ip, /get ");
        ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level4(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/darmonedas ");
        ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level5(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/darxp, /explotar ");
        ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level6(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/banear, /xp, /setsp ");
		ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level7(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}Nohay por ahora ");
		ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:level8(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new acmdstring[300];
		strcat(acmdstring,"{F9FF35}/setlevel, /setvip, ");
		ShowPlayerDialog(playerid,DIALOG_ACMDS,DIALOG_STYLE_MSGBOX,"Comandos administradores",acmdstring,"Cerrar","");
	}
	return 1;
}

CMD:Codigos(playerid)
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
	    new cstring[600];
	    strcat(cstring,"HS - Hacks Salud (Permanent)\nMD -Modo Dios (Permanent)\nAB - Air Break (Permanent)\nHV- Hacks velocidad (Permanent)\nHA - Hacks de Arma (Permanent)\n\
		SK - Spawnkill (exageró)\nFH - Fly hacks (Permanent)\nOH - Otros hacks (Permanent)\nHV - Hacks Vehículo (Permanent)\nBF - Blasfemia");
		ShowPlayerDialog(playerid,9511,DIALOG_STYLE_MSGBOX,"Códigos de Baneo",cstring,"Cerrar","");
	}
	return 1;
}

CMD:curar(playerid,params[])
{
	if(team[playerid] == TEAM_HUMAN)
	{
		if(pInfo[playerid][pHumanClass] == MEDIC || pInfo[playerid][pHumanClass] == ADVANCEDMEDIC || pInfo[playerid][pHumanClass] == HEAVYMEDIC || pInfo[playerid][pHumanClass] == VIPMEDIC || pInfo[playerid][pHumanClass] == DOCTOR)
		{
			new targetid,string[128],str[256];
			if(sscanf(params,"u", targetid)) return SendClientMessage(playerid,-1,""chat" /curar [Jugador]");

			if(pInfo[targetid][IsPlayerInfected] == 1)
			{
				CurePlayer(targetid);
				format(string,sizeof(string),"~n~~n~~n~~n~~g~%s~w~ %s te ha curado",GetClassName(playerid),PlayerName(playerid));
				GameTextForPlayer(targetid,string,3500,5);
				format(str,sizeof(str),""chat""COL_LGREEN" %s %s ha curado %s",GetClassName(playerid),PlayerName(playerid),PlayerName(targetid));
				SendClientMessageToAll(-1,str);
				GivePlayerXP(playerid,20);
			}
			else return SendClientMessage(playerid,-1,""chat" El jugador que está tratando de curar no está infectado");
		}
		else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Tendrá que ser un Medico y Medico Avanzado o VIP Medico para utilizar este comando!");
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Tendrá que ser un humano para utilizar este comando!");
	return 1;
}

CMD:sanar(playerid,params[])
{
	if(gettime() - 15 < Abilitys[playerid][HealCoolDown]) return GameTextForPlayer(playerid,"~w~ Cannot heal wait 15 seconds!",1000,5);
	{
		if(team[playerid] == TEAM_HUMAN)
		{
			if(pInfo[playerid][pHumanClass] == HEAVYMEDIC || pInfo[playerid][pHumanClass] == ADVANCEDMEDIC || pInfo[playerid][pHumanClass] == VIPMEDIC || pInfo[playerid][pHumanClass] == DOCTOR)
			{
				new targetid,string[128],str[256];
				if(sscanf(params,"u", targetid)) return SendClientMessage(playerid,-1,""chat" /sanar [playerid]");
				new Float:hp;
				GetPlayerHealth(targetid,hp);
				if(team[targetid] == TEAM_HUMAN)
				{
					if(hp >= 80)
					{
						SendClientMessage(playerid,-1,""chat" Ese jugador ya tiene suficiente salud para sobrevivir");
					}
					else
					{
						if(pInfo[playerid][pHumanClass] == HEAVYMEDIC || pInfo[playerid][pHumanClass] == ADVANCEDMEDIC)
						{
							SetPlayerHealth(targetid,hp+5);
							format(string,sizeof(string),"~n~~n~~n~~n~~g~%s~w~ %s te ha sanado (New HP: %.2f)",GetClassName(playerid),PlayerName(playerid),hp);
							GameTextForPlayer(targetid,string,3500,5);
							format(str,sizeof(str),""chat""COL_LGREEN" %s %s ha sanado %s (NEW HP: %.2f HP)",GetClassName(playerid),PlayerName(playerid),PlayerName(targetid),hp,PlayerName(targetid));
							SendClientMessageToAll(-1,str);
							GivePlayerXP(playerid,20);
							Abilitys[playerid][HealCoolDown] = gettime();
						}
						else if(pInfo[playerid][pHumanClass] == VIPMEDIC)
						{
							SetPlayerHealth(targetid,hp+20);
							format(string,sizeof(string),"~n~~n~~n~~n~~g~%s~w~ %s te ha sanado (by %.2f HP)",GetClassName(playerid),PlayerName(playerid),hp);
							GameTextForPlayer(targetid,string,3500,5);
							format(str,sizeof(str),""chat""COL_LGREEN" %s %s ha sanado %s by (NEW HP: %.2f HP)",GetClassName(playerid),PlayerName(playerid),PlayerName(targetid),hp);
							SendClientMessageToAll(-1,str);
							GivePlayerXP(playerid,20);
							Abilitys[playerid][HealCoolDown] = gettime();
						}

						else if(pInfo[playerid][pHumanClass] == DOCTOR)
						{
							SetPlayerHealth(targetid,hp+40);
							format(string,sizeof(string),"~n~~n~~n~~n~~g~%s~w~ %s te ha sanado (by %.2f HP)",GetClassName(playerid),PlayerName(playerid),hp);
							GameTextForPlayer(targetid,string,3500,5);
							format(str,sizeof(str),""chat""COL_LGREEN" %s %s ha sanado %s by (NEW HP: %.2f HP)",GetClassName(playerid),PlayerName(playerid),PlayerName(targetid),hp);
							SendClientMessageToAll(-1,str);
							GivePlayerXP(playerid,35);
							Abilitys[playerid][HealCoolDown] = gettime();
						}
					}
				}
				else return SendClientMessage(playerid,-1,""chat" No puedes curar a zombies!");
			}
			else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Tendrá que ser un Medico y Medico Avanzado o VIP Medico para utilizar este comando!");
		}
		else return SendClientMessage(playerid,-1,""chat""COL_LGREEN" Tendrá que ser un humano para utilizar este comando!");
	}
	return 1;
}

CMD:kill(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
	    SetPlayerHealth(playerid,0.0);
	    SendClientMessage(playerid,-1,""chat" Te has suicidado");
	}
	else return SendClientMessage(playerid,-1,""chat" No te puedes matar a ti mismo si eres un 'zombi'");
	return 1;
}

CMD:admins(playerid, params[])
{


	if(pInfo[playerid][pHour] >= 0)
	{
    #pragma unused params
    new conteo,titulo[128],strc[256],nameid[256];
	GetPlayerName(playerid,nameid,sizeof(nameid));
	format(strc,sizeof(strc),">>>>%s Posible Hacker usando el comando /Admins<<<<",nameid);
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
    if(IsPlayerAdmin(i))
    {
    conteo++;
    }
    else if(pInfo[i][pAdminLevel] >= 1)
    {
    conteo++;
    }
    }
    if(conteo == 0)return ShowPlayerDialog(playerid, 4564, DIALOG_STYLE_MSGBOX, "{FF0000}<!>Admin Bot Activado Server Protegido<!>", "{FFFFFF}[BoT]AdminZnC {5DD88E} Administrador Bot Activado ", "OK", ""); //esto para cuando no alla admins , No saldra el menu
    format(titulo,128,"Admins Conectados: {FFFFFF}|| %d ||",conteo);

	new adminstring[128];
    if(IsPlayerConnected(playerid))
	    {
	        for (new i = 0; i < MAX_PLAYERS; i++)
	        {
	            if(IsPlayerConnected(i))
	            {
    new targetid,level[256];
    if(pInfo[i][pAdminLevel] > 0)
	                {
	                    format(adminstring, sizeof(adminstring),"{FFFFFF}%s%s: %s {00FF00} Administradores\n",GetAdminName(playerid),PlayerName(playerid),level,PlayerName(targetid));
	                }
	            }
	        }
	        ShowPlayerDialog(playerid,DIALOG_ADMINS,DIALOG_STYLE_MSGBOX,"Administradores Conectados",adminstring,"Cerrar","");
		}
 		else return SendClientMessage(playerid,-1,""chat" No hay administradores conectados");
	}

    return 1;
}

CMD:vips(playerid, params[])
{
	if(pInfo[playerid][pHour] >= 0)
	{
	    new adminstring[128];
	    if(IsPlayerConnected(playerid))
	    {
	        for (new i = 0; i < MAX_PLAYERS; i++)
	        {
	            if(IsPlayerConnected(i))
	            {
	                if(pInfo[i][pVipLevel] > 0)
	                {
	                    format(adminstring, sizeof(adminstring),"%sLevel %d: %s\n", adminstring, pInfo[i][pVipLevel], PlayerName(i));
	                }
	            }
	        }
	        ShowPlayerDialog(playerid,DIALOG_VIPS,DIALOG_STYLE_MSGBOX,"V.I.Ps Conectados",adminstring,"Cerrar","");
		}
 		else return SendClientMessage(playerid,-1,""chat" No hay V.I.Ps Conectados");
	}

    return 1;
}

CMD:equipo(playerid)
{
	new strteam[128];
	switch(team[playerid])
	{
	    case TEAM_ZOMBIE: strteam = "Zombies";
	    case TEAM_HUMAN: strteam = "Humano";
	}

	new str[128];
	format(str,sizeof(str),""chat" Su actual equipo es %s",strteam);
	SendClientMessage(playerid,-1,str);
	return 1;
}

CMD:clases(playerid,params[])
{
	if(team[playerid] == TEAM_HUMAN)
	{
		if(time >= 150)
		{
			ShowPlayerDialog(playerid,DIALOG_CLASS,DIALOG_STYLE_LIST,"Seleccionar clases","Humano Clases\nZombies Clases\nEvento navideño :3","Seleccionar","Cerrar");
		}
		else return SendClientMessage(playerid,-1,""chat" 100 segundos ha pasado! no puede seleccionar una clase más!");
	}
	else return ShowPlayerDialog(playerid,DIALOG_CLASS,DIALOG_STYLE_LIST,"Seleccionar clases","Humano Clases\nZombies Clases\n","Seleccionar","Cerrar");
	return 1;
}

CMD:nextmapa(playerid,params[])
{
	if(pInfo[playerid][pLogged] == 1)
	{
		if(pInfo[playerid][pAdminLevel] >= 2)
		{
			new map,stringmap[256];
			if(sscanf(params,"i", map)) return SendClientMessage(playerid,-1,""chat" /nextmapa [mapaid]");

			format(stringmap,sizeof(stringmap),""chat""COL_LIGHTBLUE" %s %s configurar siguiente mapa id para %i",GetAdminName(playerid),PlayerName(playerid),map);
			SendClientMessageToAll(-1,stringmap);
			mapid = map;
		}
	}
	return 1;
}

CMD:setzombie(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 2)
    {
        if(IsPlayerConnected(playerid))
        {
			new targetid,str[256];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid,-1,""chat" /setzombie [playerid]");
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

			ZombieSetup(targetid);
			SpawnPlayer(targetid);
			format(str,sizeof(str),""chat""COL_LGREEN" Administrador %s(%i) ha puesto a su equipo Zombie",PlayerName(playerid),playerid);
			SendClientMessage(targetid,-1,str);
			format(str,sizeof(str),""chat""COL_LGREEN" Has cambiado %s(%i) equipo a Zombie!",PlayerName(targetid),targetid);
			SendClientMessage(playerid,-1,str);
		}
	}
	return 1;
}

CMD:sethuman(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 2)
    {
        if(IsPlayerConnected(playerid))
        {
			new targetid,str[256];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid,-1,""chat" /sethuman [playerid]");
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

			HumanSetup(targetid);
			SpawnPlayer(targetid);
			format(str,sizeof(str),""chat""COL_LGREEN" Administrador %s(%i) ha puesto a su equipo Humano",PlayerName(playerid),playerid);
			SendClientMessage(targetid,-1,str);
			format(str,sizeof(str),""chat""COL_LGREEN" Has cambiado %s(%i) equipo a Humano!",PlayerName(targetid),targetid);
			SendClientMessage(playerid,-1,str);
		}
	}
	return 1;
}

CMD:banear(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 6)
    {
        if(IsPlayerConnected(playerid))
        {
			new targetid,reason[105],string[256];
			if(sscanf(params, "us[105]", targetid,reason)) return SendClientMessage(playerid,-1,""chat" /banear [jugadorid] [Razón]");
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha baneado %s [Razón: %s]",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),reason);
			SendClientMessageToAll(-1,string);

			BanPlayer(targetid,reason,PlayerName(playerid));
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}


CMD:radio(playerid)
{
	new string[256];
	strcat(string,"Dance Pop\nJPop\nKPop\nHeavy Rock\nHip Hop\nHip Hop 2\nHip Hop 3\nPop\nRock\nRock 2\nTechno\nStop Radio!");
	ShowPlayerDialog(playerid,DIALOG_RADIO,DIALOG_STYLE_LIST,"Seleccionar una radio!",string,"Seleccionar","Cerrar");
	return 1;
}

CMD:getid(playerid,params[])
{
	new found, string[128], playername[MAX_PLAYER_NAME];
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
	    if(isnull(params)) return SendClientMessage(playerid, -1, ""chat" /getid [PartOfName] ");
	    format(string,sizeof(string),""chat" Searched for: \"%s\"",params);
	    SendClientMessage(playerid, -1,string);
	    for(new i=0; i <= MAX_PLAYERS; i++)
	    {
	        if(IsPlayerConnected(i))
	        {
	            GetPlayerName(i, playername, MAX_PLAYER_NAME);
	            new namelen = strlen(playername);
	            new bool:searched=false;
	            for(new pos=0; pos <= namelen; pos++)
	            {
	                if(searched != true)
	                {
	                    if(strfind(playername,params,true) == pos)
	                    {
	                        found++;
	                        format(string,sizeof(string),""chat" %d. %s (ID: %d)",found,playername,i);
	                        SendClientMessage(playerid, -1 ,string);
	                        searched = true;
	                    }
	                }
	            }
	        }
	    }
	    if(found == 0)
	    SendClientMessage(playerid, -1, ""chat" Jugadores no localizados!");
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:borrarchat(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new reason[105], string[256];
	    if(sscanf(params, "s[105]", reason)) return SendClientMessage(playerid,-1,""chat" /borrarchat [Rszón]");

		ClearChat();
		format(string,sizeof(string), ""chat""COL_LIGHTBLUE" %s %s borrado el chat [Razón: %s]",GetAdminName(playerid),PlayerName(playerid),reason);
		SendClientMessageToAll(-1,string);
	}
	else {
	    SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:setlevel(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 6)
	{
		new targetid,level,string[256];
		if(sscanf(params, "ud", targetid, level)) return  SendClientMessage(playerid,-1,""chat" /setlevel [playerid] [level]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");
		if(level < 0 || level > 8) return SendClientMessage(playerid,-1,""chat"  Niveles de administradores son sólo entre 1-7");

        pInfo[targetid][pAdminLevel] = level;

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha dado estado de administración a %d to %s",GetAdminName(playerid),PlayerName(playerid),level,PlayerName(targetid));
		SendClientMessageToAll(-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:setvip(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 6)
	{
		new targetid,level,string[256];
		if(sscanf(params, "ud", targetid, level)) return  SendClientMessage(playerid,-1,""chat" /setvip [playerid] [level]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");
		if(level < 0 || level > 4) return SendClientMessage(playerid,-1,""chat" Niveles VIP son sólo entre 1-4");

        pInfo[targetid][pVipLevel] = level;

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha dado estado vip %d to %s",GetAdminName(playerid),PlayerName(playerid),level,PlayerName(targetid));
		SendClientMessageToAll(-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:slap(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2 || IsPlayerAdmin(playerid))
	{
	    new targetid,string[256];
		if(sscanf(params, "u", targetid)) return  SendClientMessage(playerid,-1,""chat" /slap [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		new Float:posxx[3];
		GetPlayerPos(targetid, posxx[0], posxx[1], posxx[2]);
		SetPlayerPos(targetid, posxx[0], posxx[1], posxx[2]+40);

		if(IsPlayerAdmin(playerid))
		{
	   		format(string, sizeof(string), ""chat" RCON Admin ha slapeado %s",PlayerName(targetid));
			SendClientMessageToAll(-1,string);
		}
		else
		{
			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha slapeado %s",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid));
			SendClientMessageToAll(-1,string);
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:wslap(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
	    new targetid,string[256];
		if(sscanf(params, "u", targetid)) return  SendClientMessage(playerid,-1,""chat" /wslap [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		new Float:posxx[3];

		GetPlayerPos(targetid, posxx[0], posxx[1], posxx[2]);
		SetPlayerPos(targetid, posxx[0], posxx[1], posxx[2]+4);

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha advertido con slap %s",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid));
		SendClientMessageToAll(-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:a(playerid,params[])
{
	new adminstring[256];
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
	    if(!strlen(params))
	    {
	        SendClientMessage(playerid, -1, ""chat" /a [message]");
	        return 1;
		}
		format(adminstring, sizeof(adminstring), ""COL_LIGHTBLUE"[Admin Chat] %s %s[%d]: %s",GetAdminName(playerid),PlayerName(playerid), playerid, params);
		SendMessageToAllAdmins(adminstring, -1);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:z(playerid,params[])
{
	new zstring[256];
	if(team[playerid] == TEAM_ZOMBIE)
	{
 		if(!strlen(params))
	    {
	        SendClientMessage(playerid, -1, ""chat" /z [message]");
	        return 1;
		}
		format(zstring, sizeof(zstring), ""chat""COL_RED"[Zombie Chat]"COL_WHITE" %s[%d]: %s", PlayerName(playerid), playerid, params);
		SendZMessage(zstring, -1);
	}
	else return SendClientMessage(playerid,-1,""chat" Tienes que ser Zombie para usar este comando");
	return 1;
}

CMD:h(playerid,params[])
{
	new zstring[256];
	if(team[playerid] == TEAM_HUMAN)
	{
 		if(!strlen(params))
	    {
	        SendClientMessage(playerid, -1, ""chat" /h [message]");
	        return 1;
		}
		format(zstring, sizeof(zstring), ""chat""COL_RED"[Human Chat]"COL_WHITE" %s[%d]: %s", PlayerName(playerid), playerid, params);
		SendHMessage(zstring, -1);
	}
	else return SendClientMessage(playerid,-1,""chat" Tienes que ser Humano para usar este comando");
	return 1;
}

CMD:reportar(playerid,params[])
{
	new string[256];
	strcat(string,"Racismo\nOfensivo Lenguaje\nAirbraking - Hacks\nVida Hacks\nArmadura Hacks\nArmas Hacks\nSpawn Killing\nBug Abusing");
	ShowPlayerDialog(playerid,DIALOG_REPORT,DIALOG_STYLE_LIST,"Seleccionar una razón valida!",string,"Seleccionar","Cancelar");
	return 1;
}

CMD:pm(playerid,params[])
{
	new targetid,message[256],pmstring[256],string[128];

 	if(sscanf(params,"us[256]", targetid, message)) return SendClientMessage(playerid,-1,""chat" /pm [playerid] [message]");
	if(pInfo[playerid][pLogged] == 1)
	{
		if(pInfo[targetid][pPM] == 0)
		{
			format(pmstring,sizeof(pmstring),""chat""COL_RED" PM From %s[%d] Message: %s",PlayerName(playerid),playerid,message);
			SendClientMessage(targetid,-1,pmstring);
			format(string,sizeof(string),""chat" Ha sido enviado correctamente a %s", PlayerName(targetid));
			SendClientMessage(playerid,-1,string);
		}
		else {
			SendClientMessage(playerid,-1,""chat" Este jugador no acepta PMs");
		}
	}
	return 1;
}

CMD:bloquear(playerid) return pInfo[playerid][pPM] = 1, SendClientMessage(playerid,-1,""chat" Tu PM está bloqueado");
CMD:desbloquear(playerid) return pInfo[playerid][pPM] = 0, SendClientMessage(playerid,-1,""chat" Tu PM está desbloqueado");

CMD:ann(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2 || IsPlayerAdmin(playerid))
	{
	    if(isnull(params)) return SendClientMessage(playerid, -1, ""chat" /ann [Texto]");
    	GameTextForAll(params,5000,3);
	}
	else {
		SendClientMessage(playerid,-1,""chat" Usted debe ser un administrador de nivel 4");
	}
	return 1;
}

CMD:ann2(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 3 || IsPlayerAdmin(playerid))
	{
	    if(isnull(params)) return SendClientMessage(playerid, -1, ""chat" /ann2 [Texto]");
    	SendClientMessageToAll(-1,params);
	}
	else {
		SendClientMessage(playerid,-1,""chat" Usted debe ser un administrador de nivel 3");
	}
	return 1;
}

CMD:advertir(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 1 || IsPlayerAdmin(playerid))
	{
	    new targetid,reason[105],string[256];
	    if(sscanf(params, "us[105]", targetid, reason)) return SendClientMessage(playerid,-1,""chat" /advertir [playerid] [Razón]");
	    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		new sentstring[128];

        pInfo[targetid][pWarnings]++;

	    format(string,sizeof(string), "%s %s Te ha advertido\nRazón: %s\nNúmero de advertencia: %i",GetAdminName(playerid),PlayerName(playerid), reason, pInfo[targetid][pWarnings]);
		ShowPlayerDialog(targetid,DIALOG_WARN,DIALOG_STYLE_MSGBOX,"Advertencia",string,"I Entender","");
		format(sentstring,sizeof(sentstring), ""chat""COL_LIGHTBLUE" %s %s ha advertido %s Razón: %s (%i / 3)",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),reason,pInfo[targetid][pWarnings]);
		SendClientMessageToAll(-1,sentstring);

		if(pInfo[targetid][pWarnings] >= 3)
		{
			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha sido kickeado %s [Razón: %s][3 Advertencias Excedidas]",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),reason);
			SendClientMessageToAll(-1,string);
			Kick(targetid);
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:darxp(playerid,params[])
{
    if(pInfo[playerid][pLogged] == 1)
    {
		if(pInfo[playerid][pAdminLevel] >= 5)
		{
		    new targetid,givexp,string[256];
			if(sscanf(params, "ui", targetid, givexp)) return SendClientMessage(playerid,-1,""chat" /darxp [playerid] [cantidad]");
		    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

            if(givexp < -10000 || givexp > 10000) return SendClientMessage(playerid,-1,""chat"  Sólo se puede dar entre xp Negativo 10000 - Positivo 10000");
			pInfo[targetid][pXP] += givexp;

			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha dado %s %d xp",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),givexp);
			SendClientMessageToAll(-1,string);
		}
		else {
			SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
		}
	}
	else {
	    SendClientMessage(playerid,-1,""chat" Usted no está conectado");
	    Kick(playerid);
	}
	return 1;
}

CMD:darmonedas(playerid,params[])
{
    if(pInfo[playerid][pLogged] == 1)
    {
		if(pInfo[playerid][pAdminLevel] >= 4)
		{
		    new targetid,givecoin,string[256];
			if(sscanf(params, "ui", targetid, givecoin)) return SendClientMessage(playerid,-1,""chat" /darmonedas [playerid] [Cantidad]");
		    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

            if(givecoin < 1 || givecoin > 20) return SendClientMessage(playerid,-1,""chat"  Solo se puede dar monedas entre 1 - 20");
			pInfo[targetid][pCoins] += givecoin;

			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha dado %s %d Coins",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),givecoin);
			SendClientMessageToAll(-1,string);
		}
		else {
			SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
		}
	}
	else {
	    SendClientMessage(playerid,-1,""chat" Usted no está conectado");
	    Kick(playerid);
	}
	return 1;
}

CMD:compartirxp(playerid,params[])
{
	if(pInfo[playerid][pLogged] == 1)
	{
		if(pInfo[playerid][pHour] >= 2)
		{
			new targetid,givexp,reason[105],stringxp[256];
			if(sscanf(params,"uis[105]", targetid,givexp,reason)) return SendClientMessage(playerid,-1,""chat" /compartirxp [playerid] [Cantidad] [Razón]");
			if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");
			if(targetid == playerid) return SendClientMessage(playerid,-1,""chat" No te puedes compartir xp a ti mismo");
			//if(givexp < 49 || givexp > 2000) return SendClientMessage(playerid,-1,""chat"  You can only give xp between 50-2000");
			if (givexp > 0 && pInfo[playerid][pXP] >= givexp)
			{
				pInfo[targetid][pXP] += givexp;
				pInfo[playerid][pXP] -= givexp;
				format(stringxp,sizeof(stringxp),""chat" Jugador %s ha compartido %d xp a %s [Razón: %s]", PlayerName(playerid), givexp, PlayerName(targetid), reason);
				SendClientMessageToAll(-1,stringxp);
			}
			else
			{
				SendClientMessage(playerid,-1,""chat" Usted no tiene suficiente XP");
			}
		}
		else
		{
			SendClientMessage(playerid,-1,""chat" Debes tener al menos 2 horas jugando");
		}
	}
	return 1;
}

CMD:xp(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 6)
	{
		new xpID,string[256],xpString[64];
		if(sscanf(params, "i", xpID)) return SendClientMessage(playerid,-1,""chat" /xp [XP Type ID] (1normal,2doble,3triple,4cuádruple)");

		Map[XPType] = xpID;
		format(string,sizeof(string),""chat""COL_LIGHTBLUE" %s %s ha cambiado la variable de XP a %s",GetAdminName(playerid),PlayerName(playerid),GetXPName());
		SendClientMessageToAll(-1,string);
		format(xpString,sizeof(xpString),"%s",GetXPName());
		TextDrawSetString(XP,xpString);
	}
	else return SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	return 1;
}

CMD:setxp(playerid,params[])
{
    if(pInfo[playerid][pLogged] == 1)
    {
		if(pInfo[playerid][pAdminLevel] >= 6)
		{
		    new targetid,givexp,string[256];
			if(sscanf(params, "ui", targetid, givexp)) return SendClientMessage(playerid,-1,""chat" /setxp [playerid] [Cantidad]");
		    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

			pInfo[targetid][pXP] = givexp;

			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s le a dado a %s xp %d",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),givexp);
			SendClientMessageToAll(-1,string);
		}
		else {
			SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
		}
	}
	else {
	    SendClientMessage(playerid,-1,""chat" Usted no está conectado");
	    Kick(playerid);
	}
	return 1;
}

CMD:savestats(playerid)
{
	if(pInfo[playerid][pLogged] == 1)
    {
		SaveStats(playerid);
		SendClientMessage(playerid,-1,""chat" Saved Stats");
    }
    return 1;
}

CMD:ss(playerid) return cmd_savestats(playerid);

CMD:stats(playerid)
{
	new string[800];
	new Float:kd = floatdiv(pInfo[playerid][pKills], pInfo[playerid][pDeaths]);
	new Float:wins = floatdiv(pInfo[playerid][pMapsPlayed], pInfo[playerid][pEvac]);
	format(string,sizeof(string),"	{37DB45}Viewing player stats: Yourself{FFFFFF}	\nMonedas %i\nXP %i\nKills %i\nDeaths %i\nMaps Played %i\nrango %i\nEvac Points %i\nAdmin Level %s\nVip Level %i\n\
	Played %d Hours || %d Minutes || %d Seconds\nK:D RATIO: %0.2f\nWin RATIO: %0.2f",pInfo[playerid][pCoins],pInfo[playerid][pXP],pInfo[playerid][pKills],pInfo[playerid][pDeaths],pInfo[playerid][pMapsPlayed],
	pInfo[playerid][pRank],pInfo[playerid][pEvac],GetAdminName(playerid),pInfo[playerid][pVipLevel],pInfo[playerid][pHour],pInfo[playerid][pMin],pInfo[playerid][pSec],kd,wins);

	ShowPlayerDialog(playerid,1888,DIALOG_STYLE_MSGBOX,"Viendo Stats!",string,"Cerrar","");
	return 1;
}

CMD:pstats(playerid,params[])
{
	if(pInfo[playerid][pXP] >= 20)
    {
		new targetid;
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid,-1,""chat" /pstats [playerid]");
	 	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");
	 	{
			new string[800];
			new Float:kd = floatdiv(pInfo[targetid][pKills], pInfo[targetid][pDeaths]);
			new Float:wins = floatdiv(pInfo[targetid][pMapsPlayed], pInfo[targetid][pEvac]);
			format(string,sizeof(string),"	{37DB45}Viendo player stats: %s{FFFFFF}	\nMonedas %i\nXP %i\nKills %i\nDeaths %i\nMaps Played %i\nrango %i\nEvac Points %i\nAdmin Level %s\nVip Level %i\n\
			Played %d Hours || %d Minutes || %d Seconds\nK:D RATIO: %0.2f\nWin RATIO: %0.2f",PlayerName(targetid),pInfo[targetid][pCoins],pInfo[targetid][pXP],pInfo[targetid][pKills],pInfo[targetid][pDeaths],pInfo[targetid][pMapsPlayed],
			pInfo[playerid][pRank],pInfo[targetid][pEvac],GetAdminName(targetid),pInfo[targetid][pVipLevel],pInfo[targetid][pHour],pInfo[targetid][pMin],pInfo[targetid][pSec],kd,wins);

			ShowPlayerDialog(playerid,1888,DIALOG_STYLE_MSGBOX,"Viendo Stats!",string,"Cerrar","");
		}
	}
	else return SendXPError(playerid,20);
	return 1;
}

CMD:clima(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 3 || IsPlayerAdmin(playerid))
    {
		new time2,string[128];
		if(sscanf(params, "i", time2)) return SendClientMessage(playerid,-1,""chat" /clima [numero 1-12]");

		SetWorldTime(time2);

		if(IsPlayerAdmin(playerid))
		{
			format(string, sizeof(string), ""chat" Clima cambiado a %d",time2);
			SendClientMessageToAll(-1,string);
		}
		else
		{
			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha cambiado el clima a %d",GetAdminName(playerid),PlayerName(playerid),time2);
			SendClientMessageToAll(-1,string);
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:tiempo(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 3 || IsPlayerAdmin(playerid))
    {
		new weather,string[128];
		if(sscanf(params, "i", weather)) return SendClientMessage(playerid,-1,""chat" /tiempo [numero]");

		SetWeather(weather);

		if(IsPlayerAdmin(playerid))
		{
			format(string, sizeof(string), ""chat" Tiempo cambiado a %d",weather);
			SendClientMessageToAll(-1,string);
		}
		else
		{
			format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha cambiado el tiempo a %d",GetAdminName(playerid),PlayerName(playerid),weather);
			SendClientMessageToAll(-1,string);
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:ip(playerid, params[])
{
    if(pInfo[playerid][pAdminLevel] >= 3)
    {
		new targetid,playerip[16],string[128];
		if(sscanf(params, "u", targetid, playerip)) return SendClientMessage(playerid,-1,""chat" /ip [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		GetPlayerIp(targetid, playerip, sizeof(playerip));
		format(string, sizeof(string), ""chat" IP of %s %s", PlayerName(targetid), playerip);
		SendClientMessage(playerid, -1, string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:akill(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 2)
    {
		new targetid,string[256];
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid,-1,""chat" /akill [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		SetPlayerHealth(targetid,0.0);

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha matado %s",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid));
		SendClientMessageToAll(-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:explotar(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 5)
    {
		new targetid,string[256];
		if(sscanf(params, "u", targetid)) SendClientMessage(playerid,-1,""chat" /explotar [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		new Float:x,Float:y,Float:z;
		GetPlayerPos(targetid,Float:x,Float:y,Float:z);
		CreateExplosion(Float:x,Float:y,Float:z,0,5.0);

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha explotado %s",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid));
		SendClientMessageToAll(-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:get(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 3)
    {
		new targetid;
		if(sscanf(params, "u", targetid)) SendClientMessage(playerid,-1,""chat" /get [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

        new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
    	SetPlayerPos(targetid, x+1, y+1, z);

		if(IsPlayerInAnyVehicle(targetid))
  		{
  		    SetVehiclePos(GetPlayerVehicleID(targetid),x,y,z);
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:goto(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 2)
    {
		new targetid;
		if(sscanf(params, "u", targetid)) SendClientMessage(playerid,-1,""chat" /goto [playerid]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		new Float:x,Float:y,Float:z,inter;
		GetPlayerPos(targetid,Float:x,Float:y,Float:z);
		inter = GetPlayerInterior(targetid);
        SetPlayerPosEx(playerid,Float:x,Float:y,Float:z,inter,0);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:callar(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
	    new targetid,reason[105],string[128];
	    if(sscanf(params, "us[105]", targetid,reason)) return SendClientMessage(playerid,-1,""chat" /callar [playerid] [Razón]");
   		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		pInfo[targetid][IsPlayerMuted] = 1;

		format(string,sizeof(string),""chat""COL_LIGHTBLUE" %s %s callado %s [Razón: %s]", GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),reason);
		SendMessageToAllAdmins(string,-1);

		format(string,sizeof(string),""chat""COL_LIGHTBLUE" %s %s te ha callado por [Razón %s]",GetAdminName(playerid), PlayerName(playerid),reason);
		SendClientMessage(targetid,-1,string);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:descallar(playerid,params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
	    new targetid,string[128];
	    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid,-1,""chat" /descallar [playerid]");
   		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Jugador no está conectado");

		if(pInfo[targetid][IsPlayerMuted] == 1)
		{
			format(string,sizeof(string),""chat""COL_LIGHTBLUE" %s %s te ha descallado",GetAdminName(playerid),PlayerName(playerid));
			SendClientMessage(targetid,-1,string);
			format(string,sizeof(string),""chat" descallado %s",PlayerName(targetid));
			SendClientMessage(playerid,-1,string);
			pInfo[targetid][IsPlayerMuted] = 0;
		}
		else
		{
		    SendClientMessage(playerid,-1,""chat" Jugador no está callado");
		}
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

CMD:kick(playerid,params[])
{
    if(pInfo[playerid][pAdminLevel] >= 1)
    {
		new targetid,reason[105],string[256];
		if(sscanf(params, "us[105]", targetid,reason)) return SendClientMessage(playerid,-1,""chat" /kick [playerid] [Razón]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""chat" Juegador no esta conectado");

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" %s %s ha botado %s [Reason: %s]",GetAdminName(playerid),PlayerName(playerid),PlayerName(targetid),reason);
		SendClientMessageToAll(-1,string);

		Kick(targetid);
	}
	else {
		SendClientMessage(playerid,-1,""chat""COL_LIGHTBLUE" Usted no tiene los permisos de administrador adecuados para este comando!");
	}
	return 1;
}

public TimeOnServer(playerid)
{
	pInfo[playerid][pSec] ++;
	if(pInfo[playerid][pSec] >= 60)
 	{
  		pInfo[playerid][pMin]++;
    	pInfo[playerid][pSec]=0;
    }
	if(pInfo[playerid][pMin] >= 60)
 	{
  		pInfo[playerid][pMin]=0;
    	pInfo[playerid][pHour]++;
    }
    return 1;
}

function RandomMessages()
{
    new randomMsg = random(sizeof(randomMessages));
    SendClientMessageToAll(-1, randomMessages[randomMsg]);
}

public LoadUser_data(playerid,name[],value[])
{
    INI_String("pPassword", pInfo[playerid][pPassword], 129);
    INI_Int("pXP",pInfo[playerid][pXP]);
    INI_Int("pKills",pInfo[playerid][pKills]);
    INI_Int("pDeaths",pInfo[playerid][pDeaths]);
    INI_Int("pRank",pInfo[playerid][pRank]);
    INI_Int("pEvacuasion",pInfo[playerid][pEvac]);
    INI_Int("pAdminLevel",pInfo[playerid][pAdminLevel]);
    INI_Int("pVipLevel",pInfo[playerid][pVipLevel]);
    INI_Int("pHoras",pInfo[playerid][pHour]);
    INI_Int("pMinutos",pInfo[playerid][pMin]);
    INI_Int("pSegundo",pInfo[playerid][pSec]);
    INI_Int("pMapsPlayed",pInfo[playerid][pMapsPlayed]);
    INI_Int("pMonedas",pInfo[playerid][pCoins]);
    return 1;
}

stock ClearChat()
{
	for(new a = 0; a < 20; a++) SendClientMessageToAll(-1, " ");
	return 1;
}

stock ResetVars(playerid)
{
	//pInfo[playerid][pPassword] = 0;
	pInfo[playerid][pXP] = 0;
	pInfo[playerid][pKills] = 0;
	pInfo[playerid][pDeaths] = 0;
	pInfo[playerid][pRank] = 0;
	pInfo[playerid][pEvac] = 0;
	pInfo[playerid][pAdminLevel] = 0;
	pInfo[playerid][pVipLevel] = 0;
	pInfo[playerid][pHour] = 0;
	pInfo[playerid][pMin] = 0;
	pInfo[playerid][pSec] = 0;
	pInfo[playerid][pMapsPlayed] = 0;
	pInfo[playerid][pCoins] = 0;
	pInfo[playerid][pLogged] = 0;
	pInfo[playerid][pWarnings] = 0;
	pInfo[playerid][pPM] = 0;
	pInfo[playerid][IsPlayerMuted] = 0;
	pInfo[playerid][Killstreak] = 0;
	pInfo[playerid][pHumanClass] = 0;
	pInfo[playerid][pZombieClass] = 0;
	pInfo[playerid][IsPlayerInfected] = 0;
	pInfo[playerid][Boxes] = 0;
	pInfo[playerid][BoxesAdvanced] = 0;
	pInfo[playerid][pVipKickBack] = 0;
	pInfo[playerid][pVipFlash] = 0;
	pInfo[playerid][pVipBoxes] = 0;
	pInfo[playerid][pLadders] = 0;
	pInfo[playerid][pKickBackCoin] = 0;
	pInfo[playerid][pDamageShotgunCoin] = 0;
	pInfo[playerid][pDamageDeagleCoin] = 0;
	pInfo[playerid][pDamageMP5Coin] = 0;
    pInfo[playerid][pDoctorShield] = 0;
 	Abilitys[playerid][HighJumpScout] = 0;
 	Abilitys[playerid][HighJumpZombie] = 0;
 	Abilitys[playerid][StomperPushing] = 0;
 	Abilitys[playerid][WitchAttack] = 0;
 	Abilitys[playerid][ScreamerZombieAb] = 0;
 	Abilitys[playerid][InfectionNormal] = 0;
 	Abilitys[playerid][InfectionMutated] = 0;
 	Abilitys[playerid][ShoutCooldown] = 0;
 	Abilitys[playerid][HealCoolDown] = 0;
 	Abilitys[playerid][ScreamerZombieAb2] = 0;
 	Abilitys[playerid][WitchAttack2] = 0;
 	Abilitys[playerid][InfectionFleshEater] = 0;
	KillTimer(playedtimer[playerid]);
	CurePlayer(playerid);
	KillTimer(pInfo[playerid][IsPlayerInfectedTimer]);
	SetPVarInt(playerid, "SPS Los mensajes enviados", 0);
	SetPVarInt(playerid, "SPS Callado", 0);
	SetPVarInt(playerid, "SPS Advertencias de Spam", 0);
	//SPS_Reset_PVars();
	return 1;
}

stock ResetCoinVars(playerid)
{
	pInfo[playerid][pKickBackCoin] = 0;
	pInfo[playerid][pDamageShotgunCoin] = 0;
	pInfo[playerid][pDamageDeagleCoin] = 0;
	pInfo[playerid][pDamageMP5Coin] = 0;
	return 1;
}

stock ConnectVars(playerid)
{
	TextDrawShowForPlayer(playerid, ServerIntroOne[playerid]);
	TextDrawShowForPlayer(playerid, ServerIntroTwo[playerid]);
	pInfo[playerid][pHumanClass] = CIVILIAN;
	pInfo[playerid][pZombieClass] = STANDARDZOMBIE;
	team[playerid] = 0;
	return 1;
}

stock GetWeaponModel(weaponid)
    {
            switch(weaponid)
            {
                case 1:
                    return 331;

                    case 2..8:
                        return weaponid+331;

            case 9:
                        return 341;

                    case 10..15:
                            return weaponid+311;

                    case 16..18:
                        return weaponid+326;

                    case 22..29:
                        return weaponid+324;

                    case 30,31:
                        return weaponid+325;

                    case 32:
                        return 372;

                    case 33..45:
                        return weaponid+324;

                    case 46:
                        return 371;
            }
            return 0;
    }

stock SaveStats(playerid)
{
 	new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"pXP",pInfo[playerid][pXP]);
    INI_WriteInt(File,"pKills",pInfo[playerid][pKills]);
    INI_WriteInt(File,"pDeaths",pInfo[playerid][pDeaths]);
    INI_WriteInt(File,"pRank",pInfo[playerid][pRank]);
    INI_WriteInt(File,"pEvacuacion",pInfo[playerid][pEvac]);
    INI_WriteInt(File,"pAdminLevel",pInfo[playerid][pAdminLevel]);
    INI_WriteInt(File,"pVipLevel",pInfo[playerid][pVipLevel]);
    INI_WriteInt(File,"pHoras",pInfo[playerid][pHour]);
    INI_WriteInt(File,"pMinutos",pInfo[playerid][pMin]);
    INI_WriteInt(File,"pSegundos",pInfo[playerid][pSec]);
    INI_WriteInt(File,"pMapsPlayed",pInfo[playerid][pMapsPlayed]);
    INI_WriteInt(File,"pMonedas",pInfo[playerid][pCoins]);
    INI_Close(File);
	return 1;
}

stock PlayerName(playerid)
{
	new CName[24];
	GetPlayerName(playerid, CName, 24);
 	return CName;
}

stock UserPath(playerid)
{
    new str[128],name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    format(str,sizeof(str),PATH,name);
    return str;
}

stock BanPlayer(playerid,reason[],admin[])
{
	new str[128];
	BanEx(playerid,reason);
	format(str,sizeof(str),"Se le ha prohibido entrar en este servidor.\nUser: %s\nRazón: %s\nAdmin %s\n",PlayerName(playerid),reason,admin);
	ShowPlayerDialog(playerid,DIALOG_BANNED,DIALOG_STYLE_MSGBOX,"Se le ha prohibido!",str,"Dejar","");
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}


stock SetPlayerPosEx( playerid, Float: posx, Float: posy, Float: posz, interior, virtualworld )
{
    if( GetPlayerState( playerid ) == 2 )
    {
      SetPlayerVirtualWorld( playerid, virtualworld );
      SetVehicleVirtualWorld( GetPlayerVehicleID( playerid ), virtualworld );
      LinkVehicleToInterior( GetPlayerVehicleID( playerid ), interior );
      SetPlayerInterior( playerid, interior );
      SetVehiclePos( GetPlayerVehicleID( playerid ), posx, posy, posz );
      return 1;
    }
    else
    {
      SetPlayerVirtualWorld( playerid, virtualworld );
      SetPlayerInterior( playerid, interior );
      SetPlayerPos( playerid, posx, posy, posz );
      return 1;
    }
}

stock SendMessageToAllAdmins(message[], color)
{
	foreach(Player, i)
	{
		if(pInfo[i][pAdminLevel] >= 1 || IsPlayerAdmin(i))
		{
	 	    SendClientMessage(i, color, message);
	 	}
 	}
	return 1;
}

stock SendZMessage(message[], color)
{
	foreach(Player, i)
	{
		if(team[i] == TEAM_ZOMBIE)
		{
	 	    SendClientMessage(i, color, message);
	 	}
 	}
	return 1;
}

stock SendHMessage(message[], color)
{
	foreach(Player, i)
	{
		if(team[i] == TEAM_HUMAN)
		{
	 	    SendClientMessage(i, color, message);
	 	}
 	}
	return 1;
}

stock SendXPError(playerid,xp)
{
	new string[128];
	format(string,sizeof(string),""chat""COL_PINK" Necesita al menos %i XP Para utilizar esta clase o de mando",xp);
	SendClientMessage(playerid,-1,string);
	return 1;
}

stock SendCoinError(playerid,coin)
{
	new string[128];
	format(string,sizeof(string),""chat""COL_PINK" necesitas %i monedas para utilizar esta función!",coin);
	SendClientMessage(playerid,-1,string);
	return 1;
}

stock SendVipError(playerid,viplevel)
{
	new string[128];
	format(string,sizeof(string),""chat""COL_PINK" Usted necesita el paquete vip %i Para utilizar este comando!",viplevel);
	SendClientMessage(playerid,-1,string);
	return 1;
}

stock GivePlayerXP(playerid,xp)
{
	new string[128];
	pInfo[playerid][pXP] += xp;
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~y~+%i",xp);
	GameTextForPlayer(playerid,string,3500,5);
	return 1;
}

stock GetMapCount()
{
	new mcount = 0, file[128];
	for(new i = 0; i < MAX_MAP_FILES; i++)
	{
        format(file, sizeof(file), "/Maps/%d.ini", i);
	    if(fexist(file))
	    {
	        mcount ++;
	    }
	}
	return mcount;
}

stock GetFreeMapID()
{
    new file[32], id = 0;
	for(new i = 0; i < MAX_MAP_FILES; i++)
	{
        format(file, sizeof(file), "/Maps/%d.ini", i);
	    if(fexists(file)) continue;
	    id = i;
	    break;
	}
	return id;
}

stock NoMapCheck()
{
	new tcount = 0, file[128];
	for(new i = 0; i < MAX_MAP_FILES; i++)
	{
	    format(file, sizeof(file), "/Maps/%d.ini", i);
	    if(fexist(file))
	    {
	        tcount ++;
	    }
	}
	if(tcount == 0)
	{
	    print("___________________________________________________________________");
	    print("ADVERTENCIA: El servidor ha detectado que no hay archivos de mapas!");
	    print("Actualmente  instalado...... El  servidor  se  ha configurado  para");
	    print("Apagará      automáticamente    en    25 000/ MS.     (25 Segundos)");
	    print("___________________________________________________________________");
	    SetTimer("No_Maps", 25000, false);
	    return 1;
	}
	return 1;
}

function No_Maps() return SendRconCommand("Salir");

public load_Map_basic(Mapid, name[], value[])
{
	if(strcmp(name, "FSMapName", true) == 0)
	{
		strmid(Map[FSMapName], value, false, strlen(value), 128);
		LoadFilterScript(Map[FSMapName]);
	}

	/*printf("[Debug] Name: %s - Value: %s", name, value);  For Debug Purposes*/

	if(strcmp(name, "MapName", true) == 0)
	{
	    new mpname[50];
		strmid(Map[MapName], value, false, strlen(value), 128);
		format(mpname, sizeof(mpname), "mapname %s", Map[MapName]);
	    SendRconCommand(mpname);
	}

	if(strcmp(name, "HumanSpawnX", true) == 0) Map[HumanSpawnX] = floatstr(value);
	if(strcmp(name, "HumanSpawnY", true) == 0) Map[HumanSpawnY] = floatstr(value);
	if(strcmp(name, "HumanSpawnZ", true) == 0) Map[HumanSpawnZ] = floatstr(value);
	if(strcmp(name, "HumanSpawn2X", true) == 0) Map[HumanSpawn2X] = floatstr(value);
	if(strcmp(name, "HumanSpawn2Y", true) == 0) Map[HumanSpawn2Y] = floatstr(value);
	if(strcmp(name, "HumanSpawn2Z", true) == 0) Map[HumanSpawn2Z] = floatstr(value);
	if(strcmp(name, "ZombieSpawnX", true) == 0) Map[ZombieSpawnX] = floatstr(value);
	if(strcmp(name, "ZombieSpawnY", true) == 0) Map[ZombieSpawnY] = floatstr(value);
	if(strcmp(name, "ZombieSpawnZ", true) == 0) Map[ZombieSpawnZ] = floatstr(value);
	if(strcmp(name, "Interior", true) == 0) Map[Interior] = strval(value);
	if(strcmp(name, "GateX", true) == 0) Map[GateX] = floatstr(value);
	if(strcmp(name, "GateY", true) == 0) Map[GateY] = floatstr(value);
	if(strcmp(name, "GateZ", true) == 0) Map[GateZ] = floatstr(value);
	if(strcmp(name, "CPx", true) == 0) Map[CPx] = floatstr(value);
	if(strcmp(name, "CPy", true) == 0) Map[CPy] = floatstr(value);
	if(strcmp(name, "CPz", true) == 0) Map[CPz] = floatstr(value);
	if(strcmp(name, "GaterX", true) == 0) Map[GaterX] = floatstr(value);
	if(strcmp(name, "GaterY", true) == 0) Map[GaterY] = floatstr(value);
	if(strcmp(name, "GaterZ", true) == 0) Map[GaterZ] = floatstr(value);
    if(strcmp(name, "MoveGate", true) == 0) Map[MoveGate] = strval(value);
    if(strcmp(name, "GateID", true) == 0) Map[GateID] = strval(value);
	if(strcmp(name, "AllowWater", true) == 0) Map[AllowWater] = strval(value);
	if(strcmp(name, "EvacType", true) == 0) Map[EvacType] = strval(value);
	if(strcmp(name, "Weather", true) == 0)
	{
		Map[Weather] = strval(value);
		SetWeather(Map[Weather]);
	}

	if(strcmp(name, "Time", true) == 0)
	{
		Map[Time] = strval(value);
		SetWorldTime(Map[Time]);
 	 	printf("Mapa ID %d's La información se ha cargado.", Mapid);
	}
	return 1;
}

stock LoadMap(Mapid)
{
	new Map_file[64];
	format(Map_file, sizeof(Map_file), "/Maps/%d.ini", Mapid);
	if(fexist(Map_file))
	{
		printf("Cargando mapa %s", Map_file);
	    INI_ParseFile(Map_file, "load_Map_%s", .bExtra = true, .extra = Mapid);
	    return 1;
	}
	return 0;
}

stock LoadNewMap()
{
    new file[64];
    mapid %= MAX_MAP_FILES;
    format(file, sizeof(file), "/Maps/%d.ini", mapid);
    if(!fexist(file)) return printf("[NOTICE] Archivo Bugged.");
    LastMapStarted = mapid;
    mapid++;
    return mapid-1;
}

stock ClearObjects()
{
	for(new i; i<MAX_OBJECTS; i++)
	{
		if(IsValidObject(i)) DestroyObject(i);
	}
}

stock DestroyAllVehicle()
{
    for(new i=1;i<=MAX_VEHICLES;i++)
	{
    	DestroyVehicle(i);
	}
	return 1;
}

stock GetRandomMap()
{
    new file[64];
    new i = 0, count = 0, Maps[MAX_MAP_FILES], Mapid;
    for( ; i != MAX_MAP_FILES; ++i)
	{
	    if(LastMapStarted == i) continue;
	    format(file, sizeof(file), "/Maps/%d.ini", i);
		if(fexist(file))
		{
 			Maps[count] = i;
 			count++;
 		}
    }
    if(count == 0)
	{
	    return NoMapCheck();
    }
    Mapid = Maps[random(count)];

	format(file, sizeof(file), "/Maps/%d.ini", Mapid);
	if(fexist(file))
	{
	    LastMapStarted = Mapid;
	    return Mapid;
	}
	else return printf("[NOTICE] Archivo Bugged.");
}

stock LoadFilterScript(filename[])
{
	new string[128];
	format(string, sizeof(string), "loadfs %s", filename);
	SendRconCommand(string);
	return 1;
}

stock UnloadFilterScript(filename[])
{
	new string[128];
	format(string, sizeof(string), "unloadfs %s", filename);
	SendRconCommand(string);
	return 1;
}

stock HumanSetup(playerid)
{
	SetPlayerTeam(playerid,TEAM_HUMAN);
	SetPlayerHealth(playerid,100.0);
	team[playerid] = TEAM_HUMAN;
	SetPlayerColor(playerid,COLOR_HUMAN);
	return 1;
}

stock HumanSetup2(playerid)
{
	SetPlayerTeam(playerid,TEAM_HUMAN);
	SetPlayerHealth(playerid,100.0);
	team[playerid] = TEAM_HUMAN;
	SetPlayerColor(playerid,COLOR_HUMAN);
	SpawnPlayer(playerid);
	return 1;
}

stock ZombieSetup(playerid)
{
	SetPlayerTeam(playerid,TEAM_ZOMBIE);
	team[playerid] = TEAM_ZOMBIE;
	SetPlayerColor(playerid,COLOR_ZOMBIE);
 	return 1;
}

stock ZombieSetup2(playerid)
{
	SetPlayerTeam(playerid,TEAM_ZOMBIE);
	team[playerid] = TEAM_ZOMBIE;
	SetPlayerColor(playerid,COLOR_ZOMBIE);
	SpawnPlayer(playerid);
 	return 1;
}

public Float:GetDistanceBetweenPlayers(p1,p2)
{
    new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
    if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2)) {
        return -1.00;
    }
    GetPlayerPos(p1,x1,y1,z1);
    GetPlayerPos(p2,x2,y2,z2);
    return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

public GetClosestPlayer(p1)
{
    new x,Float:dis,Float:dis2,player;
    player = -1;
    dis = 99999.99;
    for (x=0;x<MAX_PLAYERS;x++) {
        if(IsPlayerConnected(x)) {
            if(x != p1) {
                dis2 = GetDistanceBetweenPlayers(x,p1);
                if(dis2 < dis && dis2 != -1.00) {
                    dis = dis2;
                    player = x;
                }
            }
        }
    }
    return player;
}

stock IsPlayerInWater(playerid)
{
    new animlib[32],tmp[32];
    GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,tmp,32);
    if( !strcmp(animlib, "SWIM") && !IsPlayerInAnyVehicle(playerid) ) return true;
    return false;
}

GetTeamPlayersAlive(teamid)
{
    new count;
    for(new i; i < playersAliveCount; i++)
    {
        if(IsPlayerConnected(i) && team[i] == teamid) count++;
    }
    return count;
}

stock OneZombie()
{
    new count = 0;
    new Random = Iter_Random(Player);
    foreach(Player, i)
    {
        if(team[i] == TEAM_HUMAN) count++;
        if(count == Iter_Count(Player))
        {
			ZombieSetup(Random);
        }
    }
    return 1;
}

public RandomZombie() return Half();

stock Half()
{
	new Humans;
	foreach(Player, i)
	{
	    if(Humans < 3)
	    {
	        HumanSetup(i);
	        //ShowCoinDialog(i);
	        printf("Humanos Seleccionadas");
	        Humans ++;
	    }
	    else
	    {
	        ZombieSetup2(i);
	        printf("Zombies Seleccionadas");
	        Humans = 0;
	    }
	}
	printf("Selección de equipos terminados");
	return 1;
}

stock EvenTeams(playerid)
{
    new Humans, Zombies, rand = random(2);
	if(rand == 0) // Setting ID 0 to Human and continuing with the cycle
	{
	    foreach(Player, i)
	    {
	        if(Humans == Zombies)
	        {
				HumanSetup2(i);
	            Humans ++;
	        }
	        else
	        {
	            ZombieSetup2(playerid);
	            Zombies ++;
	        }
	    }
	}
	else // Setting ID 0 to Zombie and continuing with the cycle
	{
	    foreach(Player, i)
	    {
	        if(Humans == Zombies)
	        {
	            ZombieSetup2(i);
	            Zombies ++;
	        }
	        else
	        {
	            HumanSetup2(i);
	            Humans ++;
	        }
	    }
	}
	return 1;
}

stock DefaultTextdraws()
{
	//remadeText = TextDrawCreate(506.000000, 380.000000, "||~Survival Zombie~||");
	//TextDrawBackgroundColor(remadeText, 255);
	//TextDrawFont(remadeText, 2);
	//TextDrawLetterSize(remadeText, 0.159999, 1.399999);
	//TextDrawColor(remadeText, 16777215);
	//TextDrawSetOutline(remadeText, 0);
	//TextDrawSetProportional(remadeText, 1);
	//TextDrawSetShadow(remadeText, 1);

	//remadeText2 = TextDrawCreate(517.000000, 389.000000, "Bienvenido al infierno");
	//TextDrawBackgroundColor(remadeText2, 255);
	//TextDrawFont(remadeText2, 2);
	//TextDrawLetterSize(remadeText2, 0.140000, 1.200000);
	//TextDrawColor(remadeText2, -1);
	//TextDrawSetOutline(remadeText2, 0);
	//TextDrawSetProportional(remadeText2, 1);
	//TextDrawSetShadow(remadeText2, 1);

	TimeLeft = TextDrawCreate(22.000000, 251.000000, "180");
	TextDrawBackgroundColor(TimeLeft, 255);
	TextDrawFont(TimeLeft, 1);
	TextDrawLetterSize(TimeLeft, 1.0, 2.0);
	TextDrawColor(TimeLeft, 0xFFFFFFFF);
	TextDrawSetOutline(TimeLeft, 1);
	TextDrawSetProportional(TimeLeft, 1);
	TextDrawSetShadow(TimeLeft, 1);

	UntilRescue = TextDrawCreate(22.000000, 270.000000, "time left");
	TextDrawBackgroundColor(UntilRescue, 255);
	TextDrawFont(UntilRescue, 1);
	TextDrawLetterSize(UntilRescue, 0.380000, 0.900000);
	TextDrawColor(UntilRescue, 0xFF8000FF);
	TextDrawSetOutline(UntilRescue, 1);
	TextDrawSetProportional(UntilRescue, 1);
	TextDrawSetShadow(UntilRescue, 1);

	AliveInfo = TextDrawCreate(22.000000, 230.000000, "SERES HUMANOS VIVOS: 0~n~ZOMBIES VIVOS: 0~n~");
	TextDrawBackgroundColor(AliveInfo, 255);
	TextDrawFont(AliveInfo, 1);
	TextDrawLetterSize(AliveInfo, 0.200000, 1.400000);
	TextDrawColor(AliveInfo, -1);
	TextDrawSetOutline(AliveInfo, 0);
	TextDrawSetProportional(AliveInfo, 1);
	TextDrawSetShadow(AliveInfo, 1);

	XP = TextDrawCreate(502.000000, 11.000000, "~n~");
	TextDrawBackgroundColor(XP, 255);
	TextDrawFont(XP, 2);
	TextDrawLetterSize(XP, 0.270000, 1.000000);
	TextDrawColor(XP, 16777215);
	TextDrawSetOutline(XP, 0);
	TextDrawSetProportional(XP, 1);
	TextDrawSetShadow(XP, 1);

	CurrentMap = TextDrawCreate(23.000000, 280.000000, "Map: Cargando");
	TextDrawBackgroundColor(CurrentMap, 255);
	TextDrawFont(CurrentMap, 2);
	TextDrawLetterSize(CurrentMap, 0.190000, 0.700000);
	TextDrawColor(CurrentMap, -1);
	TextDrawSetOutline(CurrentMap, 0);
	TextDrawSetProportional(CurrentMap, 1);
	TextDrawSetShadow(CurrentMap, 1);

	//EventText = TextDrawCreate(503.000000, 397.000000, "Feliz Navidad");
	//TextDrawBackgroundColor(EventText, 255);
	//TextDrawFont(EventText, 2);
	//TextDrawLetterSize(EventText, 0.300000, 1.000000);
	//TextDrawColor(EventText, -16776961);
	//TextDrawSetOutline(EventText, 0);
	//TextDrawSetProportional(EventText, 1);
	//TextDrawSetShadow(EventText, 1);

	for(new i; i < MAX_PLAYERS; i ++)
	{
		Infected[i] = TextDrawCreate(2.000000, 1.000000, "~n~");
		TextDrawBackgroundColor(Infected[i], 255);
		TextDrawFont(Infected[i], 1);
		TextDrawLetterSize(Infected[i], 0.500000, 50.000000);
		TextDrawColor(Infected[i], -1);
		TextDrawSetOutline(Infected[i], 0);
		TextDrawSetProportional(Infected[i], 1);
		TextDrawSetShadow(Infected[i], 1);
		TextDrawUseBox(Infected[i], 1);
		TextDrawBoxColor(Infected[i], 1174405190);
		TextDrawTextSize(Infected[i], 640.000000, 0.000000);

		iKilled[i] = TextDrawCreate(237.000000, 418.000000, "Cargando");
		TextDrawBackgroundColor(iKilled[i], 255);
		TextDrawFont(iKilled[i], 2);
		TextDrawLetterSize(iKilled[i], 0.200000, 1.000000);
		TextDrawColor(iKilled[i], -1);
		TextDrawSetOutline(iKilled[i], 0);
		TextDrawSetProportional(iKilled[i], 1);
		TextDrawSetShadow(iKilled[i], 1);

		myXP[i] = TextDrawCreate(500.000000, 78.000000, "Loading");
		TextDrawBackgroundColor(myXP[i], 0x191007FF);
		TextDrawFont(myXP[i], 3);
		TextDrawLetterSize(myXP[i],  0.500000, 2.000000);
		TextDrawColor(myXP[i], 0xdd8f00FF);
		TextDrawSetOutline(myXP[i], 2);
		TextDrawSetProportional(myXP[i], 1);
		TextDrawSetShadow(myXP[i], 1);

		ServerIntroOne[i] = TextDrawCreate(180.000000, 111.000000, "Zombie~n~    ~r~Survival");
		TextDrawBackgroundColor(ServerIntroOne[i], 255);
		TextDrawFont(ServerIntroOne[i], 3);
		TextDrawLetterSize(ServerIntroOne[i], 0.800000, 4.000000);
		TextDrawColor(ServerIntroOne[i], -1);
		TextDrawSetOutline(ServerIntroOne[i], 0);
		TextDrawSetProportional(ServerIntroOne[i], 1);
		TextDrawSetShadow(ServerIntroOne[i], 1);

		ServerIntroTwo[i] = TextDrawCreate(287.000000, 120.000000, "Beta 2022");
		TextDrawBackgroundColor(ServerIntroTwo[i], 255);
		TextDrawFont(ServerIntroTwo[i], 1);
		TextDrawLetterSize(ServerIntroTwo[i], 0.220000, 1.200000);
		TextDrawColor(ServerIntroTwo[i], -1);
		TextDrawSetOutline(ServerIntroTwo[i], 0);
		TextDrawSetProportional(ServerIntroTwo[i], 1);
		TextDrawSetShadow(ServerIntroTwo[i], 1);
	}
	return 1;
}

stock UpdateAliveInfo()
{
	new string[128];
	format(string,sizeof(string),"~r~ZOMBIES: %d ~w~HUMANS: %d~n~~n~",GetTeamPlayersAlive(TEAM_ZOMBIE),GetTeamPlayersAlive(TEAM_HUMAN));
	TextDrawSetString(AliveInfo,string);
	return 1;
}

stock UpdateXPTextdraw(playerid)
{
	new string[128];
	format(string,sizeof(string),"$%i",pInfo[playerid][pXP]);
	TextDrawSetString(myXP[playerid],string);
	return 1;
}

stock UpdateMapName()
{
	new string[128];
	format(string,sizeof(string),"Map: %s",Map[MapName]);
	TextDrawSetString(CurrentMap,string);
	return 1;
}

stock setClass(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
	    ResetPlayerWeapons(playerid);
		switch(pInfo[playerid][pHumanClass])
		{
		    case CIVILIAN:
		    {
		        GivePlayerWeapon(playerid,23,100);
		        GivePlayerWeapon(playerid,25,50);
		        switch(random(3))
		        {
		            case 0: SetPlayerSkin(playerid,44);
		            case 1: SetPlayerSkin(playerid,188);
		            case 2: SetPlayerSkin(playerid,261);
				}
			}

			case POLICEMAN:
			{
			    GivePlayerWeapon(playerid,24,100);
		        GivePlayerWeapon(playerid,25,100);
		        SetPlayerSkin(playerid,280);
			}

			case MEDIC:
			{
   				GivePlayerWeapon(playerid,23,350);
		        GivePlayerWeapon(playerid,25,150);
		        SetPlayerArmour(playerid,50);
		        SetPlayerSkin(playerid,276);
			}

			case SCOUT:
			{
   				GivePlayerWeapon(playerid,34,40);
		        GivePlayerWeapon(playerid,23,400);
		        SetPlayerSkin(playerid,83);
			}

			case HEAVYMEDIC:
			{
   				GivePlayerWeapon(playerid,24,150);
		        GivePlayerWeapon(playerid,25,200);
		        SetPlayerArmour(playerid,95);
		        SetPlayerSkin(playerid,274);
			}

			case FARMER:
			{
   				GivePlayerWeapon(playerid,24,200);
		        GivePlayerWeapon(playerid,30,100);
		        GivePlayerWeapon(playerid,33,40);
		        SetPlayerArmour(playerid,60);
		        SetPlayerSkin(playerid,102);
			}

			case ENGINEER:
			{
   				GivePlayerWeapon(playerid,23,450);
		        GivePlayerWeapon(playerid,25,250);
		        SetPlayerArmour(playerid,50);
		        SetPlayerSkin(playerid,27);
			}

			case SWAT:
			{
   				GivePlayerWeapon(playerid,29,300);
		        GivePlayerWeapon(playerid,24,100);
				SetPlayerArmour(playerid,95);
				SetPlayerSkin(playerid,285);
			}

			case HEAVYSHOTGUN:
			{
   				GivePlayerWeapon(playerid,25,300);
		        GivePlayerWeapon(playerid,24,100);
		        SetPlayerArmour(playerid,50);
		        SetPlayerSkin(playerid,5);
			}

			case ADVANCEDMEDIC:
			{
   				GivePlayerWeapon(playerid,31,100);
		        GivePlayerWeapon(playerid,24,150);
		        GivePlayerWeapon(playerid,25,350);
		        SetPlayerSkin(playerid,275);
		        SetPlayerArmour(playerid,70);
			}

			case ADVANCEDENGINEER:
			{
   				GivePlayerWeapon(playerid,24,150);
		        GivePlayerWeapon(playerid,31,500);
				SetPlayerArmour(playerid,95);
				SetPlayerSkin(playerid,260);
			}

			case FEDERALAGENT:
			{
   				GivePlayerWeapon(playerid,31,1000);
		        GivePlayerWeapon(playerid,24,500);
		        GivePlayerWeapon(playerid,25,400);
		        SetPlayerArmour(playerid,95);
		        SetPlayerSkin(playerid,286);
			}

			case KICKBACK:
			{
   				GivePlayerWeapon(playerid,23,500);
		        GivePlayerWeapon(playerid,25,450);
		        GivePlayerWeapon(playerid,29,200);
		        SetPlayerSkin(playerid,149);
			}

			case ADVANCEDSCOUT:
			{
   				GivePlayerWeapon(playerid,34,150);
		        GivePlayerWeapon(playerid,24,550);
		        SetPlayerArmour(playerid,50);
		        SetPlayerSkin(playerid,29);
			}

			case ASSASSIN:
			{
			    GivePlayerWeapon(playerid,31,500);
			    GivePlayerWeapon(playerid,25,200);
			    SetPlayerArmour(playerid,60);
			    SetPlayerSkin(playerid,123);
			}

			case VIPENGINEER:
			{
			    GivePlayerWeapon(playerid,31,1000);
			    GivePlayerWeapon(playerid,25,2000);
			    GivePlayerWeapon(playerid,24,500);
			    SetPlayerArmour(playerid,30.0);
			    SetPlayerSkin(playerid,16);
			}

			case VIPMEDIC:
			{
			    GivePlayerWeapon(playerid,31,1000);
			    GivePlayerWeapon(playerid,24,500);
			    SetPlayerArmour(playerid,70.0);
			    SetPlayerSkin(playerid,100);
			}

			case VIPSCOUT:
			{
			    GivePlayerWeapon(playerid,34,130);
			    GivePlayerWeapon(playerid,24,500);
			    SetPlayerArmour(playerid,30.0);
			    SetPlayerSkin(playerid,294);
			}

			case E_ENGINEER:
			{
   				GivePlayerWeapon(playerid,24,200);
			    GivePlayerWeapon(playerid,25,100);
			    SetPlayerArmour(playerid,80.0);
			    SetPlayerSkin(playerid,260);
			}

			case SOLIDER:
			{
				GivePlayerWeapon(playerid,30,300);
			    GivePlayerWeapon(playerid,24,80);
			    SetPlayerArmour(playerid,70.0);
			    SetPlayerSkin(playerid,287);
			}

			case DOCTOR:
			{
				GivePlayerWeapon(playerid,23,150);
			    SetPlayerArmour(playerid,60.0);
			    SetPlayerSkin(playerid,70);
			}
		}
	}

	if(team[playerid] == TEAM_ZOMBIE)
	{
	    ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,9,1);
		SetPlayerArmour(playerid,0);
	    switch(pInfo[playerid][pZombieClass])
	    {
	        case STANDARDZOMBIE: SetPlayerSkin(playerid,181);
	        case MUTATEDZOMBIE: SetPlayerSkin(playerid,26);
	        case FASTZOMBIE: SetPlayerSkin(playerid,162);
	        case REAPERZOMBIE: SetPlayerSkin(playerid,157);
	        case WITCHZOMBIE: SetPlayerSkin(playerid,201);
	        case BOOMERZOMBIE: SetPlayerSkin(playerid,264),SetPlayerHealth(playerid,15);
	        case STOMPERZOMBIE: SetPlayerSkin(playerid,239);
	        case SCREAMERZOMBIE: SetPlayerSkin(playerid,212);
	        case ADVANCEDMUTATED: SetPlayerSkin(playerid,15);
	        case ADVANCEDSCREAMER: SetPlayerSkin(playerid,134);
			case FLESHEATER: SetPlayerSkin(playerid,213);
			case ADVANCEDWITCH: SetPlayerSkin(playerid,198);
			case ADVANCEDBOOMER: SetPlayerSkin(playerid,259);
		}
	}
	return 1;
}

function ScreamerClearAnim(i) return ClearAnimations(i);

stock InfectPlayerStandard(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
		if(pInfo[playerid][IsPlayerInfected] == 0)
		{
	        pInfo[playerid][IsPlayerInfectedTimer] = SetTimerEx("StandardInfection",2000,1,"i",playerid);
			SetPlayerColor(playerid,COLOR_PINK);
			TextDrawShowForPlayer(playerid,Infected[playerid]);
			pInfo[playerid][IsPlayerInfected] = 1;
		}
	}
	return 1;
}

stock InfectPlayerMutated(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
		if(pInfo[playerid][IsPlayerInfected] == 0)
		{
	        pInfo[playerid][IsPlayerInfectedTimer] = SetTimerEx("MutatedInfection",1500,1,"i",playerid);
			SetPlayerColor(playerid,COLOR_PINK);
			TextDrawShowForPlayer(playerid,Infected[playerid]);
			pInfo[playerid][IsPlayerInfected] = 1;
		}
	}
	return 1;
}

stock InfectPlayerFleshEater(playerid)
{
	if(team[playerid] == TEAM_HUMAN)
	{
		if(pInfo[playerid][IsPlayerInfected] == 0)
		{
	        pInfo[playerid][IsPlayerInfectedTimer] = SetTimerEx("FleshEaterInfection",1500,1,"i",playerid);
			SetPlayerColor(playerid,COLOR_PINK);
			TextDrawShowForPlayer(playerid,Infected[playerid]);
			pInfo[playerid][IsPlayerInfected] = 1;
		}
	}
	return 1;
}

stock CurePlayer(playerid)
{
	if(pInfo[playerid][IsPlayerInfected] == 1)
	{
	    KillTimer(pInfo[playerid][IsPlayerInfectedTimer]);
	    pInfo[playerid][IsPlayerInfected] = 0;
	    SetPlayerColor(playerid,COLOR_HUMAN);
		ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,1,1,1,1);
		SetPlayerDrunkLevel(playerid,0);
		TextDrawHideForPlayer(playerid,Infected[playerid]);
	}
	return 1;
}

function StandardInfection(playerid)
{
	GameTextForPlayer(playerid,"~n~~n~~n~~n~~r~Infectado",1000,5);
	new Float:health;
	GetPlayerHealth(playerid, health);
	SetPlayerHealth(playerid, health - 2.5);
}

function MutatedInfection(playerid)
{
    SetPlayerDrunkLevel(playerid,6000);
   	GameTextForPlayer(playerid,"~n~~n~~n~~n~~r~Infectado",1000,5);
	new Float:health;
	GetPlayerHealth(playerid, health);
	SetPlayerHealth(playerid, health - 4.5);
	return 1;
}

function FleshEaterInfection(playerid)
{
    SetPlayerDrunkLevel(playerid,7500);
   	GameTextForPlayer(playerid,"~n~~n~~n~~n~~r~Flesh Eater Infección",1000,5);
	new Float:health;
	GetPlayerHealth(playerid, health);
	SetPlayerHealth(playerid, health - 10.0);
	return 1;
}

stock CheckToStartMap()
{
	if(Map[IsStarted] == 0)
	{
		LoadMap(LoadNewMap());
		StartMap();
		Map[IsStarted] = 1;
	}
	return 1;
}

stock ChangeCameraView(playerid)
{
	new Float:px,Float:py,Float:pz,Float:pa;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, pa);
	//px += floatsin ( -pa,  degrees) * 1.5;
	//py += floatcos ( -pa,  degrees) * 1.5;
	SetPlayerCameraPos(playerid, px, py, pz+6.0);
	SetPlayerCameraLookAt(playerid, px, py, pz);

	/*if(team[playerid] == TEAM_ZOMBIE)
	{
	    ApplyAnimation(playerid, "PED", "KO_shot_stom",4.0,1,0,0,1,0);
	}

	if(team[playerid] == TEAM_HUMAN)
	{
	    ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,1,0);
	}*/
	return 1;
}

stock SendPlayerMaxAmmo( playerid )
{
    new slot, weap, ammo;

    for ( slot = 0; slot < 14; slot++ ) {
        GetPlayerWeaponData( playerid, slot, weap, ammo );
        if ( IsValidWeapon( weap ) ) {
            GivePlayerWeapon( playerid, weap, 99999 );
        }
    }
    return 1;
}

stock IsValidWeapon( weaponid )
{
    if ( weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47 ) return 1;
    return 0;
}

stock GetXPName()
{
	new str[64];
	switch(Map[XPType])
	{
		case 1: str = "~nada~";
		case 2: str = "Doble XP";
		case 3: str = "Triple XP";
		case 4: str = "Cuádruple XP";
	}
	return str;
}

stock NeedXP(playerid,xprequires)
{
	if(pInfo[playerid][pXP] == xprequires) return 1;
	return 1;
}

stock NeedKills(playerid,killrequires)
{
	if(pInfo[playerid][pKills] == killrequires) return 1;
	return 1;
}

CMD:testmykills(playerid,params[])
{
	new myKill;
	if(sscanf(params, "i", myKill)) return SendClientMessage(playerid,-1,""chat" /testmykills [set your own kills]");

	pInfo[playerid][pKills] = myKill;
	return 1;
}

stock CheckToLevelOrRankUp(killerid)
{
	new str[256];

	if(pInfo[killerid][pKills] == 10) { pInfo[killerid][pRank] = 1,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango privado 1",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 50) { pInfo[killerid][pRank] = 2,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango privado I 2",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 100) { pInfo[killerid][pRank] = 3,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango privado II 3",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 150) { pInfo[killerid][pRank] = 4,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a Rango Specialist 4",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 200) { pInfo[killerid][pRank] = 5,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Corporal 5",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 250) { pInfo[killerid][pRank] = 6,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Corporal I 6",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 300) { pInfo[killerid][pRank] = 7,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Corporal II 7",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 350) { pInfo[killerid][pRank] = 8,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Sargento 8",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 400) { pInfo[killerid][pRank] = 9,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Sargento I 9",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 450) { pInfo[killerid][pRank] = 10,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Sargento II 10",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 500) { pInfo[killerid][pRank] = 11,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Comandante 1 1",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 550) { pInfo[killerid][pRank] = 12,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Comandante I 12",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 600) { pInfo[killerid][pRank] = 13,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Comandante II 13",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 650) { pInfo[killerid][pRank] = 14,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Killer 14",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 700) { pInfo[killerid][pRank] = 15,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Killer I 15",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 750) { pInfo[killerid][pRank] = 16,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Killer II 16",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 800) { pInfo[killerid][pRank] = 17,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Mayor 1 7",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 850) { pInfo[killerid][pRank] = 18,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Mayor I 18",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 900) { pInfo[killerid][pRank] = 19,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Mayor II 19",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 950) { pInfo[killerid][pRank] = 20,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Doctor 20",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 1000) { pInfo[killerid][pRank] = 21,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Doctor I 21",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 1500) { pInfo[killerid][pRank] = 22,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Doctor II 22",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 2000) { pInfo[killerid][pRank] = 23,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Coronel 23",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 2500) { pInfo[killerid][pRank] = 24,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Coronel I 24",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 3000) { pInfo[killerid][pRank] = 25,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado a rango Coronel II 25",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 3500) { pInfo[killerid][pRank] = 26,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Francotirador 26",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 4000) { pInfo[killerid][pRank] = 27,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Francotirador I 27",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 4500) { pInfo[killerid][pRank] = 28,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Francotirador II 28",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 5000) { pInfo[killerid][pRank] = 29,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Survivor 29",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 5500) { pInfo[killerid][pRank] = 30,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Survivor I 30",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
	if(pInfo[killerid][pKills] == 6000) { pInfo[killerid][pRank] = 31,format(str,sizeof(str),""chat""COL_PINK" %s ha clasificado hasta el rango Survivor II 31",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
    if(pInfo[killerid][pKills] == 6500) { pInfo[killerid][pRank] = 32,format(str,sizeof(str),""chat""COL_PINK" %s ha Llegado el máximo rango final de la lista 32",PlayerName(killerid)),SendClientMessageToAll(-1,str); }
	return 1;
}

function HideiKilled(playerid)
{
    TextDrawHideForPlayer(playerid, iKilled[playerid]);
    return 1;
}

function C4Explode(playerid)
{
   	new Float:X,Float:Y,Float:Z;
	new Float:hp;
	GetObjectPos(c4Obj[playerid],X,Y,Z);
	foreach(Player,i)
	{
	    if(IsPlayerInRangeOfPoint(i, 3.5,X,Y,Z))
		{
	        if(team[i] == TEAM_ZOMBIE)
			{
				GetPlayerHealth(i,hp);
				SetPlayerHealth(i,hp-35);
			}
		}
	}
	CreateExplosion(X,Y,Z,1,10.0);
	DestroyObject(c4Obj[playerid]);
	return 1;
}

stock CreateEvacMaps()
{
	if(Map[EvacType] == 1)
	{
		CreateObject(19257,-1429.09,-981.20,193.10,3.28,0.00,5.47);
		CreateObject(19257,-1395.39,-948.29,197.89,5.46,357.79,30.09);
		CreateObject(19257,-1486.69,-954.70,191.69,13.12,1.12,280.79);
		CreateObject(790,-1490.30,-948.90,188.10,0.00,0.00,41.56);
		CreateObject(790,-1396.19,-955.59,197.00,0.00,0.00,196.38);
		CreateObject(790,-1435.79,-984.19,189.60,0.00,0.00,127.25);
		CreateObject(2060,-1433.19,-985.50,192.80,0.00,0.00,0.00);
		CreateObject(2060,-1432.19,-985.40,192.69,0.00,0.00,0.00);
		CreateObject(2060,-1431.09,-985.20,192.60,0.00,0.00,0.00);
		CreateObject(2060,-1430.19,-984.90,192.50,0.00,0.00,0.00);
		CreateObject(2060,-1429.19,-984.79,192.50,0.00,0.00,0.00);
		CreateObject(2060,-1428.09,-984.70,192.50,0.00,0.00,0.00);
		CreateObject(2060,-1427.09,-984.59,192.50,0.00,0.00,0.00);
		CreateObject(2060,-1426.09,-984.50,192.39,0.00,0.00,0.00);
		CreateObject(2060,-1425.00,-984.40,192.39,0.00,0.00,0.00);
		CreateObject(2060,-1424.09,-984.29,192.39,0.00,0.00,0.00);
		CreateObject(2060,-1424.30,-984.29,192.69,0.00,0.00,0.00);
		CreateObject(2060,-1425.50,-984.50,192.69,0.00,0.00,0.00);
		CreateObject(2060,-1426.50,-984.59,192.69,0.00,0.00,0.00);
		CreateObject(2060,-1427.50,-984.59,192.69,0.00,0.00,0.00);
		CreateObject(2060,-1428.40,-984.90,192.80,0.00,0.00,0.00);
		CreateObject(2060,-1429.40,-985.00,192.80,0.00,0.00,0.00);
		CreateObject(2060,-1430.50,-985.00,192.80,0.00,0.00,0.00);
		CreateObject(2060,-1431.50,-985.29,192.89,0.00,0.00,0.00);
		CreateObject(2060,-1432.50,-985.59,193.00,0.00,0.00,0.00);
		CreateObject(2060,-1433.19,-985.29,193.10,0.00,0.00,0.00);
		CreateObject(2060,-1431.90,-985.40,193.30,0.00,0.00,0.00);
		CreateObject(2060,-1431.80,-985.00,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1430.90,-984.90,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1429.90,-984.79,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1428.90,-984.70,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1427.90,-984.59,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1427.00,-984.59,193.10,0.00,0.00,0.00);
		CreateObject(2060,-1425.90,-984.50,193.10,0.00,0.00,0.00);
		CreateObject(2060,-1424.80,-984.40,193.00,0.00,0.00,0.00);
		CreateObject(2060,-1424.09,-984.29,193.00,0.00,0.00,0.00);
		CreateObject(2060,-1433.09,-984.70,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1431.90,-984.40,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1430.69,-984.29,193.10,0.00,0.00,0.00);
		CreateObject(2060,-1429.50,-984.50,193.50,0.00,0.00,0.00);
		CreateObject(2060,-1428.50,-984.09,193.10,0.00,0.00,0.00);
		CreateObject(2060,-1427.00,-984.40,193.39,0.00,0.00,0.00);
		CreateObject(2060,-1425.80,-984.00,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1424.59,-983.79,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1427.19,-983.70,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1425.69,-983.09,193.30,0.00,0.00,0.00);
		CreateObject(2060,-1424.50,-983.09,193.30,0.00,0.00,0.00);
		CreateObject(2060,-1425.69,-983.59,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1432.09,-983.79,193.30,0.00,0.00,0.00);
		CreateObject(2060,-1430.50,-983.79,193.30,0.00,0.00,0.00);
		CreateObject(2060,-1429.30,-983.90,193.19,0.00,0.00,0.00);
		CreateObject(2060,-1429.00,-983.50,194.39,0.00,0.00,5.47);
		CreateObject(2060,-1394.30,-950.09,199.00,0.00,0.00,211.35);
		CreateObject(2060,-1489.59,-953.09,191.89,0.00,0.00,284.11);
		CreateObject(2060,-1489.40,-954.20,191.80,0.00,0.00,284.11);
		CreateObject(2060,-1489.19,-955.20,191.80,0.00,0.00,284.11);
		CreateObject(2060,-1489.00,-956.00,191.80,0.00,0.00,284.11);
		CreateObject(2060,-1488.80,-957.09,191.80,0.00,0.00,284.11);
		CreateObject(2060,-1489.80,-952.59,192.19,0.00,0.00,284.11);
		CreateObject(2060,-1489.50,-953.59,192.19,0.00,0.00,284.11);
		CreateObject(2060,-1489.30,-954.59,192.10,0.00,0.00,284.11);
		CreateObject(2060,-1489.09,-955.70,192.10,0.00,0.00,284.11);
		CreateObject(2060,-1488.90,-956.79,192.10,0.00,0.00,284.11);
		CreateObject(2060,-1489.09,-955.09,192.60,0.00,0.00,284.11);
		CreateObject(3884,-1395.19,-948.40,201.60,0.00,1.09,212.76);
		CreateObject(3095,-1455.59,-922.40,200.50,0.00,358.90,269.99);
		CreateObject(3885,-1454.69,-923.29,202.19,0.00,0.00,0.00);
		CreateObject(3885,-1429.19,-981.40,197.00,4.37,0.00,0.00);
		CreateObject(3885,-1487.19,-954.79,195.10,0.00,353.43,358.90);
		CreateObject(3885,-1395.30,-948.40,201.80,5.47,1.09,359.89);
		CreateObject(3884,-1454.30,-923.29,202.10,0.00,0.00,359.25);
		CreateObject(3884,-1429.30,-981.29,196.80,0.00,0.00,182.98);
		CreateObject(3884,-1487.00,-954.90,195.10,352.33,1.10,98.38);
		CreateObject(3279,-1480.50,-961.20,192.30,358.90,356.71,92.34);
		CreateObject(3279,-1382.09,-941.19,198.00,0.00,0.00,213.32);
		CreateObject(3279,-1416.29,-975.59,194.19,358.90,356.70,92.41);
		CreateObject(987,-1444.29,-983.50,192.50,0.00,0.00,0.00);
		CreateObject(987,-1456.19,-983.59,192.50,0.00,0.00,0.00);
		CreateObject(987,-1468.19,-983.59,192.60,0.00,0.00,0.00);
		CreateObject(987,-1479.39,-979.59,192.60,0.00,0.00,340.25);
		CreateObject(987,-1483.90,-968.40,191.10,0.00,0.00,293.06);
		CreateObject(987,-1487.09,-958.19,191.10,0.00,0.00,288.67);
		CreateObject(987,-1489.90,-939.79,191.69,0.00,0.00,277.72);
		CreateObject(987,-1491.50,-928.09,191.69,0.00,0.00,277.71);
		CreateObject(987,-1483.59,-918.69,194.50,1.08,6.56,230.32);
		CreateObject(987,-1473.50,-913.50,197.69,1.08,6.56,208.31);
		CreateObject(987,-1462.30,-912.20,200.60,359.99,359.99,187.59);
		CreateObject(987,-1473.50,-913.50,200.60,1.08,6.56,208.31);
		CreateObject(987,-1483.90,-919.09,199.19,1.08,6.56,230.32);
		CreateObject(987,-1491.50,-928.09,198.00,0.00,0.00,277.71);
		CreateObject(987,-1489.90,-939.79,198.00,0.00,0.00,277.72);
		CreateObject(987,-1487.09,-958.20,196.80,0.00,0.00,288.67);
		CreateObject(987,-1483.90,-968.40,196.69,0.00,0.00,293.06);
		CreateObject(987,-1479.40,-979.59,196.69,0.00,0.00,340.25);
		CreateObject(987,-1468.19,-983.59,196.60,0.00,0.00,0.00);
		CreateObject(987,-1456.19,-983.59,196.60,0.00,0.00,0.00);
		CreateObject(987,-1444.30,-983.50,196.60,0.00,0.00,0.00);
		CreateObject(987,-1450.50,-910.59,200.60,359.98,359.98,187.59);
		CreateObject(987,-1438.69,-909.09,200.39,359.98,359.98,187.59);
		CreateObject(987,-1427.30,-909.20,196.39,359.98,359.98,180.42);
		CreateObject(987,-1427.30,-909.20,200.10,359.98,359.98,180.41);
		CreateObject(987,-1415.69,-909.20,194.50,359.98,359.98,180.41);
		CreateObject(987,-1415.50,-909.09,200.10,359.98,359.98,180.41);
		CreateObject(987,-1404.00,-909.09,190.69,359.98,359.98,180.41);
		CreateObject(987,-1404.00,-909.09,195.89,359.98,359.98,180.41);
		CreateObject(987,-1404.00,-909.09,200.10,359.98,359.98,180.41);
		CreateObject(987,-1392.30,-909.00,189.00,359.98,359.98,180.41);
		CreateObject(987,-1392.30,-909.00,194.00,359.98,359.98,180.41);
		CreateObject(987,-1392.30,-909.00,200.00,359.98,359.98,180.41);
		CreateObject(987,-1380.30,-908.90,186.10,359.98,359.98,180.41);
		CreateObject(987,-1380.30,-908.90,192.39,359.98,359.98,180.41);
		CreateObject(987,-1380.30,-908.90,197.10,359.98,359.98,180.41);
		CreateObject(987,-1380.30,-908.90,200.00,359.98,359.98,180.41);
		CreateObject(987,-1373.40,-918.40,186.10,359.98,359.98,125.45);
		CreateObject(987,-1373.40,-918.40,191.19,359.97,359.97,125.44);
		CreateObject(987,-1373.40,-918.40,196.39,359.97,359.97,125.44);
		CreateObject(987,-1373.40,-918.40,200.00,359.97,359.97,125.44);
		CreateObject(987,-1374.80,-930.09,190.50,359.97,5.45,83.73);
		CreateObject(987,-1374.90,-929.70,195.00,359.97,2.16,83.73);
		CreateObject(987,-1374.90,-929.70,200.50,359.97,2.16,83.72);
		CreateObject(987,-1376.00,-941.59,194.19,359.97,5.44,83.73);
		CreateObject(987,-1376.09,-941.20,199.10,359.97,3.25,83.73);
		CreateObject(987,-1376.09,-941.20,201.19,359.97,3.25,83.72);
		CreateObject(987,-1380.09,-952.20,197.39,357.78,358.87,69.37);
		CreateObject(987,-1380.09,-952.20,201.00,357.78,358.87,69.37);
		CreateObject(987,-1391.09,-979.00,191.80,357.78,358.87,37.37);
		CreateObject(987,-1426.09,-981.50,192.50,0.00,0.00,0.00);
		CreateObject(987,-1414.09,-981.50,192.00,0.00,0.00,0.00);
		CreateObject(987,-1402.80,-981.40,192.00,0.00,0.00,12.04);
		CreateObject(987,-1426.09,-981.50,196.39,0.00,0.00,0.00);
		CreateObject(987,-1414.09,-981.50,196.39,0.00,0.00,0.00);
		CreateObject(987,-1402.80,-981.40,196.39,0.00,0.00,12.04);
		CreateObject(987,-1391.09,-979.00,196.39,357.78,358.86,37.37);
		CreateObject(11488,-1437.40,-952.59,200.10,0.00,0.00,346.86);
		CreateObject(2745,-1394.59,-949.70,198.39,0.00,0.00,29.67);
		CreateObject(3265,-1380.19,-962.79,196.39,0.00,0.00,85.73);
		CreateObject(3265,-1489.50,-958.20,193.60,0.00,0.00,277.62);
		CreateObject(3265,-1423.89,-983.19,193.10,0.00,0.00,1.12);
		CreateObject(2745,-1429.09,-982.90,193.69,0.00,0.00,14.33);
		CreateObject(2745,-1488.80,-955.00,192.00,0.00,0.00,280.90);
		CreateObject(2892,-1381.50,-966.59,196.10,4.36,4.39,359.66);
		CreateObject(987,-1381.69,-962.00,196.60,357.78,358.87,80.32);
		CreateObject(18850,-1425.80,-925.59,195.10,0.00,0.00,0.00);
		AddStaticVehicleEx(432,-1434.40,-947.09,201.10,262.15,-1,-1,50);
		AddStaticVehicleEx(433,-1445.09,-963.79,202.00,0.00,-1,-1,50);
		AddStaticVehicleEx(433,-1450.69,-963.09,202.69,0.00,-1,-1,50);
		CreateObject(2985,-1394.40,-950.09,198.30,0.00,0.00,305.03);
		CreateObject(2985,-1488.80,-955.00,191.80,358.94,16.42,193.21);
		CreateObject(2985,-1429.09,-983.19,193.60,358.94,16.42,276.75);
		AddStaticVehicleEx(471,-1467.09,-944.40,203.69,262.10,-1,-1,50);
		AddStaticVehicleEx(470,-1435.00,-958.70,201.10,270.90,-1,-1,50);
		AddStaticVehicleEx(470,-1435.19,-953.40,201.10,270.90,-1,-1,50);
		CreateObject(1596,-1425.40,-968.20,205.19,0.00,0.00,3.43);
		CreateObject(1596,-1459.30,-926.59,203.00,0.00,0.00,329.33);
		CreateObject(1596,-1437.00,-967.00,205.19,0.00,0.00,271.08);
		AddStaticVehicleEx(548,-1427.90,-925.59,210.30,269.81,-1,-1,50);
		CreateObject(3030,-1414.09,-937.09,207.39,0.00,0.00,0.00);
		CreateObject(3030,-1427.19,-978.40,194.60,358.91,353.35,229.40);
		CreateObject(3030,-1484.79,-951.69,193.39,0.00,0.00,52.66);
		CreateObject(3030,-1395.29,-945.59,199.19,19.70,0.00,172.40);
		CreateObject(3030,-1429.30,-966.70,202.69,358.91,353.35,284.36);
		CreateObject(3763,-1471.90,-919.29,233.80,0.00,0.00,0.00);
		CreateObject(3932,-1467.80,-945.09,204.69,0.00,0.00,353.43);
		CreateObject(3932,-1460.00,-939.59,203.39,357.81,357.80,267.61);
		CreateObject(3066,-1433.00,-963.59,200.89,358.83,1.09,269.87);
		CreateObject(3046,-1424.69,-967.40,200.19,0.00,0.00,0.00);
		CreateObject(3046,-1425.90,-967.40,200.19,0.00,0.00,0.00);
		CreateObject(3046,-1427.00,-967.29,200.19,0.00,0.00,0.00);
		CreateObject(3046,-1428.00,-967.29,200.30,0.00,0.00,0.00);
		CreateObject(2973,-1436.09,-967.00,200.00,0.00,0.00,0.00);
		CreateObject(2973,-1432.30,-966.79,200.00,0.00,0.00,0.00);
		CreateObject(2973,-1429.30,-967.00,199.89,0.00,0.00,0.00);
		CreateObject(930,-1470.00,-947.29,203.50,0.00,0.00,0.00);
		CreateObject(930,-1468.69,-947.40,203.60,0.00,0.00,356.71);
		CreateObject(2669,-1430.09,-932.59,201.80,0.00,0.00,0.00);
		CreateObject(2068,-1433.59,-931.90,201.39,273.24,0.00,59.27);
		CreateObject(2068,-1429.40,-927.59,201.39,273.24,0.00,4.26);
		CreateObject(2068,-1423.69,-929.00,201.00,273.24,0.00,329.12);
		CreateObject(2068,-1419.50,-932.29,201.00,273.24,0.00,320.35);
		CreateObject(2068,-1431.40,-928.59,201.39,273.24,0.00,33.97);
		CreateObject(16782,-1430.09,-930.29,201.89,0.00,0.00,268.82);
		CreateObject(3877,-1399.00,-947.20,203.10,0.00,0.00,0.00);
		CreateObject(3877,-1451.80,-926.09,202.80,0.00,0.00,0.00);
		CreateObject(3877,-1484.09,-956.79,197.30,0.00,0.00,0.00);
		CreateObject(3877,-1431.90,-978.70,198.30,0.00,0.00,0.00);
		CreateObject(790,-1470.50,-976.50,191.60,0.00,0.00,127.25);
		CreateObject(790,-1467.19,-981.79,191.60,0.00,0.00,127.25);
		CreateObject(790,-1470.30,-956.09,190.69,0.00,0.00,231.63);
		CreateObject(790,-1471.40,-936.59,190.69,0.00,0.00,269.00);
		CreateObject(790,-1381.09,-922.90,192.50,0.00,358.90,272.22);
		CreateObject(790,-1389.50,-933.00,192.50,0.00,358.90,206.26);
		CreateObject(1554,-1466.09,-947.79,203.10,0.00,0.00,0.00);
		CreateObject(1554,-1467.09,-947.59,203.19,0.00,0.00,0.00);
		CreateObject(1554,-1467.80,-947.20,203.19,0.00,0.00,0.00);
		CreateObject(1213,-1381.40,-963.59,196.60,0.00,0.00,0.00);
		CreateObject(1213,-1381.50,-966.50,196.19,0.00,0.00,0.00);
		CreateObject(1213,-1381.50,-968.29,196.00,0.00,0.00,0.00);
		CreateObject(1213,-1381.50,-969.90,196.00,0.00,0.00,0.00);
		CreateObject(5821,-1443.80,-928.59,203.19,0.00,0.00,358.90);
		CreateObject(967,-1381.59,-971.00,195.60,0.00,0.00,0.00);
		CreateObject(2985,-1381.19,-971.00,195.89,0.00,6.56,1.09);
		CreateObject(2745,-1381.40,-971.00,196.19,0.00,0.00,94.52);
		CreateObject(1250,-1381.90,-962.59,197.50,0.00,0.00,0.00);
		CreateObject(1374,-1382.00,-963.29,197.89,0.00,0.00,182.48);
		CreateObject(18762,-1382.09,-962.50,195.00,0.00,0.00,0.00);
		CreateObject(17055,-1463.19,-961.59,202.60,13.13,1.12,330.07);
		CreateObject(16662,-1418.09,-928.79,201.30,0.00,0.00,288.25);
		CreateObject(18765,-1418.19,-929.29,198.69,270.11,180.00,133.86);
		CreateObject(18765,-1425.30,-925.09,198.69,270.11,179.99,165.61);
		CreateObject(18765,-1431.19,-923.40,198.69,270.00,175.62,160.18);
		CreateObject(3807,-1424.90,-933.70,200.10,359.61,290.76,8.75);
		CreateObject(3791,-1458.69,-937.70,202.30,0.00,8.75,0.00);
		CreateObject(3791,-1458.80,-939.29,202.30,0.00,8.75,0.00);
		CreateObject(3791,-1458.90,-940.90,202.30,0.00,8.75,0.00);
		CreateObject(3795,-1461.59,-939.90,202.80,0.00,0.00,85.73);
		CreateObject(18765,-1435.40,-926.90,198.69,270.11,179.99,246.85);
		//Objects:209,Vehicles:7
	}

	if(Map[EvacType] == 2)
	{
		Map[AllowWater] = 1;
		CreateObject(10794,3051.59,494.00,4.50,0.00,0.00,44.98);
		CreateObject(10793,2999.39,441.50,29.60,0.00,0.00,44.99);
		CreateObject(10795,3050.50,492.89,14.50,0.00,0.00,44.99);
		CreateObject(1691,3018.39,504.29,0.69,0.00,274.30,330.28);
		CreateObject(18762,3028.80,497.20,0.60,0.00,91.17,354.48);
		CreateObject(18762,3030.00,499.60,0.60,0.00,91.16,310.61);
		CreateObject(18762,3026.80,503.00,0.69,0.00,91.16,316.08);
		CreateObject(18762,3024.19,497.79,0.60,0.00,88.97,351.49);
		CreateObject(18762,3023.39,505.79,0.80,0.00,91.15,324.84);
		CreateObject(18762,3019.69,498.89,0.60,0.00,91.17,339.45);
		CreateObject(18762,3017.89,501.70,0.69,0.00,91.17,245.05);
		CreateObject(18762,3020.00,505.79,0.80,0.00,91.17,240.16);
		CreateObject(18765,3023.80,502.20,-4.69,0.01,88.98,56.17);
		CreateObject(18762,3024.60,498.20,-0.30,0.00,91.17,341.64);
		CreateObject(18762,3022.00,499.70,-0.20,0.00,91.17,326.14);
		CreateObject(18762,3020.30,500.79,-0.20,0.00,91.17,326.14);
		CreateObject(18762,3019.89,500.10,-0.20,0.00,91.17,326.14);
		CreateObject(18762,3019.69,499.79,-0.20,0.00,91.17,340.37);
		CreateObject(18762,3029.80,498.89,-0.20,0.00,91.17,314.10);
		CreateObject(18762,3029.19,498.60,-0.20,0.00,91.17,314.09);
		CreateObject(18762,3029.10,497.70,-0.20,0.00,91.17,345.85);
		CreateObject(18762,3029.30,498.10,-0.20,0.00,91.17,339.28);
		CreateObject(18762,3033.10,496.00,0.50,0.00,91.16,310.61);
		CreateObject(18762,3033.30,496.70,0.50,0.00,91.17,354.47);
		CreateObject(18762,3020.60,499.79,-0.20,0.00,91.17,326.14);
		CreateObject(11245,3019.89,507.79,2.90,0.00,312.80,147.30);
		CreateObject(2983,3022.19,504.10,0.80,318.43,2.92,229.23);
		CreateObject(3350,3022.80,504.79,-0.40,0.00,0.00,47.22);
		CreateObject(2985,3031.19,497.39,0.40,0.00,355.62,327.07);
		CreateObject(2207,3021.89,503.10,0.30,0.00,0.00,46.13);
		CreateObject(2985,3020.60,498.60,0.40,0.00,355.61,260.07);
		CreateObject(2985,3025.19,504.60,0.50,0.00,355.61,48.50);
		CreateObject(9831,3016.69,505.70,0.30,43.79,0.00,63.68);
		CreateObject(18762,3031.30,502.00,0.60,0.00,91.16,46.12);
		CreateObject(18762,3032.00,501.29,0.60,0.00,91.15,46.12);
		CreateObject(18762,3032.69,500.70,0.60,0.00,91.15,46.12);
		CreateObject(18850,3023.39,466.29,7.19,0.00,0.00,314.92);
		AddStaticVehicleEx(548,3023.89,466.20,22.39,224.77,-1,-1,50);
		CreateObject(3884,3103.10,546.00,20.39,0.00,0.00,25.75);
		CreateObject(3277,3055.39,479.00,13.80,0.00,0.00,0.00);
		CreateObject(3277,3103.60,546.40,20.50,0.00,0.00,156.13);
		CreateObject(3884,3055.50,479.29,13.60,0.00,0.00,181.88);
		CreateObject(3877,2999.10,463.89,28.79,0.00,0.00,45.03);
		CreateObject(3877,3021.59,441.09,28.79,0.00,0.00,45.03);
		CreateObject(3877,3098.39,547.90,20.50,0.00,0.00,45.03);
		CreateObject(3877,3060.19,479.39,15.39,0.00,0.00,45.03);
		CreateObject(3066,3080.19,500.29,14.80,0.00,0.00,314.96);
		CreateObject(3066,3089.30,509.50,14.80,0.00,0.00,314.96);
		CreateObject(3066,3097.80,517.79,14.80,0.00,0.00,314.96);
		AddStaticVehicleEx(470,3041.89,496.00,14.89,43.94,-1,-1,50);
		AddStaticVehicleEx(470,3049.60,488.39,14.89,43.93,-1,-1,50);
		CreateObject(13489,3029.69,491.60,15.69,0.00,0.00,314.96);
		CreateObject(8885,3114.60,539.90,17.20,0.00,0.00,57.22);
		CreateObject(11237,3082.39,524.79,20.39,0.00,0.00,46.20);
		CreateObject(3791,3044.30,465.50,14.19,0.00,0.00,0.00);
		CreateObject(3791,3047.80,467.60,14.19,0.00,0.00,45.14);
		CreateObject(3791,3046.50,468.79,14.19,0.00,0.00,45.14);
		CreateObject(3791,3050.80,471.10,14.19,0.00,0.00,45.14);
		CreateObject(3791,3049.50,472.10,14.19,0.00,0.00,45.14);
		CreateObject(3791,3045.39,470.20,14.19,0.00,0.00,45.14);
		CreateObject(3791,3048.19,473.29,14.19,0.00,0.00,45.14);
		AddStaticVehicleEx(595,3003.89,494.09,0.00,174.11,-1,-1,50);
		CreateObject(7981,3111.10,552.09,18.79,0.00,0.00,46.20);
		CreateObject(3877,3105.19,541.50,20.60,0.00,0.00,45.03);
		CreateObject(1682,3115.60,556.40,30.29,0.00,0.00,317.07);
		CreateObject(2061,3108.00,562.70,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.30,562.50,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.50,562.29,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.60,562.09,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.89,562.00,14.10,0.00,0.00,0.00);
		CreateObject(2061,3109.00,561.79,14.10,0.00,0.00,0.00);
		CreateObject(2061,3109.19,561.59,14.10,0.00,0.00,0.00);
		CreateObject(2061,3109.39,561.50,14.10,0.00,0.00,0.00);
		CreateObject(2061,3109.50,561.29,14.10,0.00,0.00,0.00);
		CreateObject(2061,3107.89,562.29,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.10,562.09,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.19,561.90,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.50,561.79,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.69,561.50,14.10,0.00,0.00,0.00);
		CreateObject(2061,3108.89,561.29,14.10,0.00,0.00,0.00);
		CreateObject(2061,3109.10,561.09,14.10,0.00,0.00,0.00);
		CreateObject(1213,3017.10,500.00,0.89,0.00,0.00,0.00);
		CreateObject(1691,3139.89,580.90,26.00,0.00,277.58,223.67);
		CreateObject(3258,3115.80,561.29,21.89,0.00,82.33,42.81);
		CreateObject(3258,3118.50,558.50,21.89,0.00,82.33,42.80);
		CreateObject(16782,3011.60,452.79,23.50,0.00,0.00,47.33);
		CreateObject(18683,3141.00,580.20,26.20,0.00,0.00,0.00);
		CreateObject(18683,3138.80,583.00,26.20,0.00,0.00,0.00);
		//Objects:84,Vehicles:4

	}

	if(Map[EvacType] == 3)
	{
  		CreateObject(14548,257.00,2510.10,123.50,13.13,0.00,270.90);
		CreateObject(16782,227.10,2512.80,123.09,0.00,0.00,0.00);
		CreateObject(5156,252.30,2507.39,118.80,8.75,1.10,92.13);
		CreateObject(3256,246.30,2488.30,117.59,0.00,281.89,0.00);
		CreateObject(3256,247.89,2466.10,118.00,0.00,282.98,0.00);
		CreateObject(3256,247.69,2442.50,118.00,0.00,282.98,0.00);
		CreateObject(3256,245.10,2531.30,116.90,359.99,284.08,0.00);
		CreateObject(3256,243.39,2554.39,116.90,0.00,281.89,0.00);
		CreateObject(3256,241.50,2573.80,116.90,0.00,280.79,0.00);
		CreateObject(2117,231.69,2514.00,121.40,0.00,0.00,0.00);
		CreateObject(2117,233.69,2514.00,121.40,0.00,0.00,0.00);
		CreateObject(1753,239.69,2513.89,121.50,0.00,0.00,0.00);
		CreateObject(1753,242.89,2512.50,121.50,0.00,1.09,269.85);
		CreateObject(15037,241.00,2506.50,121.90,0.00,0.00,94.52);
		CreateObject(2063,261.20,2505.69,122.40,0.00,0.00,180.83);
		CreateObject(2063,264.89,2505.80,122.40,0.00,0.00,180.82);
		CreateObject(2063,268.70,2505.89,122.40,0.00,0.00,180.82);
		CreateObject(2606,234.19,2514.39,122.40,0.00,0.00,0.00);
		CreateObject(2616,227.19,2506.60,122.50,0.00,0.00,91.06);
		CreateObject(2611,229.10,2514.30,122.69,6.56,358.89,0.12);
		CreateObject(2053,231.39,2513.69,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.39,2514.10,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.60,2514.19,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.60,2514.00,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.60,2513.69,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.80,2513.69,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.80,2514.19,122.30,0.00,0.00,0.00);
		CreateObject(2053,231.89,2514.00,122.30,0.00,0.00,0.00);
		CreateObject(2202,229.80,2513.80,121.40,0.00,0.00,0.00);
		CreateObject(1714,234.30,2512.80,121.40,0.00,0.00,225.90);
		CreateObject(1714,237.10,2506.89,121.40,0.00,0.00,60.58);
		CreateObject(2763,240.60,2511.89,121.90,0.00,0.00,0.00);
		CreateObject(3383,232.50,2505.60,121.40,0.00,0.00,0.00);
		CreateObject(11631,237.80,2506.10,122.69,0.00,0.00,180.90);
		CreateObject(3111,233.60,2505.69,122.50,0.00,0.00,0.00);
		CreateObject(3031,228.39,2505.60,123.00,0.00,0.00,47.22);
		CreateObject(3017,230.80,2505.89,122.59,0.00,0.00,269.02);
		CreateObject(2919,257.79,2506.19,122.19,0.00,0.00,0.00);
		CreateObject(1808,236.30,2514.19,121.40,0.00,0.00,0.00);
		CreateObject(2827,240.50,2512.10,122.30,0.00,0.00,0.00);
		CreateObject(2683,240.89,2511.89,122.40,0.00,0.00,0.00);
		CreateObject(2683,240.80,2511.60,122.40,0.00,0.00,0.00);
		CreateObject(2683,240.39,2511.69,122.40,0.00,0.00,0.00);
		CreateObject(3791,254.19,2506.39,122.00,0.00,0.00,0.00);
		CreateObject(3791,250.89,2506.30,121.90,0.00,0.00,0.00);
		CreateObject(3791,254.10,2507.80,122.00,0.00,0.00,0.00);
		CreateObject(3791,271.89,2506.30,122.00,0.00,0.00,0.00);
		CreateObject(2886,226.69,2510.89,123.09,0.00,0.00,0.00);
		AddStaticVehicleEx(470,274.50,2513.50,122.59,272.98,-1,-1,50);
		AddStaticVehicleEx(470,267.00,2513.10,122.59,270.79,-1,-1,50);
		CreateObject(3066,252.50,2513.50,122.50,0.00,0.00,272.11);
		CreateObject(3046,259.39,2513.89,121.90,0.00,0.00,0.00);
		CreateObject(3046,260.39,2513.80,121.90,0.00,0.00,0.00);
		CreateObject(3046,261.29,2513.80,121.90,0.00,0.00,0.00);
		CreateObject(3046,262.20,2513.80,121.90,0.00,0.00,0.00);
		CreateObject(3046,263.00,2514.00,121.90,0.00,0.00,0.00);
		CreateObject(3013,260.60,2505.80,123.40,0.00,0.00,0.00);
		CreateObject(3013,261.39,2505.69,123.30,0.00,0.00,0.00);
		CreateObject(3013,262.00,2505.80,123.30,0.00,0.00,0.00);
		CreateObject(3013,265.39,2506.00,123.00,0.00,0.00,0.00);
		CreateObject(3013,264.50,2505.89,122.59,0.00,0.00,0.00);
		CreateObject(3013,265.60,2505.89,122.19,0.00,0.00,0.00);
		CreateObject(3013,269.10,2506.10,123.00,0.00,0.00,0.00);
		CreateObject(3013,268.10,2505.89,123.30,0.00,0.00,0.00);
		CreateObject(3013,268.00,2506.00,122.50,0.00,0.00,0.00);
		CreateObject(2973,247.50,2506.10,121.50,0.00,0.00,0.00);
		CreateObject(964,274.60,2506.19,121.50,0.00,0.00,0.00);
		CreateObject(964,246.50,2513.89,121.50,0.00,0.00,0.00);
		CreateObject(964,244.50,2513.89,121.50,0.00,0.00,0.00);
		CreateObject(964,237.89,2513.69,121.50,0.00,0.00,0.00);
		CreateObject(964,235.50,2505.69,121.40,0.00,0.00,0.00);
		CreateObject(2041,262.10,2505.80,122.50,0.00,0.00,178.64);
		CreateObject(1242,269.70,2506.00,122.00,0.00,0.00,0.00);
		CreateObject(1242,268.89,2505.89,122.00,0.00,0.00,0.00);
		CreateObject(1242,267.89,2505.89,122.00,0.00,0.00,0.00);
		CreateObject(2035,269.10,2506.00,122.40,1.09,3.28,359.93);
		CreateObject(2035,265.39,2505.80,122.40,1.08,1.09,359.97);
		CreateObject(2035,260.60,2505.80,122.40,1.08,359.53,0.00);
		CreateObject(2036,264.70,2505.89,123.30,0.00,0.00,0.00);
		CreateObject(2044,264.79,2506.00,122.90,0.00,0.00,0.00);
		CreateObject(2045,261.60,2505.80,122.80,0.00,0.00,269.88);
		//Objects:79,Vehicles:2

	}
	return 1;
}

stock SpawnVars(playerid)
{
	TextDrawHideForPlayer(playerid, ServerIntroOne[playerid]);
	TextDrawHideForPlayer(playerid, ServerIntroTwo[playerid]);
	ShowTextdrawsAfterConnect(playerid);

	if(pInfo[playerid][pRank] >= 18)
	{
		SetPlayerAttachedObject(playerid,1,18978,2,0.065999,0.012999,0.000000,16.099998,81.499969,81.000000,1.000000,1.000000,1.000000);
	}
	return 1;
}

stock sendClassMessage(playerid)
{
	new string[128];
	if(team[playerid] == TEAM_HUMAN) format(string,sizeof(string),""chat""COL_YELLOW" Usted es un %s para cambiar de clase use /clases y escoja su equipo y armamento",GetClassName(playerid));
    if(team[playerid] == TEAM_ZOMBIE) format(string,sizeof(string),""chat""COL_YELLOW" Usted es un %s use /clases para cambiar de clase y comer mas rapido a los humanos",GetClassName(playerid));
    SendClientMessage(playerid,-1,string);
    return 1;
}

stock ShowTextdrawsAfterConnect(playerid)
{
	TextDrawShowForPlayer(playerid, TimeLeft);
	TextDrawShowForPlayer(playerid, UntilRescue);
	TextDrawShowForPlayer(playerid, AliveInfo);
	TextDrawShowForPlayer(playerid, remadeText);
	TextDrawShowForPlayer(playerid, remadeText2);
	TextDrawShowForPlayer(playerid, CurrentMap);
	TextDrawShowForPlayer(playerid, XP);
	TextDrawShowForPlayer(playerid, myXP[playerid]);
	TextDrawShowForPlayer(playerid, EventText);
	return 1;
}

stock hideTextdrawsAfterConnect(playerid)
{
	TextDrawHideForPlayer(playerid, TimeLeft);
	TextDrawHideForPlayer(playerid, UntilRescue);
	TextDrawHideForPlayer(playerid, AliveInfo);
	TextDrawHideForPlayer(playerid, remadeText);
	TextDrawHideForPlayer(playerid, remadeText2);
	TextDrawHideForPlayer(playerid, CurrentMap);
	TextDrawHideForPlayer(playerid, XP);
	TextDrawHideForPlayer(playerid, myXP[playerid]);
	TextDrawHideForPlayer(playerid, EventText);
	return 1;
}

stock GetClassName(playerid)
{
	new classname[64];
	if(team[playerid] == TEAM_HUMAN)
	{
	    switch(pInfo[playerid][pHumanClass])
		{
		    case CIVILIAN: classname = "Civil";
		    case POLICEMAN: classname = "Policia";
		    case MEDIC: classname = "Medico";
		    case SCOUT: classname = "Scout";
		    case HEAVYMEDIC: classname = "Heavy Medico";
		    case FARMER: classname = "Farmer";
		    case ENGINEER: classname = "Engeniero";
		    case SWAT: classname = "Oscuro";
		    case HEAVYSHOTGUN: classname = "Heavy Shoutgun";
		    case ADVANCEDMEDIC: classname = "Medico Avanzado";
		    case ADVANCEDENGINEER: classname = "Engeniero Avanzado";
		    case FEDERALAGENT: classname = "Agente Federal";
		    case KICKBACK: classname = "Kick Back";
		    case ADVANCEDSCOUT: classname = "Scout Avanzado";
		    case ASSASSIN: classname = "Asesino";
		    case VIPENGINEER: classname = "V.I.P Engeniero";
		    case VIPMEDIC: classname = "V.I.P Medico";
		    case VIPSCOUT: classname = "V.I.P Scout";
		    case E_ENGINEER: classname = "Experienced Engeniero";
		    case DOCTOR: classname = "Doctor";
		}
	}

	if(team[playerid] == TEAM_ZOMBIE)
	{
	    switch(pInfo[playerid][pZombieClass])
	    {
	        case STANDARDZOMBIE: classname = "Standard Zombie";
	        case MUTATEDZOMBIE: classname = "Muteado Zombie";
	        case FASTZOMBIE: classname = "Fast Zombie";
	        case REAPERZOMBIE: classname = "Reaper Zombie";
	        case WITCHZOMBIE: classname = "Witch Zombie";
	        case BOOMERZOMBIE: classname = "Boomer Zombie";
	        case STOMPERZOMBIE: classname = "Stomper Zombie";
	        case SCREAMERZOMBIE: classname = "Screamer Zombie";
	        case ADVANCEDMUTATED: classname = "Advanced Mutated";
	        case ADVANCEDSCREAMER: classname = "Advanced Screamer";
            case FLESHEATER: classname = "Flesh Eater";
            case ADVANCEDWITCH: classname = "Advanced Witch";
            case ADVANCEDBOOMER: classname = "Advanced Boomer";
		}
	}
	return classname;
}

stock GetAdminName(playerid)
{
	new adminname[128];
	switch(pInfo[playerid][pAdminLevel])
	{
		case 0: adminname = "No administración";
		case 1: adminname = "Moderador Trial";
		case 2: adminname = "Moderador";
		case 3: adminname = "Administración";
		case 4: adminname = "administrador";
		case 5: adminname = "Administrador Jefe";
		case 6: adminname = "Fundador";
	}
	return adminname;
}

function SPS_Reset_PVars()
{
	for(new i=0; i < MAX_PLAYERS; i++)
	{
	    if(GetPVarType(i, "SPS Callado") != PLAYER_VARTYPE_NONE) {
			SetPVarInt(i, "SPS Callado", 0);
		}
		if(GetPVarType(i, "SPS Los mensajes enviados") != PLAYER_VARTYPE_NONE) {
	    	SetPVarInt(i, "SPS Los mensajes enviados", 0);
	    }
	    if(GetPVarType(i, "SPS Advertencias de Spam") != PLAYER_VARTYPE_NONE) {
	    	SetPVarInt(i, "SPS Advertencias de Spam", 0);
	    }
	}
	return 1;
}

function SPS_Remove_Messages_Limit(playerid)
{
	if(GetPVarInt(playerid, "SPS Advertencias de Spam") == 1)
	{
	    new string[128], pName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pName, sizeof(pName));

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" Jegador %s ha sido Callado por %i minutos a causa de las inundaciones en el chat.", pName, PLAYER_MUTE_TIME_MINUTES);
		for(new i=0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != playerid) SendClientMessage(i, -1, string);

		format(string, sizeof(string), ""chat""COL_LIGHTBLUE" Usted ha sido silenciado por %i Minutos a causa de las inundaciones en el chat.", PLAYER_MUTE_TIME_MINUTES);
	    SendClientMessage(playerid, -1, string);

		SetTimerEx("SPS_Unmute_Player", (PLAYER_MUTE_TIME_MINUTES * 60000), 0, "i", playerid);
		SetPVarInt(playerid, "SPS Callado", 1);

		CallRemoteFunction("OnPlayerGetMuted", "i", playerid);
	}
	SetPVarInt(playerid, "SPS Los mensajes enviados", 0);
	SetPVarInt(playerid, "SPS Advertencias de Spam", 0);
	return 1;
}

function SPS_Unmute_Player(playerid)
{
	SendClientMessage(playerid, -1, ""chat""COL_LIGHTBLUE" Usted ha sido silenciado automáticamente.");
	SetPVarInt(playerid, "SPS Callado", 0);
	return 1;
}

stock ShowCoinDialog(playerid)
{
	new str[64];
	ResetCoinVars(playerid);
	format(str,sizeof(str),""COL_RED"Tiene %i Monedas",pInfo[playerid][pCoins]);
	if(team[playerid] == TEAM_HUMAN)
	{
		ShowPlayerDialog(playerid,DIALOG_COINS,DIALOG_STYLE_LIST,str,"Habilitar Kick Back (45 Monedas)\nMás daño con Shotgun (40 Monedas)\nMás daño con Deagle (50 Monedas)\nMás daño con MP5  (30 Monedas)\nPruebe Clase agente federal (25 Monedas)\nS.W.A.T objecto de armadura (30 Monedas)\nVip Temporal (800 Monedas)","Seleccionar","No, Jugar");
	}
	return 1;
}

stock DoctorShield()
{
	new Float:X,Float:Y,Float:Z,Float:hp,str[128];
	GetObjectPos(DocShield,X,Y,Z);
	foreach(Player,i)
	{
	    if(IsPlayerInRangeOfPoint(i,4.5,X,Y,Z))
		{
	        if(team[i] == TEAM_HUMAN)
			{
	            GetPlayerHealth(i,hp);
	            if(hp < 80)
				{
	                SetPlayerHealth(i,hp+3.5);
	                format(str,sizeof(str),"~n~~n~~n~~n~~g~PRIMEROS curado por DOCTOR SHIELD~w~ (NEW HP: %.2f HP)",hp);
	                GameTextForPlayer(i,str,1000,5);
	            }
	            else
				{
	                GameTextForPlayer(i,"~n~~n~~n~~n~~r~Usted tiene suficiente HP PARA SOBREVIVIR",1000,5);
	            }
	        }
	    }
	}
	return 1;
}

stock LoadStaticObjectsFromFile(filename[])
{
    new File:file_ptr, line[256], modelid, Float:SpawnX, Float:SpawnY, Float:SpawnZ, Float:SpawnRotX, Float:SpawnRotY, Float:SpawnRotZ, objects_loaded;
    file_ptr = fopen(filename, io_read);
    if(!file_ptr) return printf("ERROR! No se pudo cargar objetos desde el archivo %s (El archivo no existe en Directorio scriptfiles)!", filename);
    while(fread(file_ptr, line) > 0)
    {
        sscanf(line, "dffffff", modelid, SpawnX, SpawnY, SpawnZ, SpawnRotX, SpawnRotY, SpawnRotZ);
        CreateObject(modelid, SpawnX, SpawnY, SpawnZ, SpawnRotX, SpawnRotY, SpawnRotZ);
        objects_loaded++;
    }
    fclose(file_ptr);
    printf("Cargado %d objetos de: %s", objects_loaded, filename);
    return objects_loaded;
}

stock LoadStaticVehiclesFromFile(const filename[])
{
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new vehicletype;
	new Float:SpawnX;
	new Float:SpawnY;
	new Float:SpawnZ;
	new Float:SpawnRot;
	new Color1, Color2;
	new index;
	new vehicles_loaded;

	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;

	vehicles_loaded = 0;

	while(fread(file_ptr,line,256) > 0)
	{
		index = 0;
		index = token_by_delim(line,var_from_line,',',index);
		if(index == (-1)) continue;
		vehicletype = strval(var_from_line);
		if(vehicletype < 400 || vehicletype > 611) continue;
		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		SpawnX = floatstr(var_from_line);

		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		SpawnY = floatstr(var_from_line);

		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		SpawnZ = floatstr(var_from_line);

		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		SpawnRot = floatstr(var_from_line);
		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		Color1 = strval(var_from_line);

		index = token_by_delim(line,var_from_line,';',index+1);
		Color2 = strval(var_from_line);

		CreateVehicle(vehicletype,SpawnX,SpawnY,SpawnZ+1,SpawnRot,Color1,Color2,15);

	//	AddStaticVehicle(vehicletype,SpawnX,SpawnY,SpawnZ+1,SpawnRot,Color1,Color2);
		vehicles_loaded++;
	}
	fclose(file_ptr);
	printf("Cargado %d vehículos de: %s",vehicles_loaded,filename);
	return vehicles_loaded;
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
    new x=0;
    while(string[start_index] != EOS && string[start_index] != delim) {
      return_str[x] = string[start_index];
      x++;
      start_index++;
    }
    return_str[x] = EOS;
    if(string[start_index] == EOS) start_index = (-1);
    return start_index;
}

stock udb_hash(buf[])
{
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
