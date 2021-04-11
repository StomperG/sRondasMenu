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
	Ronda_Inicio = false;
	
	RegAdminCmd("sm_rondas", Comando_rondas, ADMFLAG_BAN); //Portuguese Command
	RegAdminCmd("sm_rounds", Comando_rondas, ADMFLAG_BAN); //English Command
	
	HookEvent("round_start", Inicio_Ronda);
	HookEvent("round_end", Fim_Ronda);
}

public Action Inicio_Ronda(Event event, const char[] name, bool dontBroadcast)
{
	if (Ronda_Inicio) {
		ronda_started = true;
		for (int i = 1; i <= MaxClients; i++) {
			if (ronda_tipo == 1) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao1, i);
			} else if (ronda_tipo == 2) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao2, i);
			} else if (ronda_tipo == 3) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao3, i);
			} else if (ronda_tipo == 4) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao4, i);
			} else if (ronda_tipo == 5) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao5, i);
			} else if (ronda_tipo == 6) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao6, i);
			} else if (ronda_tipo == 7) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao7, i);
			} else if (ronda_tipo == 8) {
				EMP_RemoveAllWeapons(i);
				CreateTimer(0.1, Timer_Opcao8, i);
			}
		}
	}
}

public Action Fim_Ronda(Event event, const char[] name, bool dontBroadcast)
{
	if(ronda_started) {
		Ronda_Inicio = false;	
		ronda_started = false;
		ronda_tipo = 0;
	}
}

public Action Comando_rondas(int client, int args)
{
	Menu rondas = new Menu(MenuHandler_Rondas);
	
	rondas.SetTitle("Escolhe uma ronda!\n¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
	
	rondas.AddItem("1", "Ronda de Deagle"); // Deagle Round
	rondas.AddItem("2", "Ronda de AK47"); //AK47 Round
	rondas.AddItem("3", "Ronda de Scout S/Gravidade"); //Scout Round without Gravity
	rondas.AddItem("4", "Ronda de Scout C/Gravidade"); //Scout Round with Gravity
	rondas.AddItem("5", "Ronda Noscope S/Velocidade"); //Noscope round without velocity
	rondas.AddItem("6", "Ronda Noscope C/Velocidade"); //Noscope round with Velocity
	rondas.AddItem("7", "Ronda de Faca S/Velocidade"); //Knife round without velocity
	rondas.AddItem("8", "Ronda de Faca C/Velocidade"); //Knife round with velocity
	
	rondas.ExitButton = true;
	rondas.Display(client, 30);
	
	return Plugin_Handled;
}

public int MenuHandler_Rondas(Menu rondas, MenuAction action, int client, int position)
{
	if (action == MenuAction_Select) {
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
	} else if (action == MenuAction_End) {
		delete rondas;
	}
}

public Action Timer_Opcao1(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_deagle");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}DEAGLE{default}!");
	
	return Plugin_Stop;
}

public Action Timer_Opcao2(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_ak47");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}AK47{default}!");
	
	return Plugin_Stop;
}

public Action Timer_Opcao3(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_ssg08");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}SCOUT SEM GRAVIDADE{default}!");
	
	return Plugin_Stop;
}

public Action Timer_Opcao4(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_ssg08");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntityGravity(i, 2.5);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}SCOUT COM GRAVIDADE{default}!");
	
	return Plugin_Stop;
}

public Action Timer_Opcao5(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_awp");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA {red}NOSCOPE{default}!");
	ServerCommand("sm_noscope");
	
	return Plugin_Stop;
}

public Action Timer_Opcao6(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_awp");
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue", 2.5);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA {red}NOSCOPE COM VELOCIDADE{default}!");
	ServerCommand("sm_noscope");
	
	return Plugin_Stop;
}

public Action Timer_Opcao7(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}FACA SEM VELOCIDADE{default}!");
	
	return Plugin_Stop;
}

public Action Timer_Opcao8(Handle timer, int i)
{
	EMP_GiveWeapon(i, "weapon_knife");
	EMP_SetClientKevlar(i, 100);
	SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue", 2.5);
	CPrintToChatAll("{default}[ {green}TAC {default}] {default}RONDA DE {red}FACA COM VELOCIDADE{default}!");
	
	return Plugin_Stop;
} 
