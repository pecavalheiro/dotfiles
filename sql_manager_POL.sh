#!/bin/bash
# Date : (2021-05-04)
# Author : pecavalheiro
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="EMS SQL Manager for PostgreSQL"
PREFIX="emspg"
AUTHOR="pecavalheiro"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Determine Architecture
POL_System_SetArch "x86"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "6.5"

POL_System_TmpCreate "$PREFIX"

Set_OS "win10"

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

#Shortcut
POL_Shortcut "pgmanager.exe" "$TITLE"

POL_SetupWindow_Close
exit
