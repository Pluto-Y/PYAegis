# PYAegis
[![Build Status](https://travis-ci.com/Pluto-Y/PYAegis.svg?token=LaVCz9PJ9TzsasS9dizp&branch=master)](https://travis-ci.com/Pluto-Y/PYAegis)
[![codecov](https://codecov.io/gh/Pluto-Y/PYAegis/branch/master/graph/badge.svg?token=5yiHobxSI6)](https://codecov.io/gh/Pluto-Y/PYAegis)

A daemon framework to protect:
 - NSArray、NSMutableArray、NSDictionary、NSMutableDictionary、NSSet、NSMutableSet、NSCountedSet
 - NSString、NSMutableString
 - Unrecognized selector
 - NSTimer: protect for retain cycle
 - NSNotification: protect for the non removeObserver operation 
 - KVO: protect for not pair in `addObserver` and `removeObserver` operation

## Installation
- Cocoapods
  - specify it in your **Profile** - `pod 'PYAegis'`
- Manual
  - add all code under `PYAegis` folder to your project

## Requirements
- ARC
- iOS8+

## Communication
- Please open an issue, when you **found a bug**. Also provide the step to reproduce is better.
- Please open an issue, when you have **some feature request**
- Welcome pull request when you **want to contribute** for PYAegis

## Usage
Use cocoapods or manual add PYAegis to your project. Done!

## What we protect?
[Wiki](https://github.com/Pluto-Y/PYAegis/wiki/What-we-protect)

## License
PYAegis is released under the Apache License 2.0 license. See [LICENSE](https://github.com/Pluto-Y/PYAegis/blob/master/LICENSE) for details.
