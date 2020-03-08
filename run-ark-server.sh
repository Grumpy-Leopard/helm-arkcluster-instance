#!/bin/bash

ARKSERVERCOMMAND="/home/steam/ark/ShooterGame/Binaries/Linux/ShooterGameServer"
ARKSAVEFOLDER="/home/steam/ark/ShooterGame/Saved"
CONFIGSTRING="\"$MAP?listen?Multihome=0.0.0.0?AltSaveDirectoryName=$MAP?SessionName=$SESSIONNAME?ServerAdminPassword=$ADMINPW?MaxPlayers=$MAXPLAYERS?QueryPort=$QUERYPORT?RCONPort=$RCONPORT?Port=$PORT$EXTRACONFIGOPTIONS\""


if [ -n "$CLUSTERID" ]; then
    echo "Setting Cluster config for ID: $CLUSTERID";
    CLUSTERCONFIG="-NoTransferFromFiltering -clusterid=$CLUSTERID -ClusterDirOverride=\"$ARKSAVEFOLDER/Cluster-$CLUSTERID\""
else
    echo "Cluster ID is blank, running as standalone.";
    CLUSTERCONFIG=""
fi

if [ -n "$ACTIVEEVENT" ]; then
    echo "Setting Active Event to: $ACTIVEEVENT";
    EVENTCONFIG="-ActiveEvent=$ACTIVEEVENT"
else
    echo "Active Event is blank, running vanilla.";
    EVENTCONFIG="-ActiveEvent=None"
fi

$ARKSERVERCOMMAND $CONFIGSTRING $EVENTCONFIG $CLUSTERCONFIG -server -log
