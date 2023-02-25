#!/usr/bin/env python

import sys
import heapq
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

max_heap = []

for ip, count in dict_ip.items():
  heapq.heappush(max_heap, (-count, ip))

for count, ip in heapq.nsmallest(3, max_heap):
  print(f'IP: {ip}, count: {-count}')
