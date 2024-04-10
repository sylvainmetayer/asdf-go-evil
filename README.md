<div align="center">

# asdf-go [![Build](https://github.com/sylvainmetayer/asdf-go-evil/actions/workflows/build.yml/badge.svg)](https://github.com/sylvainmetayer/asdf-go-evil/actions/workflows/build.yml) [![Lint](https://github.com/sylvainmetayer/asdf-go-evil/actions/workflows/lint.yml/badge.svg)](https://github.com/sylvainmetayer/asdf-go-evil/actions/workflows/lint.yml)

[go](https://github.com/golang/go) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-go  ](#asdf-go--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `jq`, `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `ASDF_GO_DEMO_DOWNLOADED_RELEASES_DIRECTORY`: Define this variable before installing a version for demonstration purpose to avoid download delay/errors. It will not download release file from go website, but will look for files in this given directory. Only used in the `bin/download` script

# Install

Plugin:

```shell
asdf plugin add go
# or
asdf plugin add go https://github.com/sylvainmetayer/asdf-go-evil.git
```

go:

```shell
# Show all installable versions
asdf list-all go

# Install specific version
asdf install go latest

# Set a version globally (on your ~/.tool-versions file)
asdf global go latest

# Now go commands are available
go version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/sylvainmetayer/asdf-go-evil/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Sylvain](https://github.com/sylvainmetayer/)
