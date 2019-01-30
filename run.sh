#!/bin/bash
BASEDIR=/var/www/html
MYSQL_USER=zenphoto
MYSQL_DB=zenphoto
# extract and initialize zenphoto if not present
if [ ! -d $BASEDIR/zp-core ]; then
	rm $BASEDIR/index.html
	# extract zenphoto files
	/bin/tar xvf /zenphoto.tar.gz -C $BASEDIR --strip-components=1
	# create config
	/bin/cp $BASEDIR/zp-core/zenphoto_cfg.txt $BASEDIR/zp-data/zenphoto.cfg.php
	sed -i "/mysql_user/c\$conf['mysql_user'] = '$MYSQL_USER';" $BASEDIR/zp-data/zenphoto.cfg.php
	sed -i "/mysql_database/c\$conf['mysql_database'] = '$MYSQL_DB';" $BASEDIR/zp-data/zenphoto.cfg.php
	sed -i "/mysql_database/c\$conf['mysql_host'] = '$MYSQL_HOST';" $BASEDIR/zp-data/zenphoto.cfg.php
	sed -i "/mysql_database/c\$conf['mysql_pass'] = '$MYSQL_PASS';" $BASEDIR/zp-data/zenphoto.cfg.php
	mkdir $BASEDIR/cache
	mkdir $BASEDIR/cache_html
	chown www-data $BASEDIR/albums
	chown www-data $BASEDIR/uploaded
	chown www-data $BASEDIR/zp-data
	chown www-data $BASEDIR/plugins
	chown www-data $BASEDIR/cache
	chown www-data $BASEDIR/cache_html
fi

/usr/sbin/apache2ctl -D FOREGROUND
