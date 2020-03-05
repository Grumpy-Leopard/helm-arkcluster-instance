#!/bin/bash

ARKSERVERCOMMAND="/home/steam/ark/ShooterGame/Binaries/Linux/ShooterGameServer"
ARKSAVEFOLDER="/home/steam/ark/ShooterGame/Saved"
CONFIGSTRING="\"$MAP?listen?Multihome=0.0.0.0?AltSaveDirectoryName=$MAP?SessionName=$SESSIONNAME?MaxPlayers=$MAXPLAYERS?QueryPort=$QUERYPORT?RCONPort=$RCONPORT?Port=$PORT\""

if [ -n "$CLUSTERID" ]; then
    echo "Cluster ID is blank, running as standalone.";
    CLUSTERCONFIG=""
else
    echo "Setting Cluster config for ID: $CLUSTERID";
    CLUSTERCONFIG="-NoTransferFromFiltering -clusterid=$CLUSTERID -ClusterDirOverride=\"$ARKSAVEFOLDER/Cluster-$CLUSTERID\""
fi

if [ -n "$ACTIVEEVENT" ]; then
    echo "Active Event is blank, running vanilla.";
    EVENTCONFIG="-ActiveEvent=None"
else
    echo "Setting Active Event config to: $ACTIVEEVENT";
    EVENTCONFIG="-ActiveEvent=$ACTIVEEVENT"
fi

$ARKSERVERCOMMAND $CONFIGSTRING $EVENTCONFIG $CLUSTERCONFIG -server -log
