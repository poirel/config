#!/usr/bin/python2

import argparse
import logging as log
import sys

DEFAULT_LOG_LEVEL = log.DEBUG


def main():
    desc = 'A template for writing a new python CLI tool.'

    parser = argparse.ArgumentParser(description=desc)

    parser.add_argument('--beep', '-b', action='store_true', help='Invoke a boop.')
    parser.add_argument('--log-level', choices=['off', 'info', 'warn', 'debug'], default=DEFAULT_LOG_LEVEL,
                                help='Sets the logging verbosity. (Default: %s)' % DEFAULT_LOG_LEVEL)
    args = parser.parse_args()

    log_level = {
        'off': 1000,  # hopefully large enough... log.CRITICAL is 50
        'info': log.INFO,
        'warn': log.WARNING,
        'debug': log.DEBUG
    }.get(args.log_level, DEFAULT_LOG_LEVEL)

    log.basicConfig(format='[%(asctime)s] %(levelname)-2s: %(message)s',
                    level=log_level,
                    stream=sys.stdout)

    if args.beep:
        print 'boop'
    else:
        print 'nothing to do'

    return 0


if __name__ == '__main__':
    sys.exit(main())
