#!/usr/bin/env python3

import sys
import time
from pymodbus.client.sync import ModbusTcpClient as ModbusClient
from pymodbus.exceptions import ConnectionException

ip = sys.argv[1]
client = ModbusClient(ip, port=502)
client.connect()
count = 0
while True:
    rr = client.read_holding_registers(1, 16)
    print(rr.registers)
    count += 1
    print(count)

