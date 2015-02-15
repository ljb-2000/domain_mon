#!/usr/bin/env python
# -*- encoding:utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf8')
__author__ = 'kairong'
import MySQLdb
import ConfigParser
from multiprocessing import Process

def alarm(id):
    """Alarm ID"""
    print "ID: %d monitor is error!" %(id)

def check_status(id):
    """根据ID查询报警阈值，以及现在的状态值"""
    re_dict = {"status_0":0}
    sum_c = 0
    conn = MySQLdb.connect(host=db_hostname, user=db_user, passwd=db_pass, db='url_mon',charset='utf8')
    cur = conn.cursor()
    sql_get_id_status = "select C.status_code,A.fail_time from status_code AS C,montior_url AS A where C.ID = A.ID and C.ID = %d;" %(id)
    cur.execute(sql_get_id_status)
    status_all = cur.fetchall()
    print id,
    for c_status, a_status in status_all:
        sum_c += c_status
        d_key = "status_%d" % (c_status)
        re_dict[d_key] = re_dict.get(d_key,0) + 1
    if sum_c == 0:
        print "ID %d is ok" % (id,)
    else:
        sum_v = 0
        for v in re_dict.values():
            sum_v += v
        if re_dict["status_0"] / float(sum_v) < 0.5:
            print "ID %d is error" % (id,)


    # if c_status >= a_status:
    #     alarm(id)
    # else:
    #     print "ID %d is ok" %(id)

def get_args(main, name):
    """获取配置"""
    return cf.get(main, name)

def main():
    '''获取所有现在的监控列表的ID,根据ID触发监控'''
    conn = MySQLdb.connect(host=db_hostname, user=db_user, passwd=db_pass, db='url_mon',charset='utf8')
    cur = conn.cursor()
    sql_get_id = "select ID from montior_url;"
    cur.execute(sql_get_id)
    while True:
        line = cur.fetchone()
        if not line:
            break
        #check_status(line[0])
        Process(target=check_status,args=(line[0],)).start()

cf = ConfigParser.ConfigParser()
cf.read("./local_config")
db_hostname = get_args("DB", "db_host")
db_user = get_args("DB", "username")
db_pass = get_args("DB", "passwd")
db_default = get_args("DB", "db")

if __name__ == "__main__":
    main()
