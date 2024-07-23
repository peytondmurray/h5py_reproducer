from libc.stddef cimport size_t
from libc.stdlib cimport malloc, free

cdef extern from "hdf5.h":
    # HDF5 types copied from h5py/api_types_hdf5.pxd
    ctypedef long int hid_t

    # virtual Dataset functions
    cdef ssize_t H5Pget_virtual_filename(hid_t dcpl_id, size_t index, char *name, size_t size)


cpdef list get_dset_names(dcpl):

    names: list = []

    cdef char* name = NULL
    cdef ssize_t size

    for j in range(dcpl.get_virtual_count()):

        size = H5Pget_virtual_filename(dcpl.id, j, NULL, 0)
        name = <char*>malloc(size+1)
        try:
            H5Pget_virtual_filename(dcpl.id, j, name, <size_t>size+1)
            src_fname = bytes(name).decode('utf-8')
            names.append(src_fname)
        finally:
            free(name)


    return names
