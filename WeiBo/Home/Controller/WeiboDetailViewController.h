//
//  WeiboDetailViewController.h
//  WeiBo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WeiboModel.h"
#import "SinaWeibo.h"
#import "DetailTableView.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DetailModel.h"

@interface WeiboDetailViewController : BaseViewController<SinaWeiboRequestDelegate> {
    
    DetailTableView *_tableView;
}


//评论的微博Model
@property(nonatomic,strong)WeiboModel *weiboModel;

//评论列表数据
@property(nonatomic,strong)NSMutableArray *data;

@end
