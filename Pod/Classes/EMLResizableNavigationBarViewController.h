//  Created by Enric Macias Lopez on 12/16/14.
//  Copyright (c) 2014 Enric Macias Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMLResizableNavigationBarViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL resizableBarTitleDisappears;
@property (nonatomic, assign) CGFloat resizableBarResizePercent; // 0.0 Completely gone // 1.0
@property (nonatomic, strong) UIViewController *resizableBarTargetViewController;
@property (nonatomic, assign) BOOL userScrolling;

- (void)updateNavigationBarButtonItems:(CGFloat)alpha;

@end
