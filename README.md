# Aspen

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

I got annoyed with Lumberjack, so I made my own logging framework called Aspen.

### Features

* Simple setup. There's a global/shared logging framework set up you can use with two lines of code.
* Console and/or file-based logging.
* Different levels per log.
* Convention over configuration.

### Installation

You can install Aspen through [Carthage][c] or as a Git submodule using the Aspen framework target.

There is currently not a podspec. See the Support section below for why.

### Contributing

If you are interested in contributing to Aspen, please check out our [contributing guide][contributing].

### Stability

Aspen is currently shipping in the [TED iOS app][ted], which is used by a lot of people and none of
them complain about our logging.

### Support

Right now this is considered pretty early days. I'm probably going to break stuff as I figure out
how I want to integrate it into my projects. You're welcome to use and contribute to it, but just
know you're not dealing with a 1.0 yet.

Once things stabilize a bit more, I'll add in a podspec so that more people can easily use it.


[c]: https://github.com/Carthage/Carthage
[cp]: http://cocoapods.org
[contributing]: https://github.com/justin/Aspen/blob/master/.github/CONTRIBUTING.md
[ted]: https://ted.com
