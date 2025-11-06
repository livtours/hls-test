To test this:

```bash
devenv shell
haskell-language-server-wrapper
```

should result in a `can't find a package database at hls-test/hls-test.cabal is up to-date` error.

---

Note that hls works fine without nix and using tools installed with ghcup.
The only requirement is to install hls with `ghcup compile hls -v 2.12.0.0 --ghc 9.10.3 -- -f-hlint`
