#!/bin/bash

cp -anr /default-data/* /voyant-data

# increase maximum post size
sed -i "s%connectionTimeout=\"20000\"%maxPostSize=\"-1\" connectionTimeout=\"120000\"%" $CATALINA_HOME/conf/server.xml

# increase cache
sed -i "s%<Context>%<Context>\n    <Resources cacheMaxSize=\"51200\" />%" $CATALINA_HOME/conf/context.xml

# enable entities
sed -i 's%<param-name>entitiesenabled</param-name><param-value>false%<param-name>entitiesenabled</param-name><param-value>true%' \
   /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml

# continue execution
# exec "$@"
catalina.sh run
