#Use hard coded version of openjdk for a consistent environment.
FROM openjdk:8u181-jdk-slim
USER root
# Install common tools:
RUN apt-get update
RUN apt-get -y install maven
RUN apt-get -y install expect
RUN apt-get -y install wget


# Install Sencha
## Ruby is required for sencha
RUN apt-get -y install ruby

## Download sencha from url : May be worth downloading as resource in case of them removing it.
RUN wget http://cdn.sencha.com/cmd/4.0.1.45/SenchaCmd-4.0.1.45-linux-x64.run.zip
RUN unzip SenchaCmd-4.0.1.45-linux-x64.run.zip
RUN chmod +x SenchaCmd-4.0.1.45-linux-x64.run

## Use expect in order to accept sencha license agreement
RUN echo '#!/usr/bin/expect ' >test.sh
RUN echo 'set timeout 20' >>test.sh
RUN echo 'spawn "./SenchaCmd-4.0.1.45-linux-x64.run"' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Press \\\\\[Enter\\\\\] to continue :" { send "\\r" }' >>test.sh
RUN echo 'expect "Do you accept this license? \\\\\[y/n\\\\\]:" { send "y\\r" }' >>test.sh
RUN echo 'expect "Installation Directory \\\\\[/root/bin\\\\\]:" { send "/bin\\r" }' >>test.sh
RUN echo 'expect "Do you want to continue? \\\\\[Y/n\\\\\]:" { send "Y\\r" }' >>test.sh
RUN echo 'expect "Do you want to continue? \\\\\[Y/n\\\\\]:" { send "Y\\r" }' >>test.sh
RUN chmod +x ./test.sh
RUN ./test.sh

#TODO - look at using chown instead
RUN chmod 777 /bin/Sencha/Cmd/
RUN echo ~
RUN echo $M2_HOME


