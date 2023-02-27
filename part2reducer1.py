#!/usr/bin/env python

import sys
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


for ip, count in dict_ip.items():
  print(f'{ip}\t{count}')
