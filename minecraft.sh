#!/bin/bash

#if ! screen -list | grep -q "minecraft"; then
  #cd /home/pi/minecraft
  #screen  -S minecraft -m  java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui && screen -r minecraft
exec  java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui 
#fi
