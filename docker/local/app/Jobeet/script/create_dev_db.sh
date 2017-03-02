#!/bin/sh

mysql -h 172.17.0.1 -uroot -proot -e "drop database if exists dev;" 
mysql -h 172.17.0.1 -uroot -proot -e "create database dev charset utf8mb4;" 

