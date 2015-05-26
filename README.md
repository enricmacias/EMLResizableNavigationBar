# EMLResizableNavigationBar

[![CI Status](http://img.shields.io/travis/enric.macias.lopez/EMLResizableNavigationBar.svg?style=flat)](https://travis-ci.org/enric.macias.lopez/EMLResizableNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/EMLResizableNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EMLResizableNavigationBar)
[![License](https://img.shields.io/cocoapods/l/EMLResizableNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EMLResizableNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/EMLResizableNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EMLResizableNavigationBar)

## Description

Implements a navigation bar behaviour such as the one in Safari app. Allows some kind of behaviour customization.

![alt tag](https://raw.github.com/enricmacias/EMLResizableNavigationBar/master/Preview/preview.gif)

## Requirements

- iOS 7.0
- ARC

## Usage

1. Inherit your UIViewController class containing the UIScrollView/UITableView with EMLResizableNavigationBarViewController.
2. Set the UIScrollView/UITableView delegate to self.
3. You are done!

NOTE: You cannot inherit directly from UITableViewController. To use EMLResizableNavigationBar with a UITableView you need to create a property table view inside a UIViewController and adopt UITableViewDataSource plus UITableViewDelegate.

```objective-c
@interface EMLDemoViewController : EMLResizableNavigationBarViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
```

## Customization

Add a title:
```objective-c
self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
```
or
```objective-c
self.title = @"ResizableBar";
```

Hide the bar just half its size:
```objective-c
self.resizableBarResizePercent = 0.5f;
```

Show the title even when the bar is hidden:
```objective-c
self.resizableBarTitleDisappears = NO;
```

## Installation

#### Cocoapods

EMLResizableNavigationBar is available through [CocoaPods](http://cocoapods.org). 

```ruby
pod "EMLResizableNavigationBar"
```

#### Manually

Import the following files into your project:

EMLMenuBar/Pod/Classes folder:
```ruby
EMLResizableNavigationBarViewController.h
EMLResizableNavigationBarViewController.m
```

## Author

enric.macias.lopez, enric.macias.lopez@gmail.com

## License

EMLResizableNavigationBar is available under the MIT license. See the LICENSE file for more info.
