//
//  KHATableViewWithSeamlessScrollingHeaderViewController.swift
//  KHATableViewWithSeamlessScrollingHeaderView
//
//  Created by Kohei Hayakawa on 12/24/15.
//  Copyright © 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit

public protocol KHATableViewWithSeamlessScrollingHeaderViewDataSource {
    func headerViewInView(view: KHATableViewWithSeamlessScrollingHeaderViewController) -> UIView
}

public class KHATableViewWithSeamlessScrollingHeaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, KHATableViewWithSeamlessScrollingHeaderViewDataSource {
    
    public var tableView: UITableView!
    public var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    public var navigationBarBackgroundColor = UIColor.whiteColor()
    public var navigationBarTitleColor = UIColor.blackColor()
    public var navigationBarShadowColor = UIColor.lightGrayColor()
    public var statusBarStyle = UIApplication.sharedApplication().statusBarStyle
    private let previousStatusBarStyle = UIApplication.sharedApplication().statusBarStyle
    
    override public func viewDidLoad() {
        headerView = headerViewInView(self)
        
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let headerViewHeight = headerView.frame.size.height
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: self.view.frame, style: .Plain)
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.size.height, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.frame.size.height, 0, 0, 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(headerView)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: tableView,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: tableView,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: tableView,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Top,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: tableView,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0)]
        )
        
        view.addConstraints([
            NSLayoutConstraint(
                item: headerView,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: headerView,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: headerView,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Top,
                multiplier: 1,
                constant: statusBarHeight+navBarHeight),
            NSLayoutConstraint(
                item: headerView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: headerViewHeight)]
        )
    }
    
    override public func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = statusBarStyle
    }
    
    override public func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().statusBarStyle = previousStatusBarStyle
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  public   
    func headerViewInView(view: KHATableViewWithSeamlessScrollingHeaderViewController) -> UIView {
        return headerView
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let headerViewHeight = headerView.bounds.size.height
        let tableViewOriginY = statusBarHeight + navBarHeight + headerViewHeight
        
        if tableView.contentOffset.y + tableViewOriginY <= 0 {
            headerView.frame = CGRectMake(headerView.bounds.origin.x,
                statusBarHeight + navBarHeight,
                headerView.bounds.size.width,
                headerView.bounds.size.height)
            setColorWithAlpha(0.0)
        } else {
            headerView.frame = CGRectMake(headerView.bounds.origin.x,
                -(tableView.contentOffset.y + headerViewHeight),
                headerView.bounds.size.width,
                headerViewHeight)
            let alpha = (tableView.contentOffset.y + tableViewOriginY) / tableViewOriginY
            setColorWithAlpha(alpha)
        }
    }
    
    
    // MARK: - Color handler
    
    /*! Seemlessly transparenting three colors of navbar background, navbar shadow and navbar title
    */
    private func setColorWithAlpha(alpha: CGFloat) {
        let alphaForNavBar = 8 * (alpha - 0.5)
        headerView.alpha = 1 - 3 * alpha
        self.navigationController?.navigationBar.setBackgroundImage(self.colorImage(navigationBarBackgroundColor.colorWithAlphaComponent(alphaForNavBar), size: CGSize(width: 1, height: 1)), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = self.colorImage(navigationBarShadowColor.colorWithAlphaComponent(alphaForNavBar), size: CGSize(width: 1, height: 1))
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: navigationBarTitleColor.colorWithAlphaComponent(alphaForNavBar)]
    }
    
    /*! Create UIImage from UIColor
    */
    private func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(origin: CGPointZero, size: size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    // MARK: - UITableViewDataSource
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("id", forIndexPath: indexPath)
        return cell
    }
}