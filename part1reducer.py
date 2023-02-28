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

hourly_records = defaultdict(list)

for ip, count in dict_ip.items():
  hour, ip = ip.split(' ')
  hour = int(hour)
  hourly_records[hour].append((ip, count))


for hour, records in hourly_records.items():
  records = list(sorted(records, key=lambda p: p[1], reverse=True))[:3]

  print(f'Hour: {hour}')
  for ip, count in records:
    print(f'IP: {ip}, Count: {count}')

  print('\n')
