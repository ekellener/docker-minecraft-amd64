#!/bin/bash
#env
env
if [ -z ${MC_OPS} ]; then
 echo "No Ops defined" ;
 else
# Lookup UUID
MC_UUID=`./lookupuuid.sh $MC_OPS`

#format ops.json string
opstr="
[
  {
    \"uuid\": \"$MC_UUID\",
    \"name\": \"$MC_OPS\",
    \"level\": 4,
    \"bypassesPlayerLimit\": false
  }
]"

 echo  $opstr >> /data/ops.json;
 fi
java  -Dcom.mojang.eula.agree=true -jar -Xms256M -Xmx512M -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+AggressiveOpts spigot-1.12.jar nogui --world-dir /data    --config /data/config/server.properties   --bukkit-settings /data/config/bukkit.yml  --commands-settings /data/config/commands.yml  --spigot-settings /data/config/spigot.yml 
#exec  java -jar  -Xms512M -Xmx1008M spigot-1.12.jar nogui 
#fi
