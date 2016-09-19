//
//  OverViewTableViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 10/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OverViewTableViewController.h"
#import "SWRevealViewController.h"
#import "OnedayTripViewController.h"

@interface OverViewTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OverViewTableViewController{
   NSArray *menuItems;
    int i,j;
    UILabel *adultCountLabel;
    UILabel *childCountLabel;
    BOOL bookable;
    NSString *imageURL;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     menuItems = @[@"date",@"activities",@"coupon",@"total"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
     adultCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(279,73,22,18)];
    childCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(279,106,22,18)];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    NSLog(@" added POI: %@",_poiDetails);
    bookable=[[_poiDetails objectForKey:@"bookable"]boolValue];

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
        UILabel *taggedFromDateLabel =(UILabel*) [cell viewWithTag:11];
        UILabel *taggedToDateLabel =(UILabel*) [cell viewWithTag:12];
        UILabel *taggedFromMonthLabel =(UILabel*) [cell viewWithTag:13];
        UILabel *taggedToMonthLabel =(UILabel*) [cell viewWithTag:14];
        UILabel *taggedFromLabel =(UILabel*) [cell viewWithTag:15];
        UILabel *taggedToLabel =(UILabel*) [cell viewWithTag:16];
        
        
        taggedToDateLabel.text=_toDateLabel.text;
        taggedToMonthLabel.text=_toMonthLabel.text;
        taggedFromDateLabel.text=_fromDateLabel.text;
        taggedFromMonthLabel.text= _fromMonthLabel.text;
        taggedFromLabel.text=_fromPlace;
        taggedToLabel.text=_toPlace;
        
        
        
    }
    else if (indexPath.row == 1)
    {
        cellIdentifier=@"activities";
        cell=[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (bookable) {
            
        
        UIButton *plusButton1 = [[UIButton alloc] initWithFrame:CGRectMake(304, 75, 15, 15)];
        UIButton *minusButton1 = [[UIButton alloc] initWithFrame:CGRectMake(261, 75, 15, 15)];
        UIButton *plusButton2 = [[UIButton alloc] initWithFrame:CGRectMake(304, 108, 15, 15)];
        UIButton *minusButton2 = [[UIButton alloc] initWithFrame:CGRectMake(261, 108, 15, 15)];
        [cell.contentView addSubview:plusButton1];
        [cell.contentView addSubview:minusButton1];
        [cell.contentView addSubview:plusButton2];
        [cell.contentView addSubview:minusButton2];
        [plusButton1 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
        [minusButton1 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
        [plusButton2 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
        [minusButton2 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
        plusButton1.tag=1111;
        plusButton2.tag=3333;
        minusButton1.tag=2222;
        minusButton2.tag=4444;
        [plusButton1 addTarget:self
                        action:@selector(addNum:)
              forControlEvents:UIControlEventTouchUpInside];
        [plusButton2 addTarget:self
                        action:@selector(addNum:)
              forControlEvents:UIControlEventTouchUpInside];
        [minusButton1 addTarget:self
                     action:@selector(minusNum:)
           forControlEvents:UIControlEventTouchUpInside];
        [minusButton2 addTarget:self
                     action:@selector(minusNum:)
           forControlEvents:UIControlEventTouchUpInside];
        plusButton1.alpha=0.5f;
        minusButton1.alpha=0.5f;
        plusButton2.alpha=0.5f;
        minusButton2.alpha=0.5f;
       
        [cell.contentView addSubview:adultCountLabel];
        [cell.contentView addSubview:childCountLabel];
        adultCountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        childCountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
//        UILabel *taggedEventLabel =(UILabel*) [cell viewWithTag:201]; //event Name
//        UIImageView *taggedEventImageView = (UIImageView*) [cell viewWithTag:101];// Event icon ImageVIew
//        UIImageView *taggedLargeImageView = (UIImageView*) [cell viewWithTag:102];// Event ImageViewLarge
//        UIImageView *taggedAdultIconView = (UIImageView*) [cell viewWithTag:103];//Adult Icon
//        UIImageView *taggedChildIconView = (UIImageView*) [cell viewWithTag:104];//child Icon
        }
        UIImageView *activityImageView =(UIImageView*) [cell viewWithTag:102];
        imageURL= [_poiDetails valueForKey:@"image"];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *urlContent = [NSData dataWithContentsOfURL:url];
        
        
        UIImage *img = [[UIImage alloc] initWithData:urlContent];
        [activityImageView setImage:img];

         UILabel *taggedSmallDateLabel =(UILabel*) [cell viewWithTag:205];
        taggedSmallDateLabel.text=_smallDateLabel.text;
        
        
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


-(void)addNum:(UIButton*) sender
{
    if(sender.tag ==1111)
    {i++;
        adultCountLabel.text= [NSString stringWithFormat:@"%d",i ];
    }
    if (sender.tag ==3333) {
        j++;
        childCountLabel.text= [NSString stringWithFormat:@"%d",j ];
    }
    
    
}
-(void)minusNum:(UIButton*) sender
{
    if(i>0 ){
        if(sender.tag ==2222)
        {i--;
            adultCountLabel.text= [NSString stringWithFormat:@"%d",i ];
        }}
    if(j>0 )
        if (sender.tag ==4444) {
            j--;
            childCountLabel.text= [NSString stringWithFormat:@"%d",j ];
        }
    
}



@end
