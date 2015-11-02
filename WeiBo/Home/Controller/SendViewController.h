//
//  SendViewController.h
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate>{
    
    //1 文本编辑栏
    UITextView *_textView;
    
    //2 工具栏
    UIView *_editorBar;
    
    //3 显示缩略图
    ZoomImageView *_zoomImageView;
    
    
    //4 位置管理器
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    
}


@end
