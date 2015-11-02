//
//  NearByViewController.h
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearByViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    
    CLLocationManager *_locationManager;
    
    MKMapView *_mapView;
}

@end
