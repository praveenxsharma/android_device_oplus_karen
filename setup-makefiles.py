#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import sys
import os

# setup-makefiles.py just calls extract-files.py with --regenerate_makefiles
os.execv(
    os.path.join(os.path.dirname(__file__), 'extract-files.py'),
    [sys.argv[0], '--regenerate_makefiles'] + sys.argv[1:],
)
