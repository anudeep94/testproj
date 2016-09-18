//
//  ProfileViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 22/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController ()<UITextViewDelegate>{

    UIView  *fakeView;
    NSString *rateSelected;
    int flag;
    NSString *cookie, *message;
    
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    flag=0;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    _rateView.hidden=YES;
    cookie=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
    _feedbackTextView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }


- (IBAction)ratePressed:(id)sender {
    
    _rateView.hidden=NO;
    UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    fakeView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:fakeView];
    [fakeView addSubview:_rateView];
    [fakeView addGestureRecognizer:tapGesture];
//    _rateView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    
}
- (IBAction)excePressed:(id)sender {
    rateSelected =[_exceButton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
     [fakeView removeFromSuperview];
    
}
- (IBAction)goodPressed:(id)sender {
    rateSelected =[_goodButton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
     [fakeView removeFromSuperview];
}
- (IBAction)satPressed:(id)sender {
    rateSelected =[_satButton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
    [fakeView removeFromSuperview];
}
- (IBAction)notBadPressed:(id)sender {
    rateSelected =[_notBadButton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
     [fakeView removeFromSuperview];
}
- (IBAction)needPresssed:(id)sender {
    rateSelected =[_needBUtton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
     [fakeView removeFromSuperview];
}
- (IBAction)otherPressed:(id)sender {

    rateSelected =[_otherButton titleForState:UIControlStateNormal];
    [_ratingButton setTitle: rateSelected forState: UIControlStateNormal];
    flag++;
    [fakeView removeFromSuperview];
    
}
- (IBAction)sentPressed:(id)sender {
    
    if (flag==0) {
        UIAlertView *rateAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                            message:@"Forgot to enter Rating/message"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [rateAlert show];
    }
    else
    {
     flag=0;
        message=_feedbackTextView.text;
        NSString *strupload=[NSString stringWithFormat:@"sub=%@&msg=%@&type=feedback",rateSelected, message];
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
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [_ratingButton setTitle: @"Rate" forState: UIControlStateNormal];
             _feedbackTextView.text=@"";
             UIAlertView *feedbackAlert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                     message:@"FeedBack sent.\n Thank You"
                                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [feedbackAlert show];
             
              });
         }];
        
        
        }

    
}

-(void)tapped:(UITapGestureRecognizer*) sender
{
    
    [fakeView removeFromSuperview];
}


@end
