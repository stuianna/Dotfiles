#!/usr/bin/python3
"""
Produces load on all available CPU cores

Updated with suggestion to prevent Zombie processes
Linted for Python 3
Source:
insaner @ http://danielflannery.ie/simulate-cpu-load-with-python/#comment-34130
"""
from multiprocessing import Pool
from multiprocessing import cpu_count
import time

import signal

stop_loop = 0
updateTime = 3.0

def exit_chld(x, y):
    global stop_loop
    stop_loop = 1


def f(x):
    calcCount = 0
    startTime = time.time();
    global stop_loop
    while not stop_loop:
        x*x
        calcCount += 1
        if time.time() > (startTime + updateTime):
            print("Core {}: {} M/s.".format(x,round(calcCount/(1000000 *updateTime),2)));
            calcCount = 0;
            startTime = time.time();



signal.signal(signal.SIGINT, exit_chld)

if __name__ == '__main__':
    processes = cpu_count()
    print('-' * 20)
    print('Running load on CPU(s)')
    print('Utilizing %d cores' % processes)
    print('-' * 20)
    pool = Pool(processes)
    pool.map(f, range(processes))
