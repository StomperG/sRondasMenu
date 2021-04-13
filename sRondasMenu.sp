#include <sourcemod>
#include <cstrike>
#include <emperor>
#include <multicolors>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "1.0"

bool Ronda_Inicio;
bool ronda_started;
int ronda_tipo;

public Plugin myinfo = 
{
	name = "sRondasMenu", 
	author = "StomperG", 
	description = "This plugin put special rounds when the next round start!", 
	version = PLUGIN_VERSION, 
	url = "https://steamcommunity.com/id/StomperG"
};


public void OnPluginStart()
{
	// Variables
	Ronda_Inicio = false;
	
	// Commands
	RegAdminCmd("sm_rounds", Comando_rondas, ADMFLAG_BAN);
	RegAdminCmd("sm_rondas", Comando_rondas, ADMFLAG_BAN); // English translation
	
	// Events
	HookEvent("round_start", Inicio_Ronda);
	HookEvent("round_end", Fim_Ronda);
	
	// Translations
	LoadTranslations("sRondasMenu.phrases");
}

public Action Inicio_Ronda(Event event, const char[] name, bool dontBroadcast)
{
	if (Ronda_Inicio) {
		ronda_started = true;
		for (int i = 1; i <= MaxClients; i++) {
			switch(ronda_tipo)
			{
				case 1:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao1, i);
				}
				case 2:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao2, i);
				}
				case 3:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao3, i);
				}
				case 4:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao4, i);
				}
				case 5:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao5, i);
				}
				case 6:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao6, i);
				}
				case 7:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao7, i);
				}
				case 8:
				{
					EMP_RemoveAllWeapons(i);
					CreateTimer(0.1, Timer_Opcao8, i);
				}
			}
		}
	}
}

public Action Fim_Ronda(Event event, const char[] name, bool dontBroadcast)
{
	if (ronda_started) {
		Ronda_Inicio = false;
		ronda_started = false;
		ronda_tipo = 0;
	}
}

public Action Comando_rondas(int client, int args)
{
	Menu rondas = new Menu(MenuHandler_Rondas);
	char traducao[256];
	
	char jogador[64];
	GetClientName(client, jogador, sizeof(jogador));
	
	Format(traducao, sizeof(traducao), "%t", "rondas_title", jogador);
	rondas.SetTitle(traducao);
	
	Format(traducao, sizeof(traducao), "%t", "ronda_1");
	rondas.AddItem("1", traducao); // Deagle Round
	Format(traducao, sizeof(traducao), "%t", "ronda_2");
	rondas.AddItem("2", traducao); //AK47 Round
	Format(traducao, sizeof(traducao), "%t", "ronda_3");
	rondas.AddItem("3", traducao); //Scout Round without Gravity
	Format(traducao, sizeof(traducao), "%t", "ronda_4");
	rondas.AddItem("4", traducao); //Scout Round with Gravity
	Format(traducao, sizeof(traducao), "%t", "ronda_5");
	rondas.AddItem("5", traducao); //Noscope round without velocity
	Format(traducao, sizeof(traducao), "%t", "ronda_6");
	rondas.AddItem("6", traducao); //Noscope round with Velocity
	Format(traducao, sizeof(traducao), "%t", "ronda_7");
	rondas.AddItem("7", traducao); //Knife round without velocity
	Format(traducao, sizeof(traducao), "%t", "ronda_8");
	rondas.AddItem("8", traducao); //Knife round with velocity
	
	rondas.ExitButton = true;
	rondas.Display(client, 30);
	
	return Plugin_Handled;
}

public int MenuHandler_Rondas(Menu rondas, MenuAction action, int client, int position)
{
	switch(action)
	{
		case MenuAction_Select: 
		{
			char item[64];
			rondas.GetItem(position, item, sizeof(item));
			for (int i = 1; i <= MaxClients; i++) {
				if (StrEqual(item, "1")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 1;
					}
					delete rondas;
				} else if (StrEqual(item, "2")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 2;
					}
					delete rondas;
				} else if (StrEqual(item, "3")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 3;
					}
					delete rondas;
				} else if (StrEqual(item, "4")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 4;
					}
					delete rondas;
				} else if (StrEqual(item, "5")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 5;
					}
					delete rondas;
				} else if (StrEqual(item, "6")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 6;
					}
					delete rondas;
				} else if (StrEqual(item, "7")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 7;
					}
					delete rondas;
				} else if (StrEqual(item, "8")) {
					if (EMP_IsValidClient(i)) {
						Ronda_Inicio = true;
						ronda_tipo = 8;
					}
					delete rondas;
				} else {
					delete rondas;
				}
			}
		}
		case MenuAction_End: {
			delete rondas;
		}
	}
}

public Action Timer_Opcao1(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "deagle_round");
	
	EMP_GiveWeapon(i, "weapon_deagle");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
}

public Action Timer_Opcao2(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "ak47_round");
	EMP_GiveWeapon(i, "weapon_ak47");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
}

public Action Timer_Opcao3(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "scout_wogravity");
	EMP_GiveWeapon(i, "weapon_ssg08");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
}

public Action Timer_Opcao4(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "scout_wgravity");
	EMP_GiveWeapon(i, "weapon_ssg08");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntityGravity(i, 2.5);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
}

public Action Timer_Opcao5(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "noscope_wospeed");
	EMP_GiveWeapon(i, "weapon_awp");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll(traducao);
	ServerCommand("sm_noscope");
	
	return Plugin_Stop;
}

public Action Timer_Opcao6(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "noscope_speed");
	EMP_GiveWeapon(i, "weapon_awp");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue", 2.5);
	CPrintToChatAll(traducao);
	ServerCommand("sm_noscope");
	
	return Plugin_Stop;
}

public Action Timer_Opcao7(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "knife_nospeed");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
}

public Action Timer_Opcao8(Handle timer, int i)
{
	char traducao[256];
	Format(traducao, sizeof(traducao), "%t", "knife_speed");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue", 2.5);
	CPrintToChatAll(traducao);
	
	return Plugin_Stop;
} 
