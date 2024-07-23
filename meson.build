project(
  'h5py_reproducer',
  'c',
  'cython',
  version: run_command(['python', '-m', 'setuptools_scm'], check: true).stdout().strip(),
)

py = import('python').find_installation(pure: false)
cy = meson.get_compiler('cython')

add_project_arguments('-std=c++11', language: 'cpp')

deps = [
    dependency('hdf5'),
    dependency('mpi'),
]

py.install_sources(
  [
    'h5py_reproducer/__init__.py',
    'h5py_reproducer/__main__.py',
  ],
  subdir: 'h5py_reproducer'
)

py.extension_module(
    'h5py_reproducer',
    [
        'h5py_reproducer/h5py_reproducer.pyx',
    ],
    install: true,
    subdir: 'h5py_reproducer',
    dependencies: deps,
    cython_args: ['--cplus'],
    override_options : ['cython_language=cpp'],
)
