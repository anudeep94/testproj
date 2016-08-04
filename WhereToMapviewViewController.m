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

@interface WhereToMapviewViewController ()

@end

@implementation WhereToMapviewViewController
 GMSMapView *mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = _fromPlace;
    marker.snippet = _fromPlace;
    marker.map = mapView;
    
//    GMSMarker *marker2 = [[GMSMarker alloc] init];
//    marker2.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker2.title = @"Sydney";
//    marker2.snippet = @"Australia";
//    marker2.map = mapView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
