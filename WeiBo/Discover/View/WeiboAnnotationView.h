//
//  WeiboAnnotationView.h
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView{
    UIImageView *_headImageView;//头像视图
    UILabel *_textLabel; //微博内容
    
}


@end
