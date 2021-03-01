# Chess
This is supposed to provide a testing ground for playing with haskell while learning about how to interact with chess programmatically.

## Prerequisites

### Toolchain and VSCode setup
You must make sure that `stack` is installed on your system. `stack` is a toolchain for handling Haskell projects with dependencies and other required configuration. More information can be found in their [docs](https://docs.haskellstack.org/en/stable/GUIDE/). You can check this with:
```bash
stack --version
```
To install `stack` run the following command:
```bash
brew install haskell-stack
```
You will then need to make sure that you have the correct version of `ghc` installed for this project which you can do by running the following from within this directory:
```bash
stack setup
```
You might also want to install a number of extensions for vscode to make devlopment easier:
```bash
code --install-extension haskell.haskell
code --install-extension justusadam.language-haskell
code --install-extension hoovercj.haskell-linter
```
The last extension will require that you also have `hlint` installed. This can be installed using `stack`:
```bash
stack install hlint
```
You will also have to add something to your global vscode settings. You can access these by pressing `cmd+shift+P`, typing in "settings" and then selecting "Preferences: Open Settings (JSON)". This is what you will want to add, replacing `<user-name>` with your own system name:
```json
{
    ...
    "haskell.hlint.executablePath": "/Users/<user-name>/.local/bin/hlint"
}
```

## Running tests
The tests are all contained within `./test` folder. The are written in a very similar way to how we use `jest`/`mocha` but with a tool called `hspec`. To run them simply use:
```
stack test
```