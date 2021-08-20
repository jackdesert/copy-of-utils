"""
Builds a `pytest` incantation based on a downloaded log from a bitbucket pipeline
"""

import sys
import re
from glob import glob

import ipdb


class Rand:

    FNAME_GLOB = "pipeline*.txt"

    BUCKET_REGEX = re.compile(r"Using (--random-order-bucket=[a-z]+)")
    SEED_REGEX = re.compile(r"Using (--random-order-seed=\d+)")

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
        if len(fnames) > 1:
            print("ERROR: More than one log file")
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
