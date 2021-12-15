create database telegraf\n
use telegraf\n
create user telegrafuser with password 'Telegr@f' with all privileges\n
grant all privileges on telegraf to telegrafuser\n
create retention policy "4Weeks" on "telegraf" duration 4w replication 1 default\n
exit\n
