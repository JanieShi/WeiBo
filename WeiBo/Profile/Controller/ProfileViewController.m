//
//  ProfileViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ProfileViewController.h"
#import "ThemeButton.h"

@interface ProfileViewController (){
    WeiboTableView *_tableView;
    UIView *_headView;
    UIImageView *_userView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _loadData];
    
    [self _createTableView];
    
//    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTableView{
    _tableView = [[WeiboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headView;
    [self _createHeadView];
    [self _createButton];
}

- (void)_createHeadView{
    _userView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 100, 120)];
    _userView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_userView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 100, 30)];
    nameLabel.text = @"呜物语";
    nameLabel.font = [UIFont boldSystemFontOfSize:27];
    [_headView addSubview:nameLabel];
    
    UILabel *information = [[UILabel alloc] initWithFrame:CGRectMake(120, 60, 100, 20)];
    information.text = @"女 浙江 杭州";
    [_headView addSubview:information];
    
    UILabel *introduce = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, 300, 20)];
    introduce.lineBreakMode = 0;
    introduce.font = [UIFont systemFontOfSize:15];
    introduce.text = @"简介:此人比较懒，还什么都没留下";
    [_headView addSubview:introduce];
}

- (void)_createButton{
    
    NSArray *array = @[@"关注",
                       @"粉丝",
                       @"资料",
                       @"更多"
                      ];
    
    for (int i = 0; i < array.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8 + i * 80, 135, 60, 60)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor magentaColor]];
        
        [_headView addSubview: button];
    }
    
}

- (void)_loadData{
    
    //测试 获取微博
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
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
    
    for (NSDictionary *dic in dicArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewLayoutFrame *layout = [[WeiboViewLayoutFrame alloc] init];
        layout.model = model;
        
        //设置头视图用户头像
        [_userView sd_setImageWithURL:[NSURL URLWithString:layout.model.userModel.profile_image_url]];
        
        [layoutFrameArray addObject:layout];
    }
    _tableView.layoutFrameArray = layoutFrameArray;
    [_tableView reloadData];
    
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
