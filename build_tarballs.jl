# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "libunistring"
version = v"0.9.10"

# Collection of sources required to build libunistring
sources = [
    "http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.10.tar.xz" =>
    "eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd libunistring-0.9.10/
./configure --prefix=$prefix --host=$target
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libunistring", :libunistring)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

