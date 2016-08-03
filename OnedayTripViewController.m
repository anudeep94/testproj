//
//  OnedayTripViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 03/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OnedayTripViewController.h"
#define CURRENTPOSTION @"Kochi"
#define DESTINATION @"Alleppey"

@interface OnedayTripViewController ()

@end
int flag=1;
int lim=0;



@implementation OnedayTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"d"];
    
    [_dateLabel setText:[formatter stringFromDate:now]];
    [formatter setDateFormat: @"EEE\nMMM'/'yy"];
    [_monthLabel setText:[formatter stringFromDate:now]];
    
    
    UIImage *img1 = [UIImage imageNamed:@"KL.jpg"];
    [_onedayBGImage setImage:img1];
    UIImage *img2= [UIImage imageNamed:@"Circled Right 2-50.png"];
    [_arrowImage setImage:img2];
    
    
    UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    [_modImage setImage:img3];
  //  [formatter release];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressPlan:(id)sender {
    
    
}
- (IBAction)travelModeNxt:(id)sender {
    //UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    UIImage *img4 = [UIImage imageNamed:@"Train Filled-50.png"];
    UIImage *img5 = [UIImage imageNamed:@"Airplane Mode On Filled-50.png"];
    lim++;
    if (lim<4 && lim > 0) {
        flag++;
//        if (flag==1) {
//            [_modImage setImage:img3];
//        }
        /*else*/ if (flag==2) {
            [_modImage setImage:img4];
        }
        else if(flag==3)
        {
            [_modImage setImage:img5];
        }
    }
    else{
        lim=3;flag=3;
        [_modImage setImage:img5];
    }
    
}
- (IBAction)travelModePrvs:(id)sender {
    
    UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    UIImage *img4 = [UIImage imageNamed:@"Train Filled-50.png"];
    UIImage *img5 = [UIImage imageNamed:@"Airplane Mode On Filled-50.png"];
    lim--;
    if (lim<4 && lim > 0) {
        flag--;
        if (flag==1) {
            [_modImage setImage:img3];
        }
        else if (flag==2) {
            [_modImage setImage:img4];
        }
        else if(flag==3)
        {
            [_modImage setImage:img5];
        }
    }
    else {
    
        lim=1;flag=1;
        [_modImage setImage:img3];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
