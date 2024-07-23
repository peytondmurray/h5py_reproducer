# h5py-reproducer

Package versions:

```
Package               Version           Editable project location
--------------------- ----------------- ------------------------------------------------
asttokens             2.4.1
attrs                 23.2.0
cattrs                23.2.3
Cython                3.0.10
decorator             5.1.1
docstring-to-markdown 0.15
executing             2.0.1
fancycompleter        0.9.1
h5py                  3.11.0
h5py-reproducer       0.1.dev1+g71aa09f /home/pdmurray/Desktop/workspace/h5py_reproducer
ipython               8.26.0
jedi                  0.19.1
lsprotocol            2023.0.1
matplotlib-inline     0.1.7
meson                 1.5.0
meson-python          0.16.0
numpy                 2.0.1
packaging             24.1
parso                 0.8.4
pdbpp                 0.10.3
pexpect               4.9.0
pip                   24.1.2
pluggy                1.5.0
prompt_toolkit        3.0.47
ptyprocess            0.7.0
pure_eval             0.2.3
pygls                 1.3.1
Pygments              2.18.0
pyproject-metadata    0.8.0
pyrepl                0.9.0
python-lsp-jsonrpc    1.1.2
python-lsp-server     1.11.0
ruff                  0.5.4
ruff-lsp              0.0.54
setuptools            65.5.0
setuptools-scm        8.1.0
six                   1.16.0
stack-data            0.6.3
traitlets             5.14.3
typing_extensions     4.12.2
ujson                 5.10.0
wcwidth               0.2.13
wmctrl                0.5
```

To run the reproducer, install:

```
pip install -v .
```

`h5py<=3.11.0` and `hdf5>1.14.3` must be installed. Then do `python -m h5py_reproducer` and you'll see an error like this:

```
HDF5-DIAG: Error detected in HDF5 (1.14.4-3) thread 0:
  #000: H5Pdcpl.c line 2406 in H5Pget_virtual_filename(): can't find object for ID
    major: Object ID
    minor: Unable to find ID information (already closed?)
  #001: H5Pint.c line 4102 in H5P_object_verify(): property list is not a member of the class
    major: Property lists
    minor: Can't compare objects
  #002: H5Pint.c line 4053 in H5P_isa_class(): not a property list
    major: Invalid arguments to routine
    minor: Inappropriate type
HDF5-DIAG: Error detected in HDF5 (1.14.4-3) thread 0:
  #000: H5Pdcpl.c line 2406 in H5Pget_virtual_filename(): can't find object for ID
    major: Object ID
    minor: Unable to find ID information (already closed?)
  #001: H5Pint.c line 4102 in H5P_object_verify(): property list is not a member of the class
    major: Property lists
    minor: Can't compare objects
  #002: H5Pint.c line 4053 in H5P_isa_class(): not a property list
    major: Invalid arguments to routine
    minor: Inappropriate type
Traceback (most recent call last):
  File "<frozen runpy>", line 198, in _run_module_as_main
  File "<frozen runpy>", line 88, in _run_code
  File "/home/pdmurray/Desktop/workspace/h5py_reproducer/h5py_reproducer/__main__.py", line 25, in <module>
    print(get_dset_names(dcpl)) # <-- Issue arises here
          ^^^^^^^^^^^^^^^^^^^^
  File "h5py_reproducer.pyx", line 15, in h5py_reproducer.h5py_reproducer.get_dset_names
  File "h5py_reproducer.pyx", line 22, in h5py_reproducer.h5py_reproducer.get_dset_names
  File "h5py_reproducer.pyx", line 29, in h5py_reproducer.h5py_reproducer.get_dset_names
UnicodeDecodeError: 'utf-8' codec can't decode byte 0x84 in position 1: invalid start byte
```

This is solved on the development branch of `h5py`, so if you first install that
and then do `piip install -v .`, you won't get an error.
