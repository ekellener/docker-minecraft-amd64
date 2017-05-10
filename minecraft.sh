#!/bin/bash

exec java  -Dcom.mojang.eula.agree=true -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui --world-dir /data    --config /data/config/server.properties
