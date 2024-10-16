FROM maven:3-jdk-11 AS builder

RUN apt-get update

WORKDIR /usr/src

ARG BRANCH=dev

# the following two files will change with each commit, preventing caching of stale repos
ADD https://api.github.com/repos/voyanttools/trombone/git/refs/heads/$BRANCH trombone_version.json
ADD https://api.github.com/repos/voyanttools/Voyant/git/refs/heads/$BRANCH voyant_version.json

RUN git clone -b $BRANCH https://github.com/voyanttools/trombone --depth 1
RUN git clone -b $BRANCH https://github.com/voyanttools/Voyant --depth 1

WORKDIR /usr/src/trombone
# rewrite local trombone version to "dev" to ensure it's used
RUN perl -0777 -i -pe 's/(<artifactId>trombone<\/artifactId>\s+<version>)[\d\.]+(<\/version>)/$1dev$2/' pom.xml
RUN mvn install -DskipTests

WORKDIR /usr/src/Voyant
# rewrite trombone dependency to "dev" to ensure local version is used
RUN perl -0777 -i -pe 's/(<artifactId>trombone<\/artifactId>\s+<version>)[\d\.]+(<\/version>)/$1dev$2/' pom.xml
RUN mvn install

FROM tomcat:9-jdk11

RUN apt-get update
RUN apt-get -y install unzip

WORKDIR /usr/local/tomcat
COPY --from=builder /usr/src/Voyant/target/*.war ROOT.war
RUN mkdir webapps/ROOT && unzip ROOT.war -d webapps/ROOT && rm ROOT.war

COPY oauth.properties webapps/ROOT/WEB-INF/classes
COPY nssiconfig.properties webapps/ROOT/WEB-INF/classes/ca/lincsproject/nssi/config.properties

ENV GLOWROOT=https://github.com/glowroot/glowroot/releases/download/v0.14.2/glowroot-0.14.2-dist.zip

WORKDIR /
RUN wget $GLOWROOT
RUN unzip glowroot*.zip && rm glowroot*.zip
COPY glowroot-admin.json /glowroot/admin.json

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
