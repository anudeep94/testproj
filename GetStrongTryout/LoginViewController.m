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

@interface LoginViewController () <UITextFieldDelegate> {
    NSString *mailId;
    NSString *password;
    NSArray *groups;
    NSString *loginStatus, *cookie , *cookieName;
    NSDictionary *jsonDic, *jsonDic1;
    NSDictionary *detailsDic;
}


@property (weak, nonatomic) AppDelegate *appDelegate;
@property(weak,nonatomic) AppDelegate *delegate;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginGreenButtonPressed:(id)sender {
    
    //[_loginButton1 sendActionsForControlEvents:UIControlEventTouchUpInside];
    //[_loginButton1 performSelector:@selector(startFetchingNonce:) withObject:nil afterDelay:0.25];
    
    
    if([_mailLabel.text isEqualToString:@""] || [_passwordLabel.text isEqualToString:@""] ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter Mail Id/Password."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        mailId= _mailLabel.text;
        password=_passwordLabel.text;
        //    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Message"
        //                                                         message:@"Login Successful."
        //                                                        delegate:self
        //                                               cancelButtonTitle:@"OK"
        //                                               otherButtonTitles:nil];
        //    [loginAlert show];
        
        
        
        
        
        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"isLogin"];
//        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"revealViewController"];
//        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//        [appDelegate.window setRootViewController:vC];
        [self verifyUser];
    }

   
}

- (void)verifyUser
{
    NSString *urlString = [NSString stringWithFormat:
                  @"https://www.yatramantra.com/kerala/usermanager/user/generate_auth_cookie/?username=%@&password=%@", mailId, password];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription);
                               }
                               else{
                                   NSError *error = nil;
                                   jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                   
                                   if (error != nil) {
                                       NSLog(@"Error parsing JSON.");
                                   }
                                   else {
                                       NSLog(@"Array: %@", jsonDic);
                                       loginStatus= [jsonDic valueForKey:@"status"];
                                       detailsDic=[jsonDic valueForKey:@"user"];
                                       cookie=[jsonDic valueForKey:@"cookie"];
                                       cookieName=[jsonDic valueForKey:@"cookie_name"];
                                       NSLog(@"User Details: %@", detailsDic);
                                       NSLog(@"cookie: %@ cookie Nme: %@",cookie, cookieName);
                                       
                                       if ([loginStatus isEqualToString:@"ok"]) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                                                    message:@"Login Successful."
                                                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                               [loginAlert show];
                                               [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"isLogin"];
                                               
                                               UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                               UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"revealViewController"];
                                               AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
                                               [appDelegate.window setRootViewController:vC];
                                           });
                                           
                                           
                                       }
                                       else{
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                                           message:@"Wrong Username/Password!"
                                                                                          delegate:self
                                                                                 cancelButtonTitle:@"OK"
                                                                                 otherButtonTitles:nil];
                                           [alert show];
                                       }
                                       
                                   }
                               
                               }
                           }];
    
    
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
        
        
        
        
        
        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"isLogin"];
//        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"revealViewController"];
//        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//        [appDelegate.window setRootViewController:vC];
    
    }
}
- (IBAction)signupPressedAtLogin:(id)sender {
[self performSegueWithIdentifier:@"signupButtonSegue" sender:nil];    
}


- (IBAction)forgotPasswordPressed:(id)sender {
    
    if([_mailLabel.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter Mail Id."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        mailId=_mailLabel.text;
        
        NSString *urlString = [NSString stringWithFormat:
                               @"https://www.yatramantra.com/kerala/usermanager/user/retrieve_password/?user_login=%@", mailId];
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       NSLog(@"error:%@", error.localizedDescription);
                                   }
                                   else{
                                       NSError *error = nil;
                                       jsonDic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                       
                                       if (error != nil) {
                                           NSLog(@"Error parsing JSON.");
                                                }
                                       else {
                                           NSLog(@"Array: %@", jsonDic1);
                                           loginStatus= [jsonDic1 valueForKey:@"status"];
                                            NSString *message;
                                           if ([loginStatus isEqualToString:@"ok"]) {
                                               message= @"NewPassword sent you Mail Id.";
                                           }
                                            else{
                                               message= @"Wrong Username.";
                                                }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               UIAlertView *mailIDAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                                                    message:[NSString stringWithFormat:@"%@",message]
                                                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                               [mailIDAlert show];
                                          });
                                           NSLog(@"Message :%@",message);
                                       }
                                   }
                               }];
    }
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
