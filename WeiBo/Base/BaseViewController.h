//
//  BaseViewController.h
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"

@interface BaseViewController : UIViewController{
    UIView *_tipView;
    MBProgressHUD *_hud;
    
    UIWindow *_tipWindow;//在状态栏上显示 微博发送进度
}

- (void)loadImage;

- (void)setNav;

//自己实现加载提示
- (void)showLoading:(BOOL)show;


//第三方 MBProgressHUD

- (void)showHUD:(NSString *)title;

- (void)hideHUD;
- (void)completeHUD:(NSString *)title;

//设置背景图片
- (void)setBgImage;



//状态栏 提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;


@end
