//
//  OTPViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OTPViewController.h"
#import "AppDelegate.h"

@interface OTPViewController ()
@property (weak, nonatomic) AppDelegate *appDelegate;


@end

extern NSString *pin;

@implementation OTPViewController

NSString *recvOTP;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.161 green:0.749 blue:0.612 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regButtonAction:(id)sender
{
    if ([_otpLabel.text isEqualToString:@""] )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter OTP."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        recvOTP= _otpLabel.text;
        
        if ([recvOTP isEqualToString:pin]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"isLogin"];
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"revealViewController"];
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.window setRootViewController:vC];
            
        } else{
            UIAlertView *otpalert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                            message:@"Wrong OTP."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [otpalert show];
        
                }
        
        }
}

@end
