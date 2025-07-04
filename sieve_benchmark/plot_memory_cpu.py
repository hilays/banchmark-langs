import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('benchmark_summary.csv')

plt.figure(figsize=(8,4))
plt.bar(df['Language'], df['Memory (KB)'])
plt.ylabel('Memory (KB)')
plt.title('Memory Usage by Language')
plt.tight_layout()
plt.savefig('memory_chart.png')
print('Saved memory_chart.png')

plt.figure(figsize=(8,4))
plt.bar(df['Language'], df['CPU (%)'])
plt.ylabel('CPU (%)')
plt.title('CPU Percentage by Language')
plt.tight_layout()
plt.savefig('cpu_chart.png')
print('Saved cpu_chart.png')
