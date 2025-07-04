import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

# Load results
results = pd.read_csv('results.csv')

with PdfPages('benchmark_report.pdf') as pdf:
    # Text page
    fig, ax = plt.subplots(figsize=(8.5, 11))
    ax.axis('off')
    text = (
        'Benchmark Report\n\n'
        'Each language implementation performs an identical loop-based workload.\n'
        'The table below lists the CPU cycles measured via rdtsc (or equivalent)\n'
        'and wall-clock time in seconds for the specified iteration count.'
    )
    ax.text(0.5, 0.5, text, ha='center', va='center', wrap=True)
    pdf.savefig(fig)
    plt.close(fig)

    # Table page
    fig, ax = plt.subplots(figsize=(8.5, 11))
    ax.axis('off')
    table = ax.table(cellText=results.values, colLabels=results.columns, loc='center')
    table.scale(1, 1.5)
    pdf.savefig(fig)
    plt.close(fig)

    # Time chart
    fig, ax = plt.subplots(figsize=(8, 4))
    ax.bar(results['Language'], results['Time (s)'])
    ax.set_yscale('log')
    ax.set_ylabel('Time (s, log scale)')
    ax.set_title('Execution Time by Language')
    pdf.savefig(fig)
    plt.close(fig)

    # Cycles chart
    fig, ax = plt.subplots(figsize=(8,4))
    ax.bar(results['Language'], results['Cycles'])
    ax.set_yscale('log')
    ax.set_ylabel('CPU Cycles (log scale)')
    ax.set_title('CPU Cycles by Language')
    pdf.savefig(fig)
    plt.close(fig)

print('Wrote benchmark_report.pdf')
