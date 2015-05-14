//
//  EMLViewController.h
//  EMLResizableNavigationBar
//
//  Created by enric.macias.lopez on 05/14/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EMLResizableNavigationBarViewController.h>

@interface EMLDemoViewController : EMLResizableNavigationBarViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
