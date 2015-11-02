//
//  HomeViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController (){
    WeiboTableView *_tableView;
    NSMutableArray *_data;
    
    ThemeImageView *_barImageView;//弹出微博条数提示
    ThemeLabel *_barLabel;//提示文字
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data = [[NSMutableArray alloc] init];
    
    [self _createTableView];
    
//    [self _loadData];
    
    [self _loadWeiboData];
}

- (void)_createTableView{
    
    _tableView = [[WeiboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
}

- (void)_loadData{
    
    //测试 获取微博
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"statuses/public_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
    //测试切换主题
//    ThemeManager *manager = [ThemeManager shareInstance];
//    manager.themeName = @"魁拔";
    
}

#pragma mark - 微博请求

- (void)_loadWeiboData{
    
//     [self showLoading:YES];
    [self showHUD:@"loading..."];
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    
    //如果已经登陆则获取微博数据
    if (appDelegate.sinaWeibo.isLoggedIn) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        
        SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline
                                                                    params:params
                                                                httpMethod:@"GET"
                                                                  delegate:self];
        
        
        request.tag = 100;
        
        return;
    }
    [appDelegate.sinaWeibo logIn];
    
}

//上拉加载更多
- (void)_loadMoreData{
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    //如果已经登陆则获取微博数据
    if (appDelegate.sinaWeibo.isLoggedIn) {
        
        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        
        //设置maxId
        
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = [_data lastObject];
            WeiboModel *model = layoutFrame.model;
            NSString *maxId = model.weiboIdStr;
            [params setObject:maxId forKey:@"max_id"];
        }
        
        
        
        SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline
                                                                   params:params
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        
        request.tag = 101;
        
        
        return;
    }
    [appDelegate.sinaWeibo logIn];
    
}

//下拉刷新
- (void)_loadNewData{
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (appDelegate.sinaWeibo.isLoggedIn) {
        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        //设置 sinceId
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = _data[0];
            WeiboModel *model = layoutFrame.model;
            NSString *sinceId = model.weiboIdStr;
            [params setObject:sinceId forKey:@"since_id"];
        }
        
        
        SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline
                                                                   params:params
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        request.tag = 102;
        
        
        return;
    }
    [appDelegate.sinaWeibo logIn];
    
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@",result);
    
    //每一条微博存到 数组里
    NSArray *dicArray = [result objectForKey:@"statuses"];
    
    NSMutableArray *layoutFrameArray = [[NSMutableArray alloc] init];
    
    //解析model,然后把model存放到dataArray,然后再把dataArray 交给tableView;
    
    for (NSDictionary *dic in dicArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewLayoutFrame *layout = [[WeiboViewLayoutFrame alloc] init];
        layout.model = model;
        
        [layoutFrameArray addObject:layout];
    }
//    _tableView.layoutFrameArray = layoutFrameArray;
//    [_tableView reloadData];
    
    if (request.tag == 100) {//普通加载微博
//        [self showLoading:NO];
        
//        [self hideHUD];
        
        [self completeHUD:@"completed"];
        
        _data = layoutFrameArray;
        
    }else if(request.tag == 101){//更多微博
        
        if (layoutFrameArray.count > 1) {
            [layoutFrameArray removeObjectAtIndex:0];
            [_data addObjectsFromArray:layoutFrameArray];
        }
        
        
    }else if(request.tag == 102){//最新微博
        
        if (layoutFrameArray.count > 0) {
            
            //方法一：
//            [layoutFrameArray addObjectsFromArray:_data];
//            _data = layoutFrameArray;
            
            //方法二：
            NSRange range = NSMakeRange(0, layoutFrameArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:layoutFrameArray atIndexes:indexSet];
            
            [self showNewWeiboCount:layoutFrameArray.count];
            
        }
        
    }
    
    if (_data.count != 0) {
        _tableView.layoutFrameArray = _data;
        [_tableView reloadData];
    }
    
    
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
}

- (void)showNewWeiboCount:(NSInteger)count{
    if (_barImageView == nil) {
        
        _barImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barImageView.imageName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        
        _barLabel = [[ThemeLabel alloc] initWithFrame:_barImageView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor yellowColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        
        [_barImageView addSubview:_barLabel];
        
    }
    
    if (count >= 0) {
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条微博",count];
        
        [UIView animateWithDuration:0.6 animations:^{
            
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 64+5+40);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.6 animations:^{
                [UIView setAnimationDelay:1];//让提示消息停留一秒
                _barImageView.transform = CGAffineTransformIdentity;
            }];
            
        }];
    
        //播放声音
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //注册系统声音
        SystemSoundID soundId;// 0
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
