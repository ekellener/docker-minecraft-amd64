FROM debian:jessie
MAINTAINER Erik Kellener [erik@kellener.com]

# apt netatalk
RUN apt-get update && \
apt-get -y install  screen avahi-daemon wget

RUN apt-get -y install default-jdk git 
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar


RUN apt-get install nano
#Create's eula.txt need to edit to say eula=true
RUN java -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui
RUN sed -i 's/false/true/g' eula.txt

#Start again once the eula=true
#RUN java -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui

# retain the database directory and the Foxx Application directory
#VOLUME ["/var/lib/arangodb", "/var/lib/arangodb-apps"]

COPY minecraft.sh /minecraft.sh
COPY spigot.yml /spigot.yml
RUN chmod +x minecraft.sh

#Start it up so config are created (e.g. spigot.yml)
#RUN screen -S minecraft -d -m java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui

#Edit spigot.yml Set view-distance: 5.
#RUN sed -i 's/view-distance: 10/view-distance: 5/g' /spigot.yml


#Update /etc/rc.local and add  su -l pi -c /home/pi/minecraft/minecraft.sh 
RUN echo "su -l -c /minecraft.sh" >> /etc/rc.local 
#Other usages to test screen -r minecraft  (pop in console)

#If not already set up
#edit /etc/default/tmpfs ensure RAMTMP=yes
ENV PATH="/:${PATH}"


#Other default port is (25565) Ensure this is open
EXPOSE 25565/tcp 3838/udp 1900/udp 5351/udp 44444/udp
#USER minecraft
#CMD ["/minecraft.sh"]
# Start the service
#ENTRYPOINT ["/usr/bin/screen -S minecraft -d -m java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui"]
#ENTRYPOINT ["/usr/bin/java -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui"]
ENTRYPOINT  java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui 
#ENTRYPOINT /bin/bash
#Reference
#https://www.dropbox.com/install-linux
#http://lemire.me/blog/2016/04/02/setting-up-a-robust-minecraft-server-on-a-raspberry-pi/


 
