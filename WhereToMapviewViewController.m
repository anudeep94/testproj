//
//  WhereToMapviewViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 04/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "WhereToMapviewViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "OnedayTripViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "SWRevealViewController.h"

@interface WhereToMapviewViewController ()<GMSMapViewDelegate>{
    UIView *markerInfoView;
    UIView *fakeView;
    UITapGestureRecognizer *outTap;
    int i,j;
    GMSMapView *mapView;
    UILabel *numChild;
    UILabel *numAdult;
    NSDictionary *poiDic, *poiDic2;
    NSArray *jsonDic;
    GMSMarker *markerSource, *markerDest;
    NSString *imageURL;
    
}

@end

@implementation WhereToMapviewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

   
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_fromLocation.coordinate.latitude
                                                            longitude:_fromLocation.coordinate.longitude
                                                                 zoom:9];
    mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];//old code #
    mapView.camera = camera;
    mapView.myLocationEnabled = YES;
    [self.view addSubview: mapView];
    
    // Creates a marker in the center of the map.
    markerSource = [[GMSMarker alloc] init];
    markerSource.position = CLLocationCoordinate2DMake(_fromLocation.coordinate.latitude, _fromLocation.coordinate.longitude);
    markerSource.icon = [UIImage imageNamed:@"soruceIcon"];
    markerDest = [[GMSMarker alloc] init];
    markerDest.position = CLLocationCoordinate2DMake(_toPlace.coordinate.latitude, _toPlace.coordinate.longitude);
    
    markerSource.title = _fromPlace.name;
    markerSource.userData = @"source";
    markerSource.map = mapView;
    markerDest.title = _toPlace.name;
    markerDest.userData = @"dest";
    
    //marker2.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
    markerDest.icon = [UIImage imageNamed:@"destIcon"];
    markerDest.map = mapView;
    mapView.delegate=self;
    
    
    //////**********Drawing PolyLines **************//////
    
    
    //overview_polyline_string
    
    NSString *pathString =[[NSUserDefaults standardUserDefaults] objectForKey:@"overview_polyline_string"];
    GMSPath *path = [GMSPath pathFromEncodedPath:pathString];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 6.f;
    polyline.spans = @[[GMSStyleSpan spanWithColor:[UIColor colorWithRed:0.000 green:0.702 blue:0.992 alpha:1.00]]];
    polyline.geodesic = YES;
    polyline.map = mapView;
    
    poiDic2=[[NSUserDefaults standardUserDefaults] objectForKey:@"POI"];
    
    
    [self getPointsOfInterests];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getPointsOfInterests{

    NSString *urlString = [NSString stringWithFormat:
                           @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=dayplanlist&lat=7.55&long=77.55"];
    
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
                                       NSLog(@"POI data : %@",jsonDic);
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           for (poiDic in jsonDic) {
                                               
                                               
                                                   
                                               [[NSUserDefaults standardUserDefaults] setObject:poiDic forKey:@"POI"];
                                               GMSMarker *poiMarker=    [[GMSMarker alloc] init];
                                               NSString *poiLatString= [poiDic objectForKey:@"lat"];
                                               NSString *poiLongString=[poiDic objectForKey:@"long"];
                                               CLLocationCoordinate2D pinlocation;
                                               pinlocation.latitude = [poiLatString doubleValue];
                                               pinlocation.longitude =[poiLongString doubleValue];
                                               //poiMarker.position =  CLLocationCoordinate2DMake(pinlocation.latitude, pinlocation.longitude);
                                               CLLocation *positionPin=[[CLLocation alloc] initWithLatitude:pinlocation.latitude longitude:pinlocation.longitude];
                                               NSString *type = [poiDic  objectForKey:@"type"];
                                               
//                                               if ([poiMarker.userData isEqualToString:@""])
//                                               {
                                               
                                               
                                               poiMarker.position =  CLLocationCoordinate2DMake(pinlocation.latitude, pinlocation.longitude);
                                               
                                               CLLocation *fromLocation = [[CLLocation alloc] initWithLatitude:_fromPlace.coordinate.latitude longitude:_fromPlace.coordinate.longitude];
                                               float distance = [fromLocation distanceFromLocation:positionPin];
                                               float threshold = 50; // Or whatever you like
                                               if(distance <= threshold) {
                                                   // You are at the bonus location.
                                                   poiMarker.position =  CLLocationCoordinate2DMake(pinlocation.latitude+.0001, pinlocation.longitude);                                               }
                                               CLLocation *toLocation = [[CLLocation alloc] initWithLatitude:_toPlace.coordinate.latitude longitude:_toPlace.coordinate.longitude];
                                               distance = [toLocation distanceFromLocation:positionPin];
                                               if(distance <= threshold) {
                                                   // You are at the bonus location.
                                                   poiMarker.position =  CLLocationCoordinate2DMake(pinlocation.latitude+.0001, pinlocation.longitude);
                                               }
                                               
                                               if([type isEqualToString:@"place"]){
                                               
                                                   poiMarker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
                                                   poiMarker.map = mapView;
                                                   poiMarker.userData=type;

                                               }
                                              else if([type isEqualToString:@"event"])
                                               {
                                                   poiMarker.icon = [GMSMarker markerImageWithColor:[UIColor orangeColor]];
                                                   poiMarker.map = mapView;
                                                   poiMarker.userData=type;
                                                   
                                               }
                                              else if ([type isEqualToString:@"activity"]){
                                                  poiMarker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
                                                  poiMarker.map = mapView;
                                                  poiMarker.userData=type;
                                              }
                                               
                                               }
                                              // poiMarker.icon = [poiMarker.icon scaledToSize:CGSizeMake(3.0f, 3.0f)];
                                                                                             //poiMarker.icon = [self image:poiMarker.icon scaledToSize:CGSizeMake(10.0f, 10.0f)];
                                        
                                           //}
                                           
                                           
                                    });
                                   }
                               }
                           }];
}


//////***************Method to scale image*****************//

- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

-(void)tapped:(UITapGestureRecognizer*) sender
{
    [fakeView removeFromSuperview];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if(screenBounds.size.height==480)
    {
        //CGRect markerInfoViewFrame;
        
        markerInfoView = [[UIView alloc] initWithFrame:CGRectMake(90, 150, 150, 150)];
        
    }
    else{
        markerInfoView = [[UIView alloc] initWithFrame:CGRectMake(40, 200, 300, 300)];
        markerInfoView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        fakeView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:fakeView];
        [fakeView addSubview:markerInfoView];
        [fakeView addGestureRecognizer:tapGesture];
        UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(markerInfoView.frame.size.width/2,250,markerInfoView.frame.size.width/2,45)];
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0,250,markerInfoView.frame.size.width/2,45)];
    
    
        if ([marker.userData isEqualToString:@"source"])
        {
            UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 90)];
            UIImageView *overView2 =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 90)];
            [overView2 setBackgroundColor:[UIColor blackColor]];
            overView2.alpha = 0.3;
            markerInfoImage.image=[UIImage imageNamed:@"KL.jpg"];
            [markerInfoView addSubview:markerInfoImage];
            [markerInfoImage addSubview:overView2];
            UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
            markerInfoView.layer.masksToBounds = NO;
            markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
            markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
            markerInfoView.layer.shadowOpacity = 0.3f;
            markerInfoView.layer.shadowPath = shadowPath.CGPath;
   
            [myButton setTitle:@"Add to Trip" forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:myButton];
            [moreButton setTitle:@"More" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:moreButton];
            UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,205,markerInfoView.frame.size.width,45)];
            [markerInfoView addSubview:infoLabel];
            infoLabel.textAlignment = NSTextAlignmentRight;
            infoLabel.textColor = [UIColor darkGrayColor];
            infoLabel.font = [UIFont systemFontOfSize:16];
            infoLabel.text=@"Opening Time 6am";
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x -20,markerInfoImage.frame.origin.y+20,markerInfoImage.frame.size.width-20,25)];
            titleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:titleLabel];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.text=@"Kerala";
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x-20,markerInfoImage.frame.origin.y+45,markerInfoImage.frame.size.width-20,50)];
            subtitleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:subtitleLabel];
            subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            subtitleLabel.text=@"4 Days Recommended";
        }
    else if([marker.userData isEqualToString:@"dest"]){
    
//          UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 45)];
//          UIImageView *overView1 =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 45)];
//          [overView1 setBackgroundColor:[UIColor blackColor]];
//          overView1.alpha = 0.3;
//          markerInfoImage.image=[UIImage imageNamed:@"Pulikali.jpg"];
//          [markerInfoView addSubview:markerInfoImage];
//          [markerInfoImage addSubview:overView1];
//          UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
//          markerInfoView.layer.masksToBounds = NO;
//          markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
//          markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//          markerInfoView.layer.shadowOpacity = 0.3f;
//          markerInfoView.layer.shadowPath = shadowPath.CGPath;
//          [myButton setTitle:@"Take a Snap" forState:UIControlStateNormal];
//          [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//          [markerInfoView addSubview:myButton];
//          [moreButton setTitle:@"More" forState:UIControlStateNormal];
//          [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//          [markerInfoView addSubview:moreButton];
//          UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoImage.frame.origin.x,markerInfoImage.frame.origin.y,markerInfoImage.frame.size.width,25)];
//          titleLabel.textColor = [UIColor whiteColor];
//          [markerInfoView addSubview:titleLabel];
//          titleLabel.textAlignment = NSTextAlignmentLeft;
//          titleLabel.text=@"Pulikali";
//          UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x-20,markerInfoImage.frame.origin.y+45,markerInfoImage.frame.size.width-20,50)];
//          subtitleLabel.textColor = [UIColor whiteColor];
//          [markerInfoView addSubview:subtitleLabel];
//          subtitleLabel.font = [UIFont systemFontOfSize:13];
//          subtitleLabel.text=@"Event";
        
        //New PopUP
            UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 115)];
            UIImageView *overView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 115)];
            [overView setBackgroundColor:[UIColor blackColor]];
            overView.alpha = 0.3;
            markerInfoImage.image=[UIImage imageNamed:@"KL.jpg"];
            [markerInfoView addSubview:markerInfoImage];
            [markerInfoImage addSubview:overView];
            numChild = [[UILabel alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-40, 230, 25, 25)];
            numChild.text=@"0";
            [markerInfoView addSubview:numChild];
            numChild.textColor=[UIColor lightGrayColor];
            UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
            markerInfoView.layer.masksToBounds = NO;
            markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
            markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
            markerInfoView.layer.shadowOpacity = 0.3f;
            markerInfoView.layer.shadowPath = shadowPath.CGPath;
            numAdult = [[UILabel alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+70, 230, 25, 25)];
            numAdult.text=@"0";
            [markerInfoView addSubview:numAdult];
            numAdult.textColor=[UIColor lightGrayColor];
            numAdult.textAlignment = NSTextAlignmentCenter;
            numChild.textAlignment = NSTextAlignmentCenter;
            UIImageView *numChildImage =[[UIImageView alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-42, 200, 30, 30)];
            UIImageView *numadultImage =[[UIImageView alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+68, 200, 30, 30)];
            numChildImage.image=[UIImage imageNamed:@"child"];
            numadultImage.image=[UIImage imageNamed:@"adult"];
            [markerInfoView addSubview:numadultImage];
            [markerInfoView addSubview:numChildImage];
            UILabel *seperator = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.size.width/2, 203,1, 47)];
            [seperator setBackgroundColor:[UIColor colorWithRed:0.937 green:0.941 blue:0.945 alpha:1.00]];
            [markerInfoView addSubview:seperator];
            UIButton *plusButton1 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-15, 232, 20, 20)];
            UIButton *mButton1 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-65, 232, 20, 20)];
            UIButton *plusButton2 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+95, 232, 20, 20)];
            UIButton *mButton2 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+45, 232, 20, 20)];
            [plusButton1 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
            [mButton1 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
            [plusButton2 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
            [mButton2 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
            [markerInfoView addSubview:plusButton1];
            [markerInfoView addSubview:mButton1];
            [markerInfoView addSubview:plusButton2];
            [markerInfoView addSubview:mButton2];
            plusButton1.tag=111;
            plusButton2.tag=333;
            mButton1.tag=222;
            mButton2.tag=444;
            [myButton setTitle:@"Book Now" forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:myButton];
            [moreButton setTitle:@"More" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:moreButton];
            [plusButton1 addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
            [plusButton2 addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
            [mButton1 addTarget:self action:@selector(minusNum:) forControlEvents:UIControlEventTouchUpInside];
            [mButton2 addTarget:self action:@selector(minusNum:) forControlEvents:UIControlEventTouchUpInside];
            plusButton1.alpha=0.05f;
            mButton1.alpha=0.05f;
            plusButton2.alpha=0.05f;
            mButton2.alpha=0.05f;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x -20,markerInfoImage.frame.origin.y+20,markerInfoImage.frame.size.width-20,25)];
            titleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:titleLabel];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.text=@"Kerala";
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x-20,markerInfoImage.frame.origin.y+45,markerInfoImage.frame.size.width-20,50)];
            subtitleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:subtitleLabel];
            subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            subtitleLabel.numberOfLines = 0;
            subtitleLabel.text=@"₹300/Head\nActivites";
        
            }
        else if ([marker.userData isEqualToString:@"place"]){
            
        
            }
        else if ([marker.userData isEqualToString:@"event"]){
            
            
        }

        else if ([marker.userData isEqualToString:@"activity"]){
            
            UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 115)];
            UIImageView *overView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 115)];
            [overView setBackgroundColor:[UIColor blackColor]];
            overView.alpha = 0.3;
            //markerInfoImage.image=[UIImage imageNamed:@"KL.jpg"];
            imageURL= [poiDic2 valueForKey:@"img"];
            NSURL *url = [NSURL URLWithString:imageURL];
            NSData *urlContent = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:urlContent];
            //[_bgImageView setImage:img];
            [markerInfoImage setImage:img];

            [markerInfoView addSubview:markerInfoImage];
            [markerInfoImage addSubview:overView];
            numChild = [[UILabel alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-40, 230, 25, 25)];
            numChild.text=@"0";
            [markerInfoView addSubview:numChild];
            numChild.textColor=[UIColor lightGrayColor];
            UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
            markerInfoView.layer.masksToBounds = NO;
            markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
            markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
            markerInfoView.layer.shadowOpacity = 0.3f;
            markerInfoView.layer.shadowPath = shadowPath.CGPath;
            numAdult = [[UILabel alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+70, 230, 25, 25)];
            numAdult.text=@"0";
            [markerInfoView addSubview:numAdult];
            numAdult.textColor=[UIColor lightGrayColor];
            numAdult.textAlignment = NSTextAlignmentCenter;
            numChild.textAlignment = NSTextAlignmentCenter;
            UIImageView *numChildImage =[[UIImageView alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-42, 200, 30, 30)];
            UIImageView *numadultImage =[[UIImageView alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+68, 200, 30, 30)];
            numChildImage.image=[UIImage imageNamed:@"child"];
            numadultImage.image=[UIImage imageNamed:@"adult"];
            [markerInfoView addSubview:numadultImage];
            [markerInfoView addSubview:numChildImage];
            UILabel *seperator = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.size.width/2, 203,1, 47)];
            [seperator setBackgroundColor:[UIColor colorWithRed:0.937 green:0.941 blue:0.945 alpha:1.00]];
            [markerInfoView addSubview:seperator];
            UIButton *plusButton1 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-15, 232, 20, 20)];
            UIButton *mButton1 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/3)-65, 232, 20, 20)];
            UIButton *plusButton2 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+95, 232, 20, 20)];
            UIButton *mButton2 = [[UIButton alloc] initWithFrame:CGRectMake((markerInfoView.frame.size.width/2)+45, 232, 20, 20)];
            [plusButton1 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
            [mButton1 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
            [plusButton2 setBackgroundImage:[UIImage imageNamed:@"ForwardArrow"] forState:UIControlStateNormal];
            [mButton2 setBackgroundImage:[UIImage imageNamed:@"BackArrow"] forState:UIControlStateNormal];
            [markerInfoView addSubview:plusButton1];
            [markerInfoView addSubview:mButton1];
            [markerInfoView addSubview:plusButton2];
            [markerInfoView addSubview:mButton2];
            plusButton1.tag=111;
            plusButton2.tag=333;
            mButton1.tag=222;
            mButton2.tag=444;
            [myButton setTitle:@"Book Now" forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:myButton];
            [moreButton setTitle:@"More" forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [markerInfoView addSubview:moreButton];
            [plusButton1 addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
            [plusButton2 addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
            [mButton1 addTarget:self action:@selector(minusNum:) forControlEvents:UIControlEventTouchUpInside];
            [mButton2 addTarget:self action:@selector(minusNum:) forControlEvents:UIControlEventTouchUpInside];
            plusButton1.alpha=0.05f;
            mButton1.alpha=0.05f;
            plusButton2.alpha=0.05f;
            mButton2.alpha=0.05f;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x -20,markerInfoImage.frame.origin.y+20,markerInfoImage.frame.size.width-20,25)];
            titleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:titleLabel];
            titleLabel.textAlignment = NSTextAlignmentLeft;
           // titleLabel.text=@"Kerala";
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x-20,markerInfoImage.frame.origin.y+45,markerInfoImage.frame.size.width-20,50)];
            subtitleLabel.textColor = [UIColor whiteColor];
            [markerInfoView addSubview:subtitleLabel];
            subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            subtitleLabel.numberOfLines = 0;
           // subtitleLabel.text=@"₹300/Head\nActivites";
            
        }

    }
    
    
    return YES;
}

-(void)addNum:(UIButton*) sender
{
    if(sender.tag ==111)
    {i++;
        numChild.text= [NSString stringWithFormat:@"%d",i ];
    }
    if (sender.tag ==333) {
        j++;
        numAdult.text= [NSString stringWithFormat:@"%d",j ];
    }
    
    
}
-(void)minusNum:(UIButton*) sender
{
    if(i>0 ){
    if(sender.tag ==222)
    {i--;
        numChild.text= [NSString stringWithFormat:@"%d",i ];
    }}
     if(j>0 )
    if (sender.tag ==444) {
        j--;
        numAdult.text= [NSString stringWithFormat:@"%d",j ];
    }
    
}



@end
