//
//  PostLocationViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 6/3/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "PostLocationViewController.h"

@interface PostLocationViewController ()

@end

@implementation PostLocationViewController {
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get Current Location
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    [locationManager startUpdatingLocation];
    
     NSLog(@"User's lat/long is %f,%f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    
    // Google Maps Setup
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    /*UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    lpgr.minimumPressDuration = 0.3;
    
    //user needs to press for 2 seconds
    [mapView_ addGestureRecognizer:lpgr];*/
}

-(void) mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = coordinate;
    marker3.title = @"170 Asbury Anderson Rd";
    marker3.snippet = @"US";
    marker3.map = mapView_;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    return theLocation;
}

/*-(void)longPress: (UIGestureRecognizer*)sender
{
    NSLog(@"Long Press!");
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(10, 10);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"Hello World";
    marker.map = mapView_;
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    NSLog(@"Detected Long Press");
    CGPoint pointInView = [gesture locationInView:mapView_];
    CLLocationCoordinate2D coordinate = [mapView_.projection coordinateForPoint: pointInView];
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    marker.title = @"Hello World";
    marker.map = mapView_;
}
 */

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}
@end
