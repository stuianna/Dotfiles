#!/usr/bin/env python3

import time
import logging
import os
from shutil import copyfile
from datetime import datetime

log = logging.getLogger(__name__)

UPDATE_INTERVAL_DAYS = 1
SLEEP_TIME_SECONDS = 3600
DESTINATION_DIR = '/home/stuart/db'
SOURCES = [{
    "name": "cmcLogger",
    "path": "/home/stuart/.config/CMCLogger/data/cryptoData.db",
    "db": "cmcLogger.db"
}, {
    "name": "whaleAlert",
    "path": "/home/stuart/.config/whaleAlertLogger/data/whaleAlert.db",
    "db": "whaleAlert.db"
}]


def setupLogging():
    logging.basicConfig(format='%(asctime)s %(levelname)s %(module)s: %(message)s',
                        datefmt='%m/%d/%Y %I:%M:%S%p',
                        level=logging.DEBUG)


def get_db_modified_timestamp(path: str) -> int:
    # Return unix timestamp
    try:
        return int(os.path.getmtime(path))
    except FileNotFoundError:
        log.warning("File {} doesn't exist".format(path))
        return 0
    except Exception as e:
        log.error("Generic exeption caught {}".format(e))


def db_needs_updating(soure_mod: int, dest_mod: int) -> bool:
    # Check if last modifed date and now is later than day
    update_time_seconds = UPDATE_INTERVAL_DAYS * 3600 * 24
    has_been_modified = source_mod_timestamp > des_mod_timestamp
    update_time_elapsed = (des_mod_timestamp + update_time_seconds) < int(time.time())
    return has_been_modified and update_time_elapsed


def update_db(source: str, destination: str) -> bool:
    # copy from source to destination, check success
    try:
        copyfile(source, destination)
    except OSError as e:
        log.error("DB cannot be copied. {}".format(e))
        return False
    except Exception as e:
        log.error("DB cannot be copied. {}".format(e))
        return False
    return True


if __name__ == "__main__":
    setupLogging()
    log.info("Starting new instance")
    for db in SOURCES:

        log.debug("Checking {}".format(db['name']))

        source_mod_timestamp = get_db_modified_timestamp(db['path'])
        log.debug("Source last modified time {}".format(datetime.fromtimestamp(source_mod_timestamp)))

        des_path = os.path.join(DESTINATION_DIR, db['db'])
        des_mod_timestamp = get_db_modified_timestamp(des_path)
        log.debug("Destination last modified time {}".format(datetime.fromtimestamp(des_mod_timestamp)))

        needs_updateing = db_needs_updating(source_mod_timestamp, des_mod_timestamp)
        log.debug("Database needs updating = {}".format(needs_updateing))

        if needs_updateing:
            log.info("Updating database {}".format(db['name']))
            update_db(db['path'], des_path)
