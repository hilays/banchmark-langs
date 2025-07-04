import csv
import re

records = []
record = {}
with open('results.txt') as f:
    for line in f:
        line = line.strip()
        header = re.match(r'^===\s*(.+?)\s*===$', line)
        if header:
            if record:
                records.append(record)
                record = {}
            record['Language'] = header.group(1)
        elif line.startswith('primes='):
            m = re.search(r'primes=(\d+)\s+time=([0-9.]+)', line)
            if m:
                record['Primes'] = int(m.group(1))
                record['Time (s)'] = float(m.group(2))
        elif 'User time (seconds):' in line:
            record['User time (s)'] = float(line.split(':')[1].strip())
        elif 'System time (seconds):' in line:
            record['System time (s)'] = float(line.split(':')[1].strip())
        elif 'Percent of CPU this job got:' in line:
            record['CPU (%)'] = float(line.split(':')[1].strip().replace('%',''))
        elif line.startswith('Maximum resident set size'):
            record['Memory (KB)'] = int(line.split(':')[1].strip())
if record:
    records.append(record)

with open('benchmark_summary.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=['Language','Primes','Time (s)','User time (s)','System time (s)','CPU (%)','Memory (KB)'])
    writer.writeheader()
    for r in records:
        writer.writerow(r)
print('Wrote benchmark_summary.csv')
