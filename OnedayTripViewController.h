//
//  OnedayTripViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 03/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface OnedayTripViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *planButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *onedayBGImage;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UIButton *modeNxt;
@property (weak, nonatomic) IBOutlet UIButton *modePrvs;
@property (weak, nonatomic) IBOutlet UIImageView *modImage;
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;
@property (weak, nonatomic) IBOutlet UIButton *calenderButton;

@property (nonatomic) UIBarButtonItem *rightBtn;
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic, retain) UIToolbar *keyboardToolbar;

@property(nonatomic) NSString *fromPlace;
@property(nonatomic)NSString *toPlace;
@property(nonatomic) NSString *fromSnippet;
@property(nonatomic)NSString *toSnippet;
//@property (nonatomic)CLLocation* fromCoordinates;
//@property (nonatomic)CLLocation* toCoordinates;
@property (nonatomic)CLLocation *location;
@property (nonatomic)CLLocation *location2;
@end
