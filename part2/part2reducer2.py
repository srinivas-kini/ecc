#!/usr/bin/env python

import sys
import heapq
import json

start, end = sys.argv[1].split('-')
start, end = int(start), int(end)

heap = []

for line in sys.stdin:
  line = line.strip()
  data = json.loads(line)
  hour = int(data['hour'])

  if hour in range(start, end + 1):
    heapq.heappush(heap, (data['count'], data['ip'], data['hour']))


for count, ip, hour in heapq.nlargest(3, heap):
  print(f'Hour: {hour}, IP: {ip}, Count: {count}')
