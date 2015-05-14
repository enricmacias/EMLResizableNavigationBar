//  Created by Enric Macias Lopez on 12/16/14.
//  Copyright (c) 2014 Enric Macias Lopez. All rights reserved.
//

#import "EMLResizableNavigationBarTableViewController.h"

#define kStatusBarHeight 20.0
#define kTitleImageTimesSmall 2.8

@interface EMLResizableNavigationBarTableViewController ()

@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, assign) CGFloat previousScrollViewYOffset;
@property (nonatomic, assign) CGSize titleSize;

@end

@implementation EMLResizableNavigationBarTableViewController

#pragma mark -
#pragma mark Lifecycle
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.resizableBarResizePercent = 0.0f;
    self.resizableBarTargetViewController = self;
    self.resizableBarTitleDisappears = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initTitleView];
    
    if (!self.titleSize.width){
        self.titleSize = self.titleView.image.size;
    }
    
    [self animateNavBarTo:kStatusBarHeight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Init
#pragma mark -

- (void)initTitleView
{
    if (self.resizableBarTargetViewController.title){
        self.titleView = [self imageViewFromString:self.resizableBarTargetViewController.title];
        UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
        [logoView setUserInteractionEnabled:NO];
        [logoView addSubview:self.titleView];
        self.resizableBarTargetViewController.navigationItem.titleView = logoView;
    }
    else if([self.resizableBarTargetViewController.navigationItem.titleView isKindOfClass:[UIImageView class]]){
        self.titleView = (UIImageView *) self.resizableBarTargetViewController.navigationItem.titleView;
        UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
        [logoView setUserInteractionEnabled:NO];
        [logoView addSubview:self.titleView];
        self.resizableBarTargetViewController.navigationItem.titleView = logoView;
    }
    else if([self.resizableBarTargetViewController.navigationItem.titleView.subviews[0] isKindOfClass:[UIImageView class]]){
        self.titleView = (UIImageView *) self.resizableBarTargetViewController.navigationItem.titleView.subviews[0];
    }
    
    self.titleView.frame = CGRectMake(0.0f, 0.0f, self.titleView.frame.size.width, self.titleView.frame.size.height);
}

#pragma mark -
#pragma mark - Override methods
#pragma mark -

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    [self initTitleView];
    
    if (!self.titleSize.width){
        self.titleSize = self.titleView.image.size;
    }
}

#pragma mark -
#pragma mark - Private methods
#pragma mark -

- (UIImageView *)imageViewFromString:(NSString *)string
{
    // Creates a label with the same options as the label in navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 20.0f)];
    label.backgroundColor = [UIColor clearColor];
    NSDictionary *titleTextAttributesDic = self.navigationController.navigationBar.titleTextAttributes;
    label.textColor = [titleTextAttributesDic objectForKey:NSForegroundColorAttributeName];
    label.font = [UIFont boldSystemFontOfSize:label.font.pointSize];
    label.userInteractionEnabled = NO;
    label.text = string;
    [label sizeToFit];
    
    // Coverts the label to an image
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0.0);
    [label.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [[UIImageView alloc] initWithImage:image];
}

#pragma mark -
#pragma mark Hiding Navigation Bar
#pragma mark -

- (void)updateNavigationBarButtonItems:(CGFloat)alpha
{
    // Buttons
    [self.resizableBarTargetViewController.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.resizableBarTargetViewController.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    
    // Title View
    CGRect newFrame = self.titleView.frame;
    newFrame.origin.x = ((1.0 - alpha)*((self.titleSize.width/kTitleImageTimesSmall)/2));
    newFrame.origin.y = ((1.0 - alpha)*13);
    newFrame.size.width = self.titleView.image.size.width + ((alpha - 1.0)*(self.titleSize.width/kTitleImageTimesSmall));
    newFrame.size.height = self.titleView.image.size.height + ((alpha - 1.0)*(self.titleSize.height/kTitleImageTimesSmall));
    self.titleView.frame = newFrame;
    
    if (self.resizableBarTitleDisappears){
        self.titleView.alpha = alpha;
    }
    
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
#pragma mark -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.userScrolling = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height > (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)){
        CGRect frame = self.navigationController.navigationBar.frame;
        
        if (frame.size.height != 0){
            CGFloat size = frame.size.height*(1.0 - self.resizableBarResizePercent) - kStatusBarHeight;
            CGFloat framePercentageHidden = ((kStatusBarHeight - frame.origin.y) / fabs((-size - kStatusBarHeight)));
            CGFloat scrollOffset = scrollView.contentOffset.y;
            CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
            CGPoint scrollVelocity = [[scrollView panGestureRecognizer] velocityInView:self.view];
            //CGFloat scrollHeight = scrollView.frame.size.height;
            //CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
            
            if (scrollOffset <= -scrollView.contentInset.top) {
                frame.origin.y = kStatusBarHeight;
            }
            // Deprecated: shows the navigation bar step by step when getting to the bottom of the scroll view.
            /*else if ((scrollOffset + scrollHeight) + (size + kStatusBarHeight) >= scrollContentSizeHeight) {
             if (frame.origin.y < kStatusBarHeight){
             frame.origin.y = MIN(kStatusBarHeight, MAX(-size, frame.origin.y + scrollDiff));
             }
             
             if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
             frame.origin.y = kStatusBarHeight;
             }
             }*/
            else {
                if (scrollVelocity.y < 0 && self.userScrolling){
                    frame.origin.y = MIN(kStatusBarHeight, MAX(-size, frame.origin.y - scrollDiff));
                }
                else if((scrollOffset <= -scrollView.contentInset.top + 44.0) && self.userScrolling){
                    frame.origin.y = MIN(kStatusBarHeight, MAX(-size, frame.origin.y - scrollDiff));
                }
            }
            
            [self.navigationController.navigationBar setFrame:frame];
            [self updateNavigationBarButtonItems:(1 - framePercentageHidden)];
            self.previousScrollViewYOffset = scrollOffset;
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGRect frame = self.navigationController.navigationBar.frame;
    
    if (frame.size.height != 0){
        CGFloat size = frame.size.height*(1.0 - self.resizableBarResizePercent) - kStatusBarHeight;
        CGFloat framePercentageHidden = ((kStatusBarHeight - frame.origin.y) / fabs((-size - kStatusBarHeight)));
        CGFloat scrollOffset = scrollView.contentOffset.y;
        CGFloat scrollHeight = scrollView.frame.size.height;
        CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
        
        NSLog(@"velocity: %f, %f",velocity.x,velocity.y);
        
        if ((framePercentageHidden < 1.0f) && (framePercentageHidden > 0.0f))
        {
            self.userScrolling = NO;
            
            if ((velocity.y < 0.20) && (scrollOffset <= -scrollView.contentInset.top + 44.0)) {
                [self animateNavBarTo:kStatusBarHeight];
            }
            else{
                [self animateNavBarTo:-size];
            }
        }
        else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
            self.userScrolling = NO;
            
            [self animateNavBarTo:kStatusBarHeight];
        }
        else if (velocity.y < -0.5) {
            self.userScrolling = NO;
            
            [self animateNavBarTo:kStatusBarHeight];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.userScrolling = NO;
}

#pragma mark -
#pragma mark Navigation Bar Animations
#pragma mark -

- (void)animateNavBarTo:(CGFloat)y
{
    [UIView animateWithDuration:0.15f animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        
        if (frame.size.height != 0){
            CGFloat size = frame.size.height*(1.0 - self.resizableBarResizePercent) - kStatusBarHeight;
            CGFloat framePercentageHidden = ((kStatusBarHeight - y) / fabs((-size - kStatusBarHeight)));
            frame.origin.y = y;
            [self.navigationController.navigationBar setFrame:frame];
            [self updateNavigationBarButtonItems:1-framePercentageHidden];
        }
    }];
}

@end
