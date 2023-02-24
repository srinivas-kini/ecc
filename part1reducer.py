#!/usr/bin/env python

import sys
import logging
from operator import itemgetter
from collections import defaultdict

dict_ip = defaultdict(int)

for line in sys.stdin:
line = line.strip()
ip, num = line.split('\t')
try:
num = int(num)
dict_ip[ip] += num

except ValueError:
pass

sorted_ip = sorted(dict_ip.items(), key=itemgetter(0))

for ip, count in sorted_ip:
print('%s\t%s' % (ip, count))
