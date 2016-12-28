"""Module to read csv data and spit out a LaTeX table compatible format"""

from __future__ import print_function

SOURCE_DATA = 'results_backup.csv'
DEST_DATA = 'latex_table.txt'

def main():
    print("Reading file...")
    with open(SOURCE_DATA) as source:
        data = source.readlines()
        print("Data read")
    with open(DEST_DATA, 'w') as dest:
        for line in data:
            dest.write(' & '.join(line.strip().split(',')) + ' \\\\ \\hline \n')
        print("Data written in LaTeX format")
    print("Exiting...")

if __name__ == '__main__':
    main()
