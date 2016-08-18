//
//  SignupViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "SignupViewController.h"
#import "OTPViewController.h"

@interface SignupViewController () <UITextFieldDelegate>

@end

@implementation SignupViewController

NSString *name, *mobNumber, *pin;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    pin=@"680001";
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signupAction:(id)sender {
    
    if([_nameLabel.text isEqualToString:@""] || [_mailLabel.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter Name/Number."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else{
         [self performSegueWithIdentifier:@"signupSegue" sender:nil];
        name= _nameLabel.text;
        mobNumber= _mailLabel.text;
    }

    
}

//-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//   }
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    float newVerticalPosition = - keyboardSize.height + 150;
    
    [self moveFrameToVerticalPosition:newVerticalPosition forDuration:0.3f];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    [self moveFrameToVerticalPosition:0.0f forDuration:0.3f];
}


- (void)moveFrameToVerticalPosition:(float)position forDuration:(float)duration {
    CGRect frame = self.view.frame;
    frame.origin.y = position;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

@end
