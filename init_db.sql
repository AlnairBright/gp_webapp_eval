DROP DATABASE IF EXISTS daily_report_system ;
DROP DATABASE IF EXISTS tasklist;
DROP USER IF EXISTS repuser;
DROP USER IF EXISTS taskuser;

CREATE DATABASE daily_report_system DEFAULT CHARACTER SET utf8;
CREATE USER repuser IDENTIFIED BY 'reppass';
GRANT ALL PRIVILEGES ON daily_report_system.* TO repuser;

CREATE DATABASE tasklist DEFAULT CHARACTER SET utf8;
CREATE USER taskuser IDENTIFIED BY 'taskpass';
GRANT ALL PRIVILEGES ON tasklist.* TO taskuser;
