# KHATableViewWithSeamlessScrollingHeaderView

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)

###CocoaPods
~~~
platform :ios, '9.0'
use_frameworks!

pod 'KHATableViewWithSeamlessScrollingHeaderView'
~~~

###Requirements
* iOS 9.0
* Xcode 7.0
* Swift 2.0

###Interface


###Usage
```swift
import UIKit
import KHATableViewWithSeamlessScrollingHeaderView

class MusicViewController: KHATableViewWithSeamlessScrollingHeaderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Star Wars IV: A New Hope"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "addTapped")

	    // Color settings
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationBarTitleColor = UIColor.whiteColor()
        navigationBarBackgroundColor = UIColor.blackColor()
        navigationBarShadowColor = UIColor.lightGrayColor()
        tableView.backgroundColor = UIColor.blackColor()
        tableView.indicatorStyle = .White
        statusBarStyle = .LightContent
    }

	// Header view
    override func headerViewInView(view: KHATableViewWithSeamlessScrollingHeaderViewController) -> UIView {
        return UINib(nibName: "MusicHeaderView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
    }
}
```

We have to set "NO" to "View controller-based status bar appearance" at Info.plist

###Contact
[@pettarou2](https://twitter.com/pettarou2)

###License
KHATableViewWithSeamlessScrollingHeaderView is released under the MIT license. See LICENSE for details.
