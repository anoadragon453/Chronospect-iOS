//
//  PostLocationViewController.h
//  Chronospect
//
//  Created by Andrew Morgan on 6/3/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface PostLocationViewController : UIViewController <GMSMapViewDelegate>

@property(nonatomic,retain) CLLocationManager *locationManager;

@end
