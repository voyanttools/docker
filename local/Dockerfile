FROM tomcat:9-jdk11
RUN apt-get update \
  && apt-get install -y cron wget unzip

ENV RELEASE=https://github.com/voyanttools/VoyantServer/releases/latest/download/VoyantServer.zip

ENV CORENLP=https://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip

WORKDIR /usr/local/tomcat
RUN wget $RELEASE
RUN unzip *.zip \
  && rm *.zip \
  && mv VoyantServer*/_app webapps/ROOT \
  && mkdir -p /default-data \
  && mv VoyantServer*/data/* /default-data \
  && rm VoyantServer* -r

WORKDIR /
RUN wget $CORENLP
RUN unzip stanford-corenlp*.zip \
  && rm stanford-corenlp*.zip \
  && mv stanford-corenlp*/stanford-corenlp-3.9.2-models.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib \
  && rm -rf stanford-corenlp*

COPY oauth.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
