#!/bin/sh

if [ $# != 2 ]; then
    echo "Illeagal arguments"
    exit 1
fi

git_url=$1
appName=$2


git clone $git_url $appName
sleep 10s

echo "pepper=6Ab3mtmG" > $appName/WebContent/application.properties

cp -p $appName/src/META-INF/persistence.xml ./w
#cp -p $appName/src/META-INF/persistence.xml $appName/src/META-INF/persistence.xml.orig
sed -e "s/useSSL=false/allowPublicKeyRetrieval=true\&amp;useSSL=false/g" w > persistence.xml
mv ./persistence.xml $appName/WebContent/META-INF/
rm ./w

cp -p $appName/pom.xml ./w
#cp -p $appName/pom.xml $appName/pom.xml.orig
cat w | sed -e "s/<version>5.1.45<\/version>/<version>8.0.16<\/version>/g" \
 | sed -e "s/<\/sourceDirectory>/<\/sourceDirectory>\n<resources><resource><directory>WebContent<\/directory><\/resource><\/resources>/g" \
 | sed -e "s/<\/plugins>/<plugin><groupId>org.apache.tomcat.maven<\/groupId><artifactId>tomcat7-maven-plugin<\/artifactId><version>2.2<\/version><configuration><path>\/<\/path><port>8080<\/port><\/configuration><\/plugin>\n<\/plugins>/g" \
 | sed -e "s/<\/dependencies>/<dependency><groupId>javax.servlet<\/groupId><artifactId>javax.servlet-api<\/artifactId><version>3.1.0<\/version><scope>provided<\/scope><\/dependency>\n<\/dependencies>/g"  > ./pom.xml
mv ./pom.xml $appName/
rm ./w

mysql -h localhost -u root $appName < init_db.sql
mysql -h localhost -u root $appName < drs.sql

cd $appName
mvn tomcat7:run-war
