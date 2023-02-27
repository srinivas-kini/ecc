#!/usr/bin/env python

import sys
import json


for line in sys.stdin:
  line = line.strip()
  ip, count = line.split('\t')

  try:
    count = int(count)
    hour, ip = ip.split(' ')
    print(json.dumps({'hour': hour, 'ip': ip, 'count': count}))

  except ValueError:
    pass
