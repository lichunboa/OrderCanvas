#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Runs tests/adapters/trade_analytics.cpp against TVTradeAnalytics.mqh. MQL5 dynamic arrays
(`T &a[]`, `T a[];`) are rewritten to std::vector; the calculations are the header's own."""
from pathlib import Path
import re, subprocess, sys, tempfile
here = Path(__file__).resolve().parent
src = (here.parent / 'MQL5/Include/TVTradeAnalytics.mqh').read_text()
src = re.sub(r'const (\w+) &(\w+)\[\]', r'const std::vector<\1> &\2', src)
src = re.sub(r'(\w+) &(\w+)\[\]', r'std::vector<\1> &\2', src)
src = re.sub(r'^(\s*)(\w+) (\w+)\[\];', r'\1std::vector<\2> \3;', src, flags=re.M)
with tempfile.TemporaryDirectory(prefix='oc-trade-analytics-') as d:
    d = Path(d); (d / 'TVTradeAnalytics.host.hpp').write_text(src)
    cxx = ['c++', '-std=c++17', '-O2', '-Wall', '-Wextra', '-Werror', '-I', str(d), str(here / 'adapters/trade_analytics.cpp'), '-o', str(d / 't')]
    subprocess.run(cxx, check=True); subprocess.run([str(d / 't')], check=True)
print('PASS: trade aggregation, statistics, drawdown, R, MAE and buckets')
