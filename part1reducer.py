#!/usr/bin/env python

import sys
import heapq
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

heap = []

for ip, count in dict_ip.items():
  heapq.heappush(heap, (count, ip))

for count, ip in heapq.nlargest(3, heap):
  hour, ipaddr = ip.split(' ')
  print(f'Hour: {hour}, IP: {ipaddr}, Count: {count}')
