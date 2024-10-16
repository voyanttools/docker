#!/bin/bash

# increase maximum post size
sed -i "s%connectionTimeout=\"20000\"%maxPostSize=\"-1\" connectionTimeout=\"120000\"%g" $CATALINA_HOME/conf/server.xml

# increase cache
sed -i "s%<Context>%<Context>\n    <Resources cacheMaxSize=\"51200\" />%g" $CATALINA_HOME/conf/context.xml

# enable entities
sed -i 's%<param-name>entitiesenabled</param-name><param-value>false%<param-name>entitiesenabled</param-name><param-value>true%' \
   /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml

# set version to build date
DATE=$(date +'%Y-%m-%d')
sed -i "s%<param-name>version</param-name><param-value>[0-9.-]\+%<param-name>version</param-name><param-value>$DATE%" \
   /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml

# continue execution
# exec "$@"
catalina.sh run
