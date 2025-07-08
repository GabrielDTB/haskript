# The dumb Haskell script shebang flake

## Usage as a #!-interpreter

```plain
#!/usr/bin/env nix
#!nix shell <PATH>#[<PKG1>.<PKG2> ...]
```

- `PATH` is the path of this repo (use `github:GabrielDTB/haskript`) if you didn't clone it.
- `PKGS` are the package names (separated by `.`) that will be included in runghc.

For example,

```hs
#!/usr/bin/env nix
#!nix shell github:GabrielDTB/haskript#shh.relude

{-# LANGUAGE OverloadedStrings #-}
-- ...
```
