# Jenkins

### Add a cron tab entry:

i.e To run the script daily at 5:00 AM use the following:
```
crontab -l | { cat; echo "0 5 * * * path/to/script/cleanup.sh"; } | crontab -
```

### List crontab entries
```
crontab -l
```

The schema below explanes the timestamp usage:
```
0    5    *    *    * path/to/script/cleanup
|    |    |    |    |
|    |    |    |    +----- day of week (0 - 6) (Sunday=0)
|    |    |    +------- month (1 - 12)
|    |    +--------- day of month (1 - 31)
|    +----------- hour (0 - 23)
+------------- min (0 - 59)
```

More info can be found at cron [wiki](https://en.wikipedia.org/wiki/Cron)

### Reload cron
```
sudo service cron reload
```
