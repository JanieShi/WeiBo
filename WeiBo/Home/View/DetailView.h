//
//  DetailView.h
//  WeiBo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"
#import "UIImageView+WebCache.h"

@interface DetailView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@property (nonatomic,strong) WeiboModel *weiboModel;

@property (nonatomic,strong) WeiboViewLayoutFrame *layout;

@end
