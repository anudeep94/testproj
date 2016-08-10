//
//  WhereToMapviewViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 04/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@import GooglePlacePicker;
#import <GooglePlaces/GooglePlaces.h>



@interface WhereToMapviewViewController : UIViewController
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic) GMSPlace *fromPlace;
@property(nonatomic)GMSPlace *toPlace;
@property (nonatomic)CLLocation *fromLocation;
@property (nonatomic)CLLocation *toLocation;
@property(nonatomic) NSString *fromSnippet;
@property(nonatomic)NSString *toSnippet;
@property(nonatomic) GMSPlace *place;



@end
