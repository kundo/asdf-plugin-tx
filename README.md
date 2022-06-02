<div align="center">

# asdf-tx [![Build](https://github.com/kundo/asdf-tx/actions/workflows/build.yml/badge.svg)](https://github.com/kundo/asdf-tx/actions/workflows/build.yml) [![Lint](https://github.com/kundo/asdf-tx/actions/workflows/lint.yml/badge.svg)](https://github.com/kundo/asdf-tx/actions/workflows/lint.yml)


[tx](https://github.com/transifex/cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add tx
# or
asdf plugin add tx https://github.com/kundo/asdf-tx.git
```

tx:

```shell
# Show all installable versions
asdf list-all tx

# Install specific version
asdf install tx latest

# Set a version globally (on your ~/.tool-versions file)
asdf global tx latest

# Now tx commands are available
tx --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Why?
The Transifex CLI is not yet available through any easily scriptable
release channels like `homebrew`, `apt` or `pip`.

# License

See [LICENSE](LICENSE) © [Kundo Developers](https://github.com/kundo/)
