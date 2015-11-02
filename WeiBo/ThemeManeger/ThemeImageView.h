//
//  ThemeImageView.h
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

@interface ThemeImageView : UIImageView

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic,assign)CGFloat leftCapWidth;
@property (nonatomic,assign)CGFloat topCapWidth;

@end
