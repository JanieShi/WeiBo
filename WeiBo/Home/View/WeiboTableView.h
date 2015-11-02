//
//  WeiboTableView.h
//  WeiBo
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboCell.h"
#import "WeiboViewLayoutFrame.h"
#import "UIImageView+WebCache.h"
#import "UIView+ViewController.h"
#import "WeiboDetailViewController.h"

@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *layoutFrameArray;

@end
