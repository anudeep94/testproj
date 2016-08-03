//
//  OnedayTripViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 03/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnedayTripViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *planButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *onedayBGImage;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UIButton *modeNxt;
@property (weak, nonatomic) IBOutlet UIButton *modePrvs;
@property (weak, nonatomic) IBOutlet UIImageView *modImage;

@end
