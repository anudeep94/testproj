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

@interface WhereToMapviewViewController ()<GMSMapViewDelegate>{
    UIView *markerInfoView;
    UIView *fakeView;
    UITapGestureRecognizer *outTap;
    int i,j;
    
}

@end

@implementation WhereToMapviewViewController
 GMSMapView *mapView;
UILabel *numChild;
UILabel *numAdult;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_fromLocation.coordinate.latitude
                                                            longitude:_fromLocation.coordinate.longitude
                                                                 zoom:8];
    
    mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view addSubview: mapView];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(_fromLocation.coordinate.latitude, _fromLocation.coordinate.longitude);
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(_toPlace.coordinate.latitude, _toPlace.coordinate.longitude);
    
    marker.title = _fromPlace.name;
    marker.userData = @"source";
    marker.map = mapView;
    marker2.title = _toPlace.name;
    marker2.userData = @"dest";
    marker2.map = mapView;
    mapView.delegate=self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } else if([marker.userData isEqualToString:@"dest"]){
    
//        UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 45)];
//        UIImageView *overView1 =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 45)];
//        [overView1 setBackgroundColor:[UIColor blackColor]];
//        overView1.alpha = 0.3;
//        markerInfoImage.image=[UIImage imageNamed:@"Pulikali.jpg"];
//        [markerInfoView addSubview:markerInfoImage];
//        [markerInfoImage addSubview:overView1];
//        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
//        markerInfoView.layer.masksToBounds = NO;
//        markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
//        markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//        markerInfoView.layer.shadowOpacity = 0.3f;
//        markerInfoView.layer.shadowPath = shadowPath.CGPath;
//        [myButton setTitle:@"Take a Snap" forState:UIControlStateNormal];
//        [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        [markerInfoView addSubview:myButton];
//        [moreButton setTitle:@"More" forState:UIControlStateNormal];
//        [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [markerInfoView addSubview:moreButton];
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoImage.frame.origin.x,markerInfoImage.frame.origin.y,markerInfoImage.frame.size.width,25)];
//        titleLabel.textColor = [UIColor whiteColor];
//        [markerInfoView addSubview:titleLabel];
//        titleLabel.textAlignment = NSTextAlignmentLeft;
//        titleLabel.text=@"Pulikali";
//        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.origin.x-20,markerInfoImage.frame.origin.y+45,markerInfoImage.frame.size.width-20,50)];
//        subtitleLabel.textColor = [UIColor whiteColor];
//        [markerInfoView addSubview:subtitleLabel];
//        subtitleLabel.font = [UIFont systemFontOfSize:13];
//        subtitleLabel.text=@"Event";
        
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
        [plusButton1 addTarget:self
                   action:@selector(addNum:)
         forControlEvents:UIControlEventTouchUpInside];
        [plusButton2 addTarget:self
                   action:@selector(addNum:)
         forControlEvents:UIControlEventTouchUpInside];
        [mButton1 addTarget:self
                   action:@selector(minusNum:)
         forControlEvents:UIControlEventTouchUpInside];
        [mButton2 addTarget:self
                   action:@selector(minusNum:)
         forControlEvents:UIControlEventTouchUpInside];
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
