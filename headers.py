'''
Show me the headers from a particular CSV or TSV file
'''

import argparse
import csv
import pdb

parser = argparse.ArgumentParser(description='Print column headers vertically')
parser.add_argument(
        'filename',
        help='Filename of TSV or CSV data',
        )
parser.add_argument(
        '--sort',
        help='case-insensitive sort ',
        action='store_true',
        )

args = parser.parse_args()

COMMA = ','
TAB = '\t'
PIPE = '|'
delimiter = COMMA

with open(args.filename) as ff:
    line = ff.readline()
    if TAB in line:
        delimiter = TAB
    elif COMMA in line:
        delimiter = COMMA
    elif PIPE in line:
        delimiter = PIPE
    else:
        raise NotImplementedError('This type of delimiter is not yet supported')

with open(args.filename, newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=delimiter, quotechar='|')
    for row in reader:
        headers = row
        break

if args.sort:
    print('\n(Case-INsensitive Sort Applied)\n')
    # Sort by the lowercase value
    headers.sort(key=lambda x: x.lower())
else:
    print('\n(Normal Order)\n')

for header in headers:
    print(header)
