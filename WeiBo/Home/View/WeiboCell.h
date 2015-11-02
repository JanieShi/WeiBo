//
//  WeiboCell.h
//  WeiBo
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewLayoutFrame.h"
#import "WeiboView.h"
#import "UIImageView+WebCache.h"

@interface WeiboCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *repostLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@property (nonatomic, strong) WeiboViewLayoutFrame *layout;

@property (nonatomic, strong) WeiboView *weiboView;

@end
