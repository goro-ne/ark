#!/bin/sh

mysql -h 172.17.0.1 -uroot -proot -e "drop database if exists test;" 
mysql -h 172.17.0.1 -uroot -proot -e "create database test charset utf8mb4;" 

