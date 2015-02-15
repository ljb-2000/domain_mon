#!/usr/bin/env python
# -*- encoding:utf-8 -*-
__author__ = 'kairong'
#解决crontab中无法执行的问题
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import ConfigParser
import MySQLdb
import requests
import re
from socket import socket, SOCK_DGRAM, AF_INET
from multiprocessing import Process

###函数声明区域
def get_localIP():
    '''获取本地ip'''
    s = socket(AF_INET, SOCK_DGRAM)
    s.connect(('google.com', 0))
    return s.getsockname()[0]

def get_args(main, name):
    """获取配置"""
    return cf.get(main, name)

def check_url(id, url, keyword, method='GET'):
    '''检查域名和关键词，并把结果写入db'''
    r = requests.get(url)
    if r.status_code <=400 and re.search(unicode(keyword), r.text):
        c_result = 0
    else:
        c_result = 1
    status_2_db(id, c_result)


def status_2_db(id, status):
    '''把结果写入db'''
    conn = MySQLdb.connect(host=db_hostname, user=db_user, passwd=db_pass, db='url_mon',charset='utf8')
    cur = conn.cursor()
    sql_get_id_status = "select status_code from status_code where ID = %d and rep_point = '%s' ;" %(id, local_ip)
    cur.execute(sql_get_id_status)
    last_code = cur.fetchone()
    if last_code:
        last_code = last_code[0]
        cur_code = last_code * status + status
        sql_update_id_status = "update status_code set status_code = %d, rep_time = CURRENT_TIMESTAMP where ID = %d and rep_point = '%s';" %(cur_code, id, local_ip)
        cur.execute(sql_update_id_status)
    else:
        cur_code = status
        sql_into_id_status = "insert into status_code(ID, status_code, rep_point) value(%d, %d, '%s')" %(id, cur_code, local_ip)
        cur.execute(sql_into_id_status)
    conn.commit()
    conn.close()

def main():
    conn = MySQLdb.connect(host=db_hostname, user=db_user, passwd='test', db='url_mon',charset='utf8')
    cur = conn.cursor()
    cur.execute("select * from montior_url;")
    while True:
        line = cur.fetchone()
        if not line:
            break
        c_id, c_domain, c_location, c_method, c_keyword  = line[0], line[1], line[2], line[3], line[4]
        c_url = "http://%s%s" % (c_domain,c_location)
        if c_method == line[5]:
            c_post_d = line[6]
        Process(target=check_url, args=(c_id, c_url, c_keyword)).start()

###变量获取区域
local_ip = get_localIP()
cf  = ConfigParser.ConfigParser()
cf.read("./local_config")
db_hostname = get_args("DB", "db_host")
db_user = get_args("DB", "username")
db_pass = get_args("DB", "passwd")
db_default = get_args("DB", "db")

if __name__ == "__main__":
    main()
