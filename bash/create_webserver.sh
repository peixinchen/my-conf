#!/bin/bash

NGINX_DIR='/usr/local/qqwebserv/nginx'
PHP_DIR='/usr/local/qqwebsrv/php'
WEB_DIR='/usr/local/qqwebsrv/htdocs'
SERVER_NAME='profile'

#nginx
CONF_STRING=<<<CONF
server {
    listen 80;
    server_name $SERVER_NAME.webdev.com;
    root $WEB_DIR;
    index index.php index.html;
    charset utf-8;
    location = /favicon.ico {
        log_not_found off;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.(js|css|png|jpg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
        try_files $uri =404;
    }

    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }

    location ~ \.php$ {
        fastcgi_split_path_info  ^(.+\.php)(.*)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; 
        fastcgi_param run_mode dev;
        fastcgi_index  index.php;
        include fastcgi_params;
    }
}
CONF

#reload nginx
nginx_bin=`ps -ef |grep nginx |grep "master process" |awk '{print $11}'`
$nginx_bin -s reload

#fpm


#reload fpm
kill -USR2 `ps -ef |grep php-fpm|grep master|awk '{print $2}'`
