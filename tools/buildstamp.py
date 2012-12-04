#
# Stamp files with specific data
#
# D4rKn3sSyS
#
#

import datetime
import time
import sys
import zipfile

zf = zipfile.ZipFile(sys.argv[1], mode='a',)

def read():
    for info in zf.infolist():
        if info.filename == 'stamp':
            data = zf.read(info.filename)
            return repr(data)

def write():
        stamp = sys.argv[2]
        if not read():
            try:
                info = zipfile.ZipInfo('stamp', date_time=time.localtime(time.time()),)
                info.compress_type = zipfile.ZIP_STORED
                info.comment = stamp
                info.create_system = 0
                zf.writestr(info, stamp)
            finally:
                zf.close()

if __name__ == "__main__":
    write()
