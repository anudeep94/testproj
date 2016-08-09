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
}

@end

@implementation WhereToMapviewViewController
 GMSMapView *mapView;

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
    marker.title = _fromPlace.name;
    //marker.snippet = _fromPlace.formattedAddress;
    marker.map = mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(_toPlace.coordinate.latitude, _toPlace.coordinate.longitude);
    marker2.title = _toPlace.name;
    //marker2.snippet = _toPlace.formattedAddress;
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
        markerInfoView = [[UIView alloc] initWithFrame:CGRectMake(40, 200, 300, 300)];}
    markerInfoView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    fakeView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:fakeView];
    [fakeView addSubview:markerInfoView];
    [fakeView addGestureRecognizer:tapGesture];
    
    UIImageView *markerInfoImage =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,markerInfoView.frame.size.width,markerInfoView.frame.size.height - 90)];
    markerInfoImage.image=[UIImage imageNamed:@"KL.jpg"];
    [markerInfoView addSubview:markerInfoImage];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:markerInfoView.bounds];
    markerInfoView.layer.masksToBounds = NO;
    markerInfoView.layer.shadowColor = [UIColor blackColor].CGColor;
    markerInfoView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    markerInfoView.layer.shadowOpacity = 0.3f;
    markerInfoView.layer.shadowPath = shadowPath.CGPath;
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(markerInfoView.frame.size.width/2,250,markerInfoView.frame.size.width/2,45)];
    [myButton setTitle:@"Add to Trip" forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [markerInfoView addSubview:myButton];
    
    
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0,250,markerInfoView.frame.size.width/2,45)];
    [moreButton setTitle:@"More" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [markerInfoView addSubview:moreButton];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoView.frame.size.width/2,295,markerInfoView.frame.size.width,45)];
    infoLabel.textAlignment = NSTextAlignmentRight;
    infoLabel.textColor = [UIColor darkGrayColor];
    infoLabel.text=@"Opening Time 6am";
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoImage.frame.origin.x,markerInfoImage.frame.origin.y,50,45)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text=@"Kerala";
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markerInfoImage.frame.origin.x,markerInfoImage.frame.origin.y+50,70,45)];
    subtitleLabel.textColor = [UIColor blackColor];
    subtitleLabel.text=@"4 Days Recommended";
    
    
    return YES;
}
@end
