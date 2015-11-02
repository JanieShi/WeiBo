//
//  NearByViewController.m
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "WeiboModel.h"
#import "WeiboDetailViewController.h"


/**
 *  
 1 定义(遵循MKAnnotation协议 )annotation类-->MODEL
 2 创建 annotation对象，并且把对象加到mapView;
 3 实现mapView 的协议方法 ,创建标注视图
 */
@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createViews];
    
    CLLocationCoordinate2D coordinate = {30.3269,120.368};

    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"汇文教育";
    annotation.subtitle = @"xs27";
    
    [_mapView addAnnotation:annotation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createViews{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //地图显示类型 ： 标准、卫星 、混合
    _mapView.mapType = MKMapTypeStandard;
    //用户跟踪
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置代理
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
}

#pragma mark - mapView代理

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocation *location = [userLocation location];
    CLLocationCoordinate2D    coordinate = [location coordinate];

    NSLog(@"纬度  %lf,精度 %lf",coordinate.latitude,coordinate.longitude);
    
    CLLocationCoordinate2D center = coordinate;
    
    //02 设置span ,数值越小,精度越高，范围越小
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
    
    //3 请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];
    
    
}


//标注视图被选中
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = weiboAnnotation.weiboModel;
    
    
    WeiboDetailViewController *vc = [[WeiboDetailViewController alloc] init];
    vc.weiboModel = weiboModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}


//标注视图获取
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    
//    
//    //    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
//    //  处理用户当前位置
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        
//        return nil;
//    }
//    
//    
//    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pin == nil) {
//        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//        //颜色
//        pin.pinColor = MKPinAnnotationColorPurple;
//        //从天而降
//        pin.animatesDrop = YES;
//        //设置显示标题
//        pin.canShowCallout = YES;
//        
//        pin.rightCalloutAccessoryView = [UIButton  buttonWithType:UIButtonTypeContactAdd];
//    }
//    return pin;
//    
//    
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //处理用户当前位置
    if ([annotation isKindOfClass:[MKUserLocation class]]) {

        return nil;
    }
    
    //微博annotation
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *view = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (view == nil) {
            view = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
        }
        return view;
    }
    
    return nil;
}


#pragma mark - 定位管理
- (void)_location{
    _locationManager = [[CLLocationManager alloc] init];
    
    if (kVersion > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy =  kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //1 停止定位
    [_locationManager stopUpdatingLocation];
    
    //2 请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];
    
    //3 设置地图显示区域
    //    typedef struct {
    //        CLLocationDegrees latitudeDelta;
    //        CLLocationDegrees longitudeDelta;
    //    } MKCoordinateSpan;
    //
    //    typedef struct {
    //        CLLocationCoordinate2D center;
    //        MKCoordinateSpan span;
    //    } MKCoordinateRegion;
    
    
    //>>01 设置 center
    
    CLLocationCoordinate2D  center = coordinate;
    
    //>>02 设置span ,数值越小,精度越高，范围越小
    
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
}

//获取附近微博
- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *annotationArray = [[ NSMutableArray alloc] initWithCapacity:statuses.count];
        
        
        for (NSDictionary *dataDic in statuses) {
            
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
            
            //创建annotation
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.weiboModel = model;
            [annotationArray addObject:annotation];
            
        }
        //把annotation 添加到mapView
        [_mapView addAnnotations:annotationArray];
        
        
    }];
    
    
}

@end
