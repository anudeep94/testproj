//
//  LoginViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define baseURL @"https://www.yatramantra.com/kerala"

@interface LoginViewController () <UITextFieldDelegate>


@property (weak, nonatomic) AppDelegate *appDelegate;
@property(weak,nonatomic) AppDelegate *delegate;

@end

@implementation LoginViewController
NSString *mailId;
NSArray *groups;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startFetchingNonce:)
                                                 name:@"kCLAuthorizationStatusAuthorized"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startFetchingNonce:(NSNotification *)notification
{
    NSString *urlAsString = [NSString stringWithFormat:@"%@", baseURL];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSLog(@"%@", urlAsString);
    
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] >0 && error == nil)
        {
            
//            [self receivedData:data];
            
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
        }
        else if (error != nil){
            NSLog(@"Error = %@", error);
        }
    
    
    }];
    
}
-(void) fetchingNonceFailedWithError:(NSError *)error
{
    [self fetchingNonceFailedWithError:error];
}

//-(void)receivedData:(NSData *)objectNotation
//{
//    NSError *error=nil;
//    NSArray *receivedGroups=[LoginViewController dataFromServer:objectNotation error:&error];
//    
//    if(error !=nil)
//    {
//        [self fetchingNonceFailedWithError:error];
//    }else{
//        
//        [self didReceiveGroups:receivedGroups];
//    }
//}

//+(NSString *)dataFromServer:(NSData *)objectNotation error:(NSError **) error{
//    NSError *localError = nil;
////    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];//Converts the JSON content, make it readable for the compiler.
////    
////    if (localError != nil) {
////        *error = localError;
////        return nil;
////    }
//    
//  //  return
//}



- (void)didReceiveGroups:(NSArray *)receivedGroups
{
    dispatch_async(dispatch_get_main_queue(), ^{
        groups = receivedGroups;
       
    });
    //Reloads New data into the the table view.
}
- (IBAction)loginAction:(id)sender {
    
    
    if([_mailLabel.text isEqualToString:@""] || [_passwordLabel.text isEqualToString:@""] ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter Mail Id."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
    
    mailId= _mailLabel.text;
//    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Message"
//                                                         message:@"Login Successful."
//                                                        delegate:self
//                                               cancelButtonTitle:@"OK"
//                                               otherButtonTitles:nil];
//    [loginAlert show];
        
        
        
        
        
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"isLogin"];
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"revealViewController"];
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [appDelegate.window setRootViewController:vC];
    
    }
}
- (IBAction)signupPressedAtLogin:(id)sender {
[self performSegueWithIdentifier:@"signupButtonSegue" sender:nil];    
}

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
    
    float newVerticalPosition = - keyboardSize.height + 100;
    
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
