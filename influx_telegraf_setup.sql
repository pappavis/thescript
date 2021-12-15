create database telegraf
use telegraf
create user telegrafuser with password 'Telegr@f' with all privileges
grant all privileges on telegraf to telegrafuser
create retention policy "4Weeks" on "telegraf" duration 4w replication 1 default
exit
