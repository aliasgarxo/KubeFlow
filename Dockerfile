FROM tomcat:9.0.80
RUN mv webapps webapps2
RUN mv webapps.dist/ webapps

COPY target/myweb*.war /usr/local/tomcat/webapps/myweb.war

COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml