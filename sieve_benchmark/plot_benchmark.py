import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('benchmark_summary.csv')
plt.figure(figsize=(8,4))
plt.bar(df['Language'], df['Time (s)'])
plt.ylabel('Time (s)')
plt.title('Execution Time by Language')
plt.tight_layout()
plt.savefig('benchmark_chart.png')
print('Saved benchmark_chart.png')
