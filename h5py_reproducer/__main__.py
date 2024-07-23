import tempfile

import h5py
import numpy as np

from .h5py_reproducer import get_dset_names


with tempfile.NamedTemporaryFile('w') as f:

    fname = f.name
    data = np.arange(100)

    # Create a dataset and a virtual dataset
    with h5py.File(fname, mode="w") as hf:
        hf.create_dataset('values', data=data, maxshape=(None,))
        layout = h5py.VirtualLayout(shape=data.shape, dtype=int)
        layout[:] = h5py.VirtualSource('.', "values", shape=data.shape)

        hf.create_virtual_dataset("vdata", layout, fillvalue=-5)

    # Call the `get_dset_names` function on the virtual dataset
    with h5py.File(fname, mode="r+") as hf:
        dcpl = hf['vdata'].id.get_create_plist()
        print(get_dset_names(dcpl)) # <-- Issue arises here
