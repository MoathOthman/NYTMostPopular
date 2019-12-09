
## Preface 
This project is an iOS project that fetch the Most popule articles from nytimes using their public API.[here](https://developer.nytimes.com/)

## Specs
This app is targeting **iOS 13**. using **Xcode 11.0. Cocoapods 1.8.4, fastlane 2.131.0, swiftlint, MVVM, RXSwift, Nimble, Mockingjay, ruby 2.4.4**.

To Explicitly declare and isolate ruby dependencies we use **bundler**.

# how to use 

## Run the project and tests
open the workspace file in xcode and run using CMD+R , or CMD+U to run the unit tests.


you probably wont need to run `pod install` but if you had issues with configurations you can use this command .

`gem install bundler && bundle install && bundle exec pod install` 
* in case you had issue with ruby version you might install RVM , check **install RVM** section


### Run tests through CLI
you can use `bundle exec fastlane scan` or `bundle exec fastlane test device_name:"iPhone 11"`

to run coverage use this command

`slather coverage -s --scheme NYTMostVPopularArticles --workspace ./NYTMostVPopularArticles.xcworkspace ./NYTMostVPopularArticles.xcodeproj`

You can check the coverage in xcode as well in the Report navigator.

### Layout testing
The project uses [LayoutTest library](https://github.com/linkedin/LayoutTest-iOS) to perform layout testing which somewhere between UI and unit testing but run as a unit test, so its fast. *only covering the articleViewController

### Linting
linting is executed through a build phase on each build. you may also run `./Pods/SwiftLint/swiftlint`

## install RVM (if needed)

ruby version used is the system ruby on mac wont work most likely. 
You might need to install RVM  you can do that using 

```
brew install gnupg

curl -sSL https://rvm.io/mpapis.asc | gpg --import -

curl -L https://get.rvm.io | bash -s stable --auto-dotfiles

source ~/.bash_profile
```

also check [rvm.io](https://rvm.io/rvm/install)
