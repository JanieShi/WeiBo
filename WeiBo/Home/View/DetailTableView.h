//
//  DetailTableView.h
//  WeiBo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "DetailView.h"
#import "DetailCell.h"
#import "DetailTableView.h"
#import "WeiboViewLayoutFrame.h"

@interface DetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    //用户视图
    DetailView *_userView;
    //微博视图
    WeiboView *_weiboView;
    
    //头视图
    UIView *_theTableHeaderView;
}

@property(nonatomic,strong)NSArray *commentDataArray;//评论数组
@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)NSDictionary *commentDic;

@end
