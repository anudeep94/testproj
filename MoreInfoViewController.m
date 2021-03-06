//
//  MoreInfoViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 06/09/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "MoreInfoViewController.h"

@interface MoreInfoViewController (){
    NSDictionary *jsonDic;
    NSString *cookie;

}

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSLog(@"POI recieved : %@",_poiDetails);
    _poiTitleLabel.text=[NSString stringWithFormat:@"%@",[_poiDetails objectForKey:@"title"]];
    NSString *imageURL= [_poiDetails valueForKey:@"image"];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *urlContent = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:urlContent];
    [_poiImageView setImage:img];
    cookie=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
    [self getmoreInfoFromSite];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getmoreInfoFromSite{
    
    
    cookie=[[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"];
   /* NSString *urlString = [NSString stringWithFormat:
                           @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_moredetails&postid=%@&auth=%@",[_poiDetails objectForKey:@"id"],cookie];*/
//     NSString *percentEscapedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL *url = [[NSURL alloc] initWithString:percentEscapedString];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"error:%@", error.localizedDescription);
//                               }
//                               else{
//                                   NSError *error = nil;
//                                   jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                                   
//                                   if (error != nil) {
//                                       NSLog(@"Error parsing JSON.");
//                                   }
//                                   else {
//                                       NSLog(@"Response :%@",jsonDic);
//                                       }
//                                 
//                                   }
//                           }];
    
    NSString *strupload=[NSString stringWithFormat:@"postid=%@",[_poiDetails objectForKey:@"id"]];
    NSString *strurl=[NSString stringWithFormat:
                      @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_moredetails"];
    //NSString *strpostlength=[NSString stringWithFormat:@"%d",[strupload length]];
    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    
    [urlrequest setURL:[NSURL URLWithString:strurl]];
    [urlrequest setHTTPMethod:@"GET"];
    [urlrequest setValue:cookie forHTTPHeaderField:@"Authorization"];
    [urlrequest setHTTPBody:[strupload dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSError *error1;
         NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
         
         NSLog(@"POI INFO response: %@",res);
         
//         dispatch_async(dispatch_get_main_queue(), ^{
//             
//             
//         });
     }];
    
    
}



@end
