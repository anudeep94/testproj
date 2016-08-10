//
//  OnedayTripViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 03/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "OnedayTripViewController.h"

#import "WhereToMapviewViewController.h"

@interface OnedayTripViewController ()<GMSAutocompleteViewControllerDelegate> {
    UIView *datePickerView;
    
}

@end
int flag=1;
int lim=0;
int tagFlag=0;



@implementation OnedayTripViewController
GMSPlacePicker *_placePicker;
NSString *pickedPlace;

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
    
    
    UIImage *img1 = [UIImage imageNamed:@"KL.jpg"];
    [_onedayBGImage setImage:img1];
    UIImage *img2= [UIImage imageNamed:@"Circled Right 2-50.png"];
    [_arrowImage setImage:img2];
    
    
    UIImage *img3 = [UIImage imageNamed:@"Car Filled-50.png"];
    [_modImage setImage:img3];
  //  [formatter release];
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"exploreSegue"]){
//        UINavigationController *navController = segue.destinationViewController;
//        WhereToMapviewViewController *controller =[navController childViewControllers].firstObject;
        WhereToMapviewViewController *controller = (WhereToMapviewViewController *)segue.destinationViewController;
        
        controller.toPlace=_toPlace;
        controller.fromPlace=_fromPlace;
        //controller.toSnippet=__
        controller.toLocation=_location2;
        controller.fromLocation=_location;
        
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
    if(viewController.view.tag ==121){
        [_fromButton setTitle: pickedPlace forState: UIControlStateNormal];tagFlag++;
        _fromPlace=place;
        //_fromSnippet=place.snippet;
//        _fromCoordinates.coordinate.latitude = place.coordinate.latitude ;
//        _fromCoordinates.coordinate.longitude = place.coordinate.longitude ;
        _location = [[CLLocation alloc] initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];

        
    }
    if(viewController.view.tag ==122){
        [_toButton setTitle: pickedPlace forState: UIControlStateNormal];tagFlag++;
        _toPlace=place;
        _location2 = [[CLLocation alloc] initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
        
    }
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
        
        datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height)];
        
    }
    else{
        datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 300)];}
    _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, datePickerView.frame.size.width, 250)];
    
    datePickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datePickerView];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.hidden = NO;
    _datePicker.date = [NSDate date];
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
    
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(datePickerView.frame.size.width/2,250,datePickerView.frame.size.width/2,50)];
    [datePickerView addSubview:myButton];
    [myButton setBackgroundColor:[UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00]];
    [myButton setTitle:@"Ok" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *myCancel = [[UIButton alloc] initWithFrame:CGRectMake(0,250,datePickerView.frame.size.width/2,50)];
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
    _dateLabel.text = [NSString stringWithFormat:@"%@",
                          [df stringFromDate:_datePicker.date]];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"EEE'\n'MMM/yy"];
    _monthLabel.text = [NSString stringWithFormat:@"%@",
                       [df1 stringFromDate:_datePicker.date]];

    
    
    
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
    
        [_dateLabel setText:[formatter stringFromDate:now]];
        [formatter setDateFormat: @"EEE\nMMM'/'yy"];
        [_monthLabel setText:[formatter stringFromDate:now]];
    [datePickerView removeFromSuperview];
}


@end
