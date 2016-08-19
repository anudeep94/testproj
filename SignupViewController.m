//
//  SignupViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "SignupViewController.h"


@interface SignupViewController () <UITextFieldDelegate>{
    NSString *name, *mailId, *pin;
    NSDictionary *jsonDic1, *jsonDic2;
    
    NSString *userNonce;
}

@end

@implementation SignupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupButton:(id)sender {
    
    if([_nameLabel.text isEqualToString:@""] || [_mailLabel.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Forgot to Enter Name/MailID/Password."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        [self performSegueWithIdentifier:@"signupSegue" sender:nil];
        name= _nameLabel.text;
        mailId= _mailLabel.text;
        pin=_passwordField.text;
        [self startFetchingNonce];
        
    }

    
}

- (void)startFetchingNonce
{
    NSURL *url = [NSURL URLWithString:
                  @"https://www.yatramantra.com/kerala/usermanager/get_nonce/?controller=user&method=register"];
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
//                                   id jsonDic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                   
                                    jsonDic1 = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                     error:&error];
                                   
                                   if (error != nil) {
                                       NSLog(@"Error parsing JSON.");
                                   }
                                   else {
                                       NSLog(@"Array: %@", jsonDic1);
                                       userNonce= [jsonDic1 valueForKey:@"nonce"];
                                       NSLog(@"Nonce: %@",userNonce);
                                       [self registeringUser];

                                   }
                                   
                               }
                           }];
    
    
}
-(void) registeringUser{

    
    
    NSString *url2 = [NSString stringWithFormat:
                  @"https://www.yatramantra.com/kerala//usermanager/user/register/?username=%@&email=%@&nonce=%@&display_name=%@&notify=both&user_pass=%@", mailId, mailId, userNonce, name, pin];
    
    NSURL *url21 = [[NSURL alloc] initWithString:url2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url21];
    //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request2
                                       queue:queue2
                           completionHandler:^(NSURLResponse *response2, NSData *data2, NSError *error2){
                               if (error2) {
                                   NSLog(@"error:%@", error2.localizedDescription);
                               }
                               else{
                                   NSError *error2 = nil;
                                   //                                   id jsonDic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                   
                                   jsonDic2 = [NSJSONSerialization JSONObjectWithData:data2
                                                                              options:NSJSONReadingAllowFragments
                                                                                error:&error2];
                                   
                                   if (error2 != nil) {
                                       NSLog(@"Error parsing JSON.");
                                   }
                                   else {
                                      NSLog(@"Array: %@", jsonDic2);
                                                                        }
                                   
                               }
                           }];


}


//- (IBAction)signupAction:(id)sender {
//    
//    if([_nameLabel.text isEqualToString:@""] || [_mailLabel.text isEqualToString:@""]){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
//                                                        message:@"Forgot to Enter Name/Number."
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//    }
//    else{
//         [self performSegueWithIdentifier:@"signupSegue" sender:nil];
//        name= _nameLabel.text;
//        mailId= _mailLabel.text;
//    }

    
//}

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
