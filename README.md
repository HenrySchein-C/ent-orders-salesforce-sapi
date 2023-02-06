#Introduction 
This Project is related to ent-orders-salesforce-sapi.

#Getting Started

1.	Find tls store details, gitignore, settings.xml, README.md and as400 license over https://henryscheininc.sharepoint.com/:f:/s/NA-Business-Systems-MuleSoft-Documentation/EgbJI_T-krBLpo9v3Vyk9MkBUxzwJOc5Z6fAt4yGulykwg?e=pXWvKY
2.	Update your Anypoint Platform credentials (i.e. lines #11, #12 ) inside new setting.xml file. Also check for organization id @line 94
3. 	Replace anypoint studio's old cacert with new one location jdk<version>/jre/lib/security/
4.	Please note we are using client provided Git
5.	Install Maven latest, from https://maven.apache.org/download.cgi , in your VDI
6.	Add maven path to your vdi's system path
7.	keep a backup and change the setting .xml inside <maven_home>/conf path with the setting.xml file of Step 1
8.	fetch item-eligibility-papi application from dev branch of git using git clone

# Git Commit
9.	Before commiting code in git please check and validate if .gitignore file is as per gitIgnore file of Step 1

# Building local package
10. fetch all the runtime properties as per environemnt from https://henryscheininc.sharepoint.com/:t:/s/NA-Business-Systems-MuleSoft-Documentation/EUkL72NZhUhNghKqShgeKnkBl8UZAJIvUTq37j6vWuJUIQ?e=bmzVLo
11. mvn clean package with all properties using -D<propertyName>=<propertyValue>