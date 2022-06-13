create database wordpress;
create database speelgoed;
CREATE USER 'michiele'@'localhost' IDENTIFIED BY 'raspberry';
CREATE USER 'michiele'@'%' IDENTIFIED BY 'raspberry';
GRANT ALL ON *.* TO 'michiele'@'localhost';
GRANT ALL ON *.* TO 'michiele'@'%';
FLUSH PRIVILEGES;
