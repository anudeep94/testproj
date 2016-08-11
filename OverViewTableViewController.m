//
//  OverViewTableViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 10/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OverViewTableViewController.h"
#import "SWRevealViewController.h"

@interface OverViewTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OverViewTableViewController{
   NSArray *menuItems;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     menuItems = @[@"date",@"activities",@"coupon",@"total"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    NSString* cellIdentifier;
    
    
    if (indexPath.row == 0) {
        cellIdentifier=@"date";
        cell=[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else if (indexPath.row == 1)
    {
        cellIdentifier=@"activities";
        cell=[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else if (indexPath.row == 2)
    {
        cellIdentifier=@"coupon";
        cell=[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else if (indexPath.row == 3)
    {
        cellIdentifier=@"total";
        cell=[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }

    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return 112.0;
    if(indexPath.row == 1)
        return 134;
    return 61.0;
    
}



@end
