//
//  EMLViewController.m
//  EMLResizableNavigationBar
//
//  Created by enric.macias.lopez on 05/14/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import "EMLDemoViewController.h"

@interface EMLDemoViewController ()

@end

@implementation EMLDemoViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
    //self.resizableBarTitleDisappears = NO;
    //self.resizableBarResizePercent = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell: %ld", (long)indexPath.row];
    
    return cell;
}

@end
