#!/bin/bash

ARKSERVERCOMMAND="/home/steam/ark/ShooterGame/Binaries/Linux/ShooterGameServer"
ARKSAVEFOLDER="/home/steam/ark/ShooterGame/Saved"

FLAGSTRING=" -server -servergamelog -log"

CONFIGSTRING="$MAP?listen?Multihome=0.0.0.0?AltSaveDirectoryName=$MAP"
CONFIGSTRING+="?SessionName=$SESSIONNAME?ServerAdminPassword=$ADMINPW?MaxPlayers=$MAXPLAYERS"
CONFIGSTRING+="?QueryPort=$QUERYPORT?RCONPort=$RCONPORT?Port=$PORT"

if [ -n "$CROSSARK" ]; then
    echo "CrossArkChat flag set! Enabling relevant settings."
    CONFIGSTRING+="?RCONEnabled=True"
    FLAGSTRING+=" -ServerRCONOutputTribeLogs"
fi

CONFIGSTRING+="$EXTRACONFIG"

if [ -n "$CLUSTERID" ]; then
    echo "Setting Cluster config for ID: $CLUSTERID";
    FLAGSTRING+=" -NoTransferFromFiltering -clusterid=$CLUSTERID -ClusterDirOverride=\"$ARKSAVEFOLDER/Cluster-$CLUSTERID\""
else
    echo "Cluster ID is blank, running as standalone.";
fi

if [ -n "$ACTIVEEVENT" ]; then
    echo "Setting Active Event to: $ACTIVEEVENT";
    FLAGSTRING+=" -ActiveEvent=$ACTIVEEVENT"
else
    echo "Active Event is blank, setting to None.";
    FLAGSTRING+=" -ActiveEvent=None"
fi

FLAGSTRING+="$EXTRAFLAGS"

$ARKSERVERCOMMAND "$CONFIGSTRING" "$FLAGSTRING"
