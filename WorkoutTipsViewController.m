//
//  WorkoutTipsViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 22/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "WorkoutTipsViewController.h"
#import "SWRevealViewController.h"

@interface WorkoutTipsViewController ()<UITextViewDelegate>
{NSString *message, *sub,*cookie;
    NSDictionary *jsonDic;
}

@end

@implementation WorkoutTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    _textView.delegate = self;
    cookie=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
}
- (IBAction)callRequestPressed:(id)sender {
    
    
    message= _textView.text;
    sub=_subTxtField.text;
    
    if ([sub isEqualToString:@""] || [message isEqualToString:@""]) {
        UIAlertView *emptyAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Forgot to enter Subject/Message."
                                                             delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [emptyAlert show];
    }
    else{
//    NSString *urlString = [NSString stringWithFormat:
//                           @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_support&auth=%@&sub=%@&msg=%@", cookie,sub, message];
//    
////    NSURL *url = [[NSURL alloc] initWithString:urlString];
//        NSString *percentEscapedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        NSURL *url = [[NSURL alloc] initWithString:percentEscapedString];
//
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"error:%@", error.localizedDescription);
//                               }
//                               else{
//                                   NSError *error = nil;
//                                 id jsonD = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                                   
//                                   if (error != nil) {
//                                       NSLog(@"Error parsing JSON.  %@", error);
//                                   }
//                                   else {
//                                       
//                                       NSLog(@"Support Response: %@", jsonD);
//                                       
////                                       dispatch_async(dispatch_get_main_queue(), ^{
////                                           
////                                           
////                                       });
//                                   }
//                               }
//                           }];
        
        
        NSString *strupload=[NSString stringWithFormat:@"sub=%@&msg=%@&type=support",sub, message];
        NSString *strurl=[NSString stringWithFormat:
                                                  @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_support"];
        //NSString *strpostlength=[NSString stringWithFormat:@"%d",[strupload length]];
        NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
        
        [urlrequest setURL:[NSURL URLWithString:strurl]];
        [urlrequest setHTTPMethod:@"POST"];
        [urlrequest setValue:cookie forHTTPHeaderField:@"Authorization"];
        [urlrequest setHTTPBody:[strupload dataUsingEncoding:NSUTF8StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            NSError *error1;
            NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
            
            NSLog(@"res dicitionary: %@",res);
        }];
        
        
//        NSMutableURLRequest *request = [NSMutableURLRequest
//                                        requestWithURL:[NSURL URLWithString:@"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_support"]];
//        
//        NSString *params = [[NSString alloc] initWithFormat:@"auth=%@&sub=%@&msg=%@", cookie,sub, message];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        
        
    }
    
    
}
- (IBAction)callButtonpressed:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@"placeholder text here..."]) {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor]; //optional
//    }
//    [textView becomeFirstResponder];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@""]) {
//        textView.text = @"placeholder text here...";
//        textView.textColor = [UIColor lightGrayColor]; //optional
//    }
//    [textView resignFirstResponder];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
