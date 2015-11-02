//
//  WeiboAnnotation.h
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
#import <MapKit/MKAnnotation.h>

@interface WeiboAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (nonatomic, strong) WeiboModel *weiboModel;


@end
