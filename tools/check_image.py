#!/usr/bin/env python3
"""Structural checks only: this does not certify hardware compatibility."""
import hashlib
import struct
import sys
from pathlib import Path
p = Path(sys.argv[1])
b = p.read_bytes()
assert 48 <= len(b) <= 134217728, 'Empty, truncated or oversized recovery image'
assert b[:8] == b'ANDROID!', 'Expected Android boot-image header'
kernel, ramdisk = struct.unpack_from('<I', b, 8)[0], struct.unpack_from('<I', b, 16)[0]
page, version = struct.unpack_from('<II', b, 36)
assert version == 2, f'Unexpected boot header version {version}'
assert page == 4096, f'Unexpected page size {page}'
assert kernel > 0 and ramdisk > 0, 'Kernel or recovery ramdisk is missing'
assert kernel + ramdisk + page <= len(b), 'Truncated image payload'
print(f'{p.name}: {len(b)} bytes, header v{version}, kernel={kernel}, ramdisk={ramdisk}')
print('SHA256:', hashlib.sha256(b).hexdigest())
print('Structural validation only; boot, touch and decryption remain untested.')
