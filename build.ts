import { type Build } from 'cmake-ts-gen';

const build: Build = {
    common: {
        project: 'wren',
        archs: ['x64'],
        variables: [],
        copy: {},
        defines: [],
        options: [],
        subdirectories: [],
        includes: [
            'wren/src/include', 
            'wren/src/optional', 
            'wren/src/vm'
        ],
        libraries: {
            wren: {
                sources: [
                    'wren/src/vm/wren_compiler.c',
                    'wren/src/vm/wren_core.c',
                    'wren/src/vm/wren_debug.c',
                    'wren/src/optional/wren_opt_meta.c',
                    'wren/src/optional/wren_opt_random.c',
                    'wren/src/vm/wren_primitive.c',
                    'wren/src/vm/wren_utils.c',
                    'wren/src/vm/wren_value.c',
                    'wren/src/vm/wren_vm.c'
                ]
            }
        },
        buildDir: 'build',
        buildOutDir: 'libs',
        buildFlags: []
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;