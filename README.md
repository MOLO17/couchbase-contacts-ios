# iOS Contacts sample app

### Powered by Couchbase Lite!

This repository contains the sources of an iOS sample app that demonstrates how to setup
the Couchbase Lite SDK with a Couchbase Sync Gateway for replicating data across mobile devices.

## Requirements

- Xcode >= 11.2.1
- bundler
- xcodegen

## Setup

- Clone the repository and browse with your terminal to the project directory;
- Run the `xcodegen` command. As you may have noticed, the `.xcodeproj` file is 
not under version control;
- Run a CocoaPods install using bundler -> `bundle exec pod install`;
- Open the `.xcworkspace` file;

Done!

Now you need to setup the Sync Gateway configuration of your mobile client. Open the 
`Constants.swift` file and fill the empty constants like below:

```swift
let RemoteDatabaseURL = "ws://10.0.2.2:4984/example-bucket/"
let Username = "user"
let Password = "password"
```

## Authors

- [Damiano Giusti](mailto:damiano.giusti@molo17.com)
- [Matteo Sist](mailto:matteo.sist@molo17.com)

