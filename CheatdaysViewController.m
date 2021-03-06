//
//  CheatdaysViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 22/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "CheatdaysViewController.h"
#import "SWRevealViewController.h"

@interface CheatdaysViewController (){
    NSDictionary *detailsDic, *jsonDic,*jsonDic2, *jsonDic3;
    NSData *datas;
    NSString *cookie, *cookieName, *phnNmbr, *username,*mailID,*location, *pin;
}


@end

@implementation CheatdaysViewController

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
    
    mailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MailID"];
    pin=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    _mailLabel.text=mailID;
    datas = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyStrings"];
    NSLog(@"Details@MyAccount :%@",datas);
    cookie=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
    cookieName=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookiename"];
    detailsDic= (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:datas];
    NSLog(@"recieved details:%@",detailsDic);
    NSLog(@"recievedCookie: %@",cookie);
    NSLog(@"recieveddCookieName :%@",cookieName);
    [self uploadingExistingUserdetails];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) upadteUserDetails{
    
    
    
    NSString *url2 = [NSString stringWithFormat:
                      @"https://www.yatramantra.com/kerala/usermanager/user/update_user_meta_vars/?cookie=%@&display_name=%@&billing_phone=%@&billing_country=%@",cookie,username,phnNmbr,location];
    
    NSString *percentEscapedString = [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url21 = [[NSURL alloc] initWithString:percentEscapedString];
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
                                  // [[NSUserDefaults standardUserDefaults] setObject:json2 forKey:@"cookiename"];
                                   if (error2 != nil) {
                                       NSLog(@"Error parsing JSON.");
                                   }
                                   else {
                                       NSLog(@"return data after Updating: %@", jsonDic2);
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           UIAlertView *signupAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                                                 message:@"UserDatails Upadte Successful."
                                                                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                           [signupAlert show];
                                       });
                                   }
                                   
                               }
                           }];
    
}






- (IBAction)doneButtonPressed:(id)sender {
    
    if ([_locationField.text isEqualToString:@""] || [_nameTxtField.text isEqualToString:@""] || [_phnTxtField.text isEqualToString:@""]) {
        UIAlertView *missingAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Forgot to enter details."
                                                             delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [missingAlert show];

    }
    
    else{
    phnNmbr=_phnTxtField.text;
    username= _nameTxtField.text;
    location= _locationField.text;
    
        [self upadteUserDetails];}
    
}

-(void) uploadingExistingUserdetails{

    NSString *urlString = [NSString stringWithFormat:
                           @"https://www.yatramantra.com/kerala/usermanager/user/generate_auth_cookie/?username=%@&password=%@", mailID, pin];
    
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
                                     
                                       NSLog(@"new Details: %@", jsonDic);
                                       jsonDic3=[jsonDic valueForKey:@"user"];

                                    dispatch_async(dispatch_get_main_queue(), ^{
                                    _nameTxtField.placeholder=[jsonDic3 valueForKey:@"displayname"];
                                    
                                    });
                                   }
                               }
                               }];
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
