FROM debian:jessie
MAINTAINER Erik Kellener [erik@kellener.com]

# apt netatalk
RUN apt-get update && \
apt-get -y install  screen avahi-daemon wget

RUN apt-get -y install default-jdk git
RUN mkdir /data && cd /data

WORKDIR /data

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar


RUN apt-get install nano
#Create's eula.txt need to edit to say eula=true
#RUN java -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui
#RUN sed -i 's/false/true/g' eula.txt

#Start again once the eula=true
#RUN java -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui


COPY minecraft.sh /data/minecraft.sh
COPY spigot.yml /data/spigot.yml
RUN chmod +x /data/minecraft.sh

#Start it up so config are created (e.g. spigot.yml)
#RUN screen -S minecraft -d -m java -jar  -Xms512M -Xmx1008M spigot-1.11.2.jar nogui

#Edit spigot.yml Set view-distance: 5.
#RUN sed -i 's/view-distance: 10/view-distance: 5/g' /data/spigot.yml


#Update /etc/rc.local and add  su -l pi -c /data/minecraft.sh
RUN echo "su -l -c /data/minecraft.sh" >> /etc/rc.local
#Other usages to test screen -r minecraft  (pop in console)

#If not already set up
#edit /etc/default/tmpfs ensure RAMTMP=yes
ENV PATH="/:${PATH}"


#Other default port is (25565) Ensure this is open
EXPOSE 25565/tcp

# Start the service
ENTRYPOINT  java  -Dcom.mojang.eula.agree=true -jar -Xms512M -Xmx1008M spigot-1.11.2.jar nogui --world-dir /data    --config /data/config/serve$


#Reference
#https://www.dropbox.com/install-linux

