# Test Suite for Pippin

## Explaining tsconfig.json

Here's the contents of `tsconfig.json`

```
{}
```

This is signifcant. Without this base file, the tests error with:

```
Error: Cannot find module '/home/frodo/workspace/infrastructure/devices/pippin/tests/test-config' imported from /home/frodo/workspace/infrastructure/devices/pippin/tests/steps/play-a-song.ts
    at finalizeResolution (node:internal/modules/esm/resolve:275:11)
    at moduleResolve (node:internal/modules/esm/resolve:860:10)
    at defaultResolve (node:internal/modules/esm/resolve:984:11)
    at ModuleLoader.defaultResolve (node:internal/modules/esm/loader:780:12)
    at ModuleLoader.#cachedDefaultResolve (node:internal/modules/esm/loader:704:25)
    at ModuleLoader.#resolveAndMaybeBlockOnLoaderThread (node:internal/modules/esm/loader:739:38)
    at ModuleLoader.resolveSync (node:internal/modules/esm/loader:762:52)
    at ModuleLoader.#cachedResolveSync (node:internal/modules/esm/loader:723:25)
    at ModuleLoader.getModuleJobForRequire (node:internal/modules/esm/loader:451:50)
    at new ModuleJobSync (node:internal/modules/esm/module_job:344:34) {
  code: 'ERR_MODULE_NOT_FOUND',
  url: 'file:///home/frodo/workspace/infrastructure/devices/pippin/tests/test-config'
}
```

The goal of this code is to be able to run playwright tests against a web application.
The implementation of these tests is written in TypeScript.

To avoid the step of running `npx tsc` to transpile the code, we are using `ts-node`,
which is a TypeScript runtime that does all the `tsc` stuff behind the scenes, and
in memory! This is why `--require-module ts-node/register` is passed as an argument
to `cucumber-js` in `./test.sh`.

Since `ts-node` is going to do some transpiling it's going to make some decisions on
the `compilerOptions`. How it determines these options is influenced by what's in
the `tsconfig.json`. But.. what if there isn't a `tsconfig.json`?

Here's the output of `npx tsc --showConfig`

**With** `tsconfig.json`

```json
{
    "compilerOptions": {},
    "files": [
        "./test-config.ts",
        "./steps/play-a-song.ts"
    ]
}
```

**Without** `tsconfig.json`

```bash
error TS5081: Cannot find a tsconfig.json file at the current directory: /home/frodo/workspace/infrastructure/devices/pippin/tests.
```

It's note worthy that `tsc` crashes and burns without a `tsconfig.json`.

Here's the output of `npx ts-node --showConfig`

**With** `tsconfig.json`

```json
{
  "ts-node": {
    "cwd": "/home/frodo/workspace/infrastructure/devices/pippin/tests",
    "projectSearchDir": "/home/frodo/workspace/infrastructure/devices/pippin/tests",
    "project": "/home/frodo/workspace/infrastructure/devices/pippin/tests/tsconfig.json"
  },
  "compilerOptions": {
    "sourceMap": true,
    "inlineSourceMap": false,
    "inlineSources": true,
    "declaration": false,
    "noEmit": false,
    "outDir": "./.ts-node",
    "target": "es5",
    "module": "commonjs"
  }
}
```

Even without any configuration in the `tsconfig.json`, `ts-node` comes up with its own
`compilerOptions` for it to use when performing the transpilation (or when it delegates
to `tsc` to do it).

**Without** `tsconfig.json`

```json
{
  "ts-node": {
    "cwd": "/home/frodo/workspace/infrastructure/devices/pippin/tests",
    "projectSearchDir": "/home/frodo/workspace/infrastructure/devices/pippin/tests"
  },
  "compilerOptions": {
    "lib": [
      "es2021"
    ],
    "module": "node16",
    "target": "es2021",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "moduleResolution": "node10",
    "types": [
      "node"
    ],
    "sourceMap": true,
    "inlineSourceMap": false,
    "inlineSources": true,
    "declaration": false,
    "noEmit": false,
    "outDir": "./.ts-node",
    "moduleDetection": "force",
    "allowSyntheticDefaultImports": true,
    "noImplicitAny": true,
    "noImplicitThis": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "strictBuiltinIteratorReturn": true,
    "alwaysStrict": true,
    "useUnknownInCatchVariables": true
  }
}
```

This is where it gets interesting! By not having a `tsconfig.json`, `ts-node` creates
the strictest `compilerOption` configuration possible!

### Why Are You Telling Me All Of This?

This line:

```typescript
import { TestConfig } from "../test-config";
```

Is an ESM style loader, but partially. It doesn't specify the file extension, which is
required by the ESM specification. As you can see by the config when there's an empty
`tsconfig.json`, `ts-node` defaults to `commonjs` modules! With `commonjs` modules, the
file extension isn't required.

The existence of the `tsconfig.json` is sufficient to signal to `ts-node` to use much
more lenient module loading which is required because the import isn't exactly a valid
ESM import.

However, it does work if one changes it to:

```typescript
import { TestConfig } from "../test-config.js";
```

and also transpiles the `test-config.ts` using `tsc`.

### Is It Worth It?

The in-memory transpilation capabilities and removal/abstracting of the `tsc` transpile
step would be big in a large code base. I'm tempted to remove `ts-node` in favour of
an explicit `tsc` call in `./test.sh`. 
