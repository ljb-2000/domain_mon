#!/bin/env python
# -*- encode:utf8 -*-
__author__ = 'sunkairong'
import urllib2

url = "http://market.xiaomi.com/thm/comment/listall/5fe9f6f7-429a-4bea-bb76-36c963a497e9?region=SG&page=0"
key = '''"productId":"5fe9f6f7-429a-4bea-bb76-36c963a497e9"'''
print type( urllib2.urlopen(url).read())
print repr(key)