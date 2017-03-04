# extbuilder

A macro tool that allows you to build C dependencies automatically

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  extbuilder:
    github: unn4m3d/extbuilder
```

## Usage

```crystal
require "extbuilder"

ExtBuilder.ext "../../ext/staticlib", static: true, output: "./staticlib"
lib StaticLib

end
```

Cmake is supported, as well as plain makefiles. There is also a thing called "Extfile" : a crystal program compiled with [this file](src/extbuilder/ext_prelude/extbuilder_prelude.cr) as prelude.

See example in spec directory.

## Contributing

1. Fork it ( https://github.com/unn4m3d/extbuilder/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [unn4m3d](https://github.com/unn4m3d)- creator, maintainer
