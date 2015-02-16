#!/bin/env python
# -*- encode:utf8 -*-
__author__ = 'sunkairong'
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import requests
import re
with open("./domain_key") as fo:
    while True:
        line = fo.readline()
        if not line:
            break
        url,key = line.split("|||")[0], line.split("|||")[1]
        r = requests.get(url)
        rt = re.compile(key)
        if rt.search(r.text):
            print "URL: %s is ok" % (url)
        else:
            print "URL: %s is fail" %(url)
# url = "http://market.xiaomi.com/thm/comment/listall/5fe9f6f7-429a-4bea-bb76-36c963a497e9?region=SG&page=0"
# key = '''"productId":"5fe9f6f7-429a-4bea-bb76-36c963a497e9"'''
# def check_url_key(url,key):
#
#     r = requests.get(url)
#     rt = re.compile(key)
#     print unicode(r.text)
#     if rt.search(r.text):
#         print "ok"
#     else:
#         print "no"
