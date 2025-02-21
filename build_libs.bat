clang -c -g -gcodeview -o wren-windows.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall wren\wren.c

mkdir libs
move wren-windows.lib libs
