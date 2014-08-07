# Chain

The Official iOS SDK for Chain's Bitcoin API.

## Install

Chain is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'Chain', '0.1.15'
```

## Quick Start

```objc
Chain *chain = [Chain sharedInstanceWithToken:@"GUEST-TOKEN"];

NSString *address = @"1A3tnautz38PZL15YWfxTeh8MtuMDhEPVB";

[chain getAddress:address completionHandler:^(NSDictionary *dict, NSError *error) {
  NSLog(@"data=%@ error=%@", dict, error);
}];
```

## Documentation

The Chain API Documentation is available at [https://chain.com/docs/ios](https://chain.com/docs/ios)

## Publishing a CocoaPod

```bash
$ git tag X.Y.Z
$ git push origin master --tags
$ pod trunk push Chain.podspec
```
