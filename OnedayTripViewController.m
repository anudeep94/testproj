//
//  OnedayTripViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 03/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OnedayTripViewController.h"

#import "WhereToMapviewViewController.h"
#import "OverViewTableViewController.h"

@interface OnedayTripViewController ()<GMSAutocompleteViewControllerDelegate> {
    UIView *datePickerView;
    GMSPlacePicker *_placePicker;
    NSString *pickedPlace;
    NSString *pickedPlace2;
    UILabel* smallDate;
    NSString *toAddress, *fromAddress;
    NSDictionary* jsonDic;
    UIButton *myCancel, *myButton;
    
    
    
}

@end
int flag=1;
int lim=0;
int tagFlag=0;



@implementation OnedayTripViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    NSDate *now = [NSDate date];
//    NSDateFormatter *formatter = nil;
//    formatter = [[NSDateFormatter alloc] init];
//    //[formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setDateFormat:@"d"];
//    
//    [_dateLabel setText:[formatter stringFromDate:now]];
//    [formatter setDateFormat: @"EEE\nMMM'/'yy"];
//    [_monthLabel setText:[formatter stringFromDate:now]];
    
    
    smallDate=[[UILabel alloc] init];
    
    NSData *urlContent = [[NSUserDefaults standardUserDefaults] objectForKey:@"PCImageURL"];
    UIImage *img = [[UIImage alloc] initWithData:urlContent];
    [_onedayBGImage setImage:img];
    UIImage *img2= [UIImage imageNamed:@"Circled Right 2-50.png"];
    [_arrowImage setImage:img2];
    
    
    UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    [_modImage setImage:img3];
  //  [formatter release];
    
    NSDictionary *fromloc=[[NSUserDefaults standardUserDefaults] objectForKey:@"StartLocation"];
    NSLog(@"StartLocation = %@",fromloc);
    
    
    NSLog(@"CHUMMA : %@",_chummaTest);
    
    
//    CLLocation *fromLat=[[CLLocation alloc]init];
//    NSData *coordinate=[fromloc objectForKey:@"lat"];
   // fromLat.coordinate.latitude= [[CLLocation alloc] initWithLatitude:coordinate longitude:-36.6462520];
//    fromLat.coordinate.latitude=coordinate;
//    fromLat.coordinate.longitude=[fromloc objectForKey:@"lng"];
//    NSString *value =[NSString stringWithFormat:@"Kochi"/*@"0x00007fbfa1c2fdd0"*/];
//    NSString* value2=@"Thrissur";
//    [_fromButton setTitle: value forState: UIControlStateNormal];
//    [_toButton setTitle: value2 forState: UIControlStateNormal];
//    NSData *placeNSData=[[NSUserDefaults standardUserDefaults]objectForKey:@"Sour"];
//    GMSPlace *defultFrom =[NSKeyedUnarchiver unarchiveObjectWithData:placeNSData];
//    placeNSData=[[NSUserDefaults standardUserDefaults] objectForKey:@"Dest"];
//    GMSPlace *defultTo=[NSKeyedUnarchiver unarchiveObjectWithData:placeNSData];
//    
//    [_fromButton setTitle: defultFrom.name forState: UIControlStateNormal];
//    [_toButton setTitle:defultTo.name forState: UIControlStateNormal];
//    if((defultTo != nil) || (defultFrom !=nil)){tagFlag=2;
//    [self fetchDistanceFromGoogleAPI];
//    }
    
    
    if ([_monthLabel.text isEqualToString:@"MM/YY"]) {
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = nil;
        formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setDateFormat:@"d"];
        
        [_dateLabel setText:[formatter stringFromDate:now]];
        [formatter setDateFormat: @"EEE\nMMM'/'yy"];
        [_monthLabel setText:[formatter stringFromDate:now]];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressPlan:(id)sender {
    if (tagFlag>1) {
        [self performSegueWithIdentifier:@"exploreSegue" sender:nil];
    }
    else{
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Did not select Preferd Places!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    

    
    [self googleMapRouteDrawing];
    
    
    
    
}

-(void) googleMapRouteDrawing{

    NSString *urlString = [NSString stringWithFormat:
                           @"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@",pickedPlace2,pickedPlace];
    
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
                                       NSLog(@"MapRoute data : %@",jsonDic);
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           
                                        NSArray *routeArray =[jsonDic objectForKey:@"routes"];
                                        NSDictionary *innerDict= [routeArray objectAtIndex:0];
                                        NSDictionary *overViewPolyLine= [innerDict objectForKey:@"overview_polyline"];
                                        NSLog(@"poyline String :%@",overViewPolyLine);
                                                             
                                        NSString *polyLineString =[overViewPolyLine objectForKey:@"points"];
                                        [[NSUserDefaults standardUserDefaults] setObject:polyLineString forKey:@"overview_polyline_string"]; ////
                                           
                                       });
                                   }
                               }
                           }];





}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"exploreSegue"]){
//        UINavigationController *navController = segue.destinationViewController;
//        WhereToMapviewViewController *controller =[navController childViewControllers].firstObject;
        UITabBarController *tabBarController = (UITabBarController *)segue.destinationViewController;
        WhereToMapviewViewController *controller= tabBarController.viewControllers[0];
        controller.toPlace=_toPlace;
        controller.fromPlace=_fromPlace;
        //controller.toSnippet=__
        controller.toLocation=_location2;
        controller.fromLocation=_location;
        controller.fromAddress=fromAddress;
        controller.toAddress=toAddress;
        
        OverViewTableViewController *controller1= tabBarController.viewControllers[1];
        controller1.fromDateLabel=_dateLabel;
        controller1.fromMonthLabel=_monthLabel;
        controller1.toDateLabel=_dateLabel;
        controller1.toMonthLabel= _monthLabel;
        controller1.toPlace=pickedPlace;
        controller1.fromPlace=pickedPlace2;
        controller1.smallDateLabel=smallDate;
        
        
        
    }
}


- (IBAction)travelModeNxt:(id)sender {
    //UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    UIImage *img4 = [UIImage imageNamed:@"Train Filled-50.png"];
    UIImage *img5 = [UIImage imageNamed:@"Airplane Mode On Filled-50.png"];
    lim++;
    if (lim<4 && lim > 0) {
        flag++;
//        if (flag==1) {
//            [_modImage setImage:img3];
//        }
        /*else*/ if (flag==2) {
            [_modImage setImage:img4];
        }
        else if(flag==3)
        {
            [_modImage setImage:img5];
        }
    }
    else{
        lim=3;flag=3;
        [_modImage setImage:img5];
    }
    
}
- (IBAction)travelModePrvs:(id)sender {
    
    UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    UIImage *img4 = [UIImage imageNamed:@"Train Filled-50.png"];
    UIImage *img5 = [UIImage imageNamed:@"Airplane Mode On Filled-50.png"];
    lim--;
    if (lim<4 && lim > 0) {
        flag--;
        if (flag==1) {
            [_modImage setImage:img3];
        }
        else if (flag==2) {
            [_modImage setImage:img4];
        }
        else if(flag==3)
        {
            [_modImage setImage:img5];
        }
    }
    else {
    
        lim=1;flag=1;
        [_modImage setImage:img3];
    }

}
- (IBAction)startPressed:(id)sender {
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    acController.view.tag=_fromButton.tag;
    [self presentViewController:acController animated:YES completion:nil];
}


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    pickedPlace= place.name;
//    NSData *placeNSData = [NSKeyedArchiver archivedDataWithRootObject:place];
//    [[NSUserDefaults standardUserDefaults] setObject:placeNSData forKey:@"Sour"];
    if(viewController.view.tag ==121){
        
        [_fromButton setTitle: pickedPlace forState: UIControlStateNormal];
        tagFlag++;
        _fromPlace=place;
        fromAddress=place.formattedAddress;
        pickedPlace2=pickedPlace;
        _location = [[CLLocation alloc] initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];

        
    }
    if(viewController.view.tag ==122){
        [_toButton setTitle: pickedPlace forState: UIControlStateNormal];
        tagFlag++;
        _toPlace=place;
//        NSData *placeNSData = [NSKeyedArchiver archivedDataWithRootObject:place];
//        [[NSUserDefaults standardUserDefaults] setObject:placeNSData forKey:@"Dest"];
        toAddress=place.formattedAddress;
        _location2 = [[CLLocation alloc] initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
        [self fetchDistanceFromGoogleAPI];
        
    }
}

-(void) fetchDistanceFromGoogleAPI{

    NSString *urlString = [NSString stringWithFormat:
                           @"http://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&language=en-EN&sensor=false",pickedPlace2, pickedPlace];
    
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
                                       
                                       NSLog(@" Travel Details: %@", jsonDic);
                                       [[NSUserDefaults standardUserDefaults] setObject:jsonDic forKey:@"TravelDetailsDic"];
                                       NSArray *dicKeys= [jsonDic allKeys];
                                       NSLog(@"keys :%@",dicKeys);
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                               if (jsonDic) {
                                               NSArray *extraData = jsonDic[@"rows"];
                                               for (NSDictionary *innerDict in extraData) {

                                                       NSArray *valueStr = innerDict[@"elements"];
                                                        for (NSDictionary *elementDic in valueStr) {
                                                       NSDictionary *distanceDic=[elementDic objectForKey:@"distance"];
                                                       NSLog(@"DistanceDic : %@",distanceDic);
                                                        [[NSUserDefaults standardUserDefaults] setObject:distanceDic forKey:@"DistanceDic"];
                                                       NSDictionary *durationDic= [elementDic objectForKey:@"duration"];
                                                        NSLog(@"DurationDic : %@",durationDic);
                                                        [[NSUserDefaults standardUserDefaults] setObject:durationDic forKey:@"DurationDic"];
                                                            _travelTimeLabel.text=[durationDic objectForKey:@"text"];
                                                            _travelDistanceLabel.text=[distanceDic objectForKey:@"text"];
                                                            
                                                   }
                                               }
                                           }
                                       });
                                   }
                               }
                           }];

}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (IBAction)destPressed:(id)sender {
    
    
    GMSAutocompleteViewController *aCController = [[GMSAutocompleteViewController alloc] init];
    aCController.delegate = self;
    aCController.view.tag=_toButton.tag;
    [self presentViewController:aCController animated:YES completion:nil];
    
}

- (IBAction)calenderPressed:(id)sender {
   // UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if(screenBounds.size.height==480)
    {
        //CGRect markerInfoViewFrame;
        
        datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height)];
        myCancel = [[UIButton alloc] initWithFrame:CGRectMake(0,250,datePickerView.frame.size.width/2,50)];
        myButton = [[UIButton alloc] initWithFrame:CGRectMake(datePickerView.frame.size.width/2,250,datePickerView.frame.size.width/2,50)];
        
        
    }
    else{
        datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 300)];
        myCancel = [[UIButton alloc] initWithFrame:CGRectMake(0,250,datePickerView.frame.size.width/2,50)];
        myButton = [[UIButton alloc] initWithFrame:CGRectMake(datePickerView.frame.size.width/2,250,datePickerView.frame.size.width/2,50)];
    
    }
    _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, datePickerView.frame.size.width, 250)];
    
    datePickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datePickerView];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.hidden = NO;
    _datePicker.date = [NSDate date];
    [_datePicker setMinimumDate: [NSDate date]];
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    [_datePicker clipsToBounds];
    
    [_datePicker addTarget:self
                   action:@selector(labelChange:)
         forControlEvents:UIControlEventValueChanged];
    [datePickerView addSubview:_datePicker]; //this can set value of selected date to your label change according to your condition
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"]; // from here u can change format..
    _dateLabel.text=[df stringFromDate:_datePicker.date];
//    _rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
//    self.navigationItem.rightBarButtonItem=_rightBtn;
    
    
    [datePickerView addSubview:myButton];
    [myButton setBackgroundColor:[UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00]];
    [myButton setTitle:@"Ok" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [datePickerView addSubview:myCancel];
    [myCancel setBackgroundColor:[UIColor whiteColor]];
    [myCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [myCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [myCancel addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)labelChange:(id)sender
{ //UIDatePicker *datePicker = [[UIDatePicker alloc] init];

   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"d"];
    _dateLabel.text = [NSString stringWithFormat:@"%@",[df stringFromDate:_datePicker.date]];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"EEE'\n'MMM/yy"];
    _monthLabel.text = [NSString stringWithFormat:@"%@",[df1 stringFromDate:_datePicker.date]];
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"d MMM"];
    smallDate.text = [NSString stringWithFormat:@"%@",[df2 stringFromDate:_datePicker.date]];
    tagFlag++;
    
}
-(void)save:(id)sender
{   //UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //self.navigationItem.rightBarButtonItem=nil;
    
    [datePickerView removeFromSuperview];
    //[_keyboardToolbar removeFromSuperview];
}
-(void) cancelPressed:(id)sender
{
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = nil;
        formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setDateFormat:@"d"];
        tagFlag++;
    
        [_dateLabel setText:[formatter stringFromDate:now]];
        [formatter setDateFormat: @"EEE\nMMM'/'yy"];
        [_monthLabel setText:[formatter stringFromDate:now]];
    [datePickerView removeFromSuperview];
}


@end
