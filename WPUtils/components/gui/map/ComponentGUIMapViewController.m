//
//  ComponentMapViewController.m
//  georunning
//
//  Created by William Pompei on 01/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "ComponentGUIMapViewController.h"
#import <MapKit/MapKit.h>
#import "ComponentLocation.h"

@interface ComponentGUIMapViewController (){
   BOOL centerOnUserLocation;
   void( ^locationFoundBlock)( CLLocation *);
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ComponentGUIMapViewController

#pragma mark - helper
-( void)locationFoundHelperCenterOnUserLocation:( BOOL)center{
   centerOnUserLocation = YES;
}

-( void)locationFoundBlock:( void( ^)( CLLocation *))block{
   locationFoundBlock = block;
}

#pragma mark -
-( void)start{
   [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(locationFound:) name:__kNotificationGeorunningComponentLocation object: nil];
}

-( void) locationFound:( NSNotification *)notification{
   CLLocation *location = notification.object;
   //[self.mapView setCenterCoordinate: location.coordinate animated:YES];
   if( centerOnUserLocation){
      [self __internalCenterOnUserLocation: location];
   }
   if( locationFoundBlock){
      locationFoundBlock( location);
   }
}


- (void)__internalCenterOnUserLocation:(CLLocation *)location {
   MKCoordinateRegion mapRegion;
   mapRegion.center = location.coordinate;
   mapRegion.span.latitudeDelta = 0.005;
   mapRegion.span.longitudeDelta = 0.005;
   [self.mapView setRegion:mapRegion animated: YES];
}

-( void) locationFoundHelperCenterOnLocation:( CLLocation *)location{
   [self __internalCenterOnUserLocation:location];
}

-( void)stop{
   [[NSNotificationCenter defaultCenter] removeObserver: self name: __kNotificationGeorunningComponentLocation object: nil];
}

-( void)dealloc{
   [[NSNotificationCenter defaultCenter] removeObserver: self name: __kNotificationGeorunningComponentLocation object: nil];
}

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
