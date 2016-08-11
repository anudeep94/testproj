//
//  OverViewTableViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 10/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewTableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toMonthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityIconImage;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adultIconImage;
@property (weak, nonatomic) IBOutlet UIImageView *childIconImage;
@property (weak, nonatomic) IBOutlet UIButton *minusButton1;
@property (weak, nonatomic) IBOutlet UIButton *plusButton1;
@property (weak, nonatomic) IBOutlet UILabel *adultCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton2;
@property (weak, nonatomic) IBOutlet UIButton *plusButton2;
@property (weak, nonatomic) IBOutlet UILabel *childCountLabel;


@end
