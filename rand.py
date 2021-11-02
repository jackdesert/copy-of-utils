"""
Builds a `pytest` incantation based on a downloaded log from a bitbucket pipeline


Setup:

    alias rand='python3 ~/.utils/rand.py'

Usage:

    cd ~/downloads
    rm *txt
    rand
"""

import sys
import re
from glob import glob

import ipdb


class Rand:

    FNAME_GLOB = "pipeline*.txt"

    BUCKET_REGEX = re.compile(r"Using (--random-order-bucket=[a-z]+)")

    # Git sha is being used as seed
    SEED_REGEX = re.compile(r"Using (--random-order-seed=[0-9a-f]+)")

    __slots__ = (
        "_bucket",
        "_seed",
        "_nuggets",
    )

    def __init__(self):
        self._bucket = None
        self._seed = None
        self._nuggets = set()

    def _locate_file(self):
        fnames = glob(self.FNAME_GLOB)
        count = len(fnames)
        if count != 1:
            print(f"ERROR: Expected 1 log file, but got {count}")
            sys.exit()
        return fnames[0]

    def _scan(self, line):
        for regex in [self.BUCKET_REGEX, self.SEED_REGEX]:
            match = regex.search(line)
            if match:
                self._nuggets.add(match.groups()[0])

    def run(self):
        fname = self._locate_file()

        with open(fname) as reader:
            for line in reader:
                self._scan(line)
                if len(self._nuggets) == 2:
                    break
        nuggets = " ".join(sorted(self._nuggets))
        print(f"                     pytest -s {nuggets}")
        print(f"MYTS_VISIBLE_TESTS=1 pytest -s {nuggets}")


if __name__ == "__main__":
    Rand().run()
