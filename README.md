To test this:

```bash
devenv shell
haskell-language-server-wrapper
```

should result in a `can't find a package database at hls-test/hls-test.cabal is up to-date` error.

---

Note that outside of nix and and using tools installed with ghcup, both 2.11 (`ghcup compile hls -v 2.11.0.0 --ghc 9.10.3`) and 2.12 (`ghcup compile hls -v 2.12.0.0 --ghc 9.10.3 -- -f-hlint`) work correctly.
