//
//  MainTabBarController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "common.h"
#import "ThemeImageView.h" 
#import "ThemeButton.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"

@interface MainTabBarController ()
{
    ThemeImageView *_selectedImageView;
    ThemeLabel *_badgeLabel;
    ThemeImageView *_badgeImageView;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子视图控制器
    [self _createSubController];
    
    //设置 tabbar
    [self _createTabBar];
    
    //开启定时器,请求unread_count接口 获取未读微博、新粉丝数量、新评论。。。
    [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)_createTabBar{
    //1.移除TabBarButton
    for (UIView *view in self.tabBar.subviews) {
        //通过字符串获得类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //2.背景图
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    bgImageView.imageName = @"mask_navbar.png";
    //bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    
    [self.tabBar addSubview:bgImageView];
    
    //3.选中图片
//    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 49)];
//    _selectedImageView.image = [UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 49)];
    _selectedImageView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    
    //4.设置按钮
//    NSArray *imageNames = @[@"Skins/cat/home_tab_icon_1.png",
//                            @"Skins/cat/home_tab_icon_2.png",
//                            @"Skins/cat/home_tab_icon_3.png",
//                            @"Skins/cat/home_tab_icon_4.png",
//                            @"Skins/cat/home_tab_icon_5.png"];
    
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"];

    
    CGFloat width = kScreenWidth / 5;
    
    for (int i = 0; i < imageNames.count; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i * width, 0, width, 49)];
//        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        button.normalImageName = imageNames[i];
        
        button.tag = i + 1;
        
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        
    }
    
}

- (void)selectedAction:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        _selectedImageView.center = button.center;
    }];
    
    self.selectedIndex = button.tag - 1;
    
}

- (void)_createSubController{
    
    NSArray *storyNames = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < 5; i++) {
        //创建storyBoard对象
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:storyNames[i] bundle:nil];
        
        //通过 storyBoard创建控制器对象
        BaseNavigationController *navVC = [storyBorad instantiateInitialViewController];
        
        [navArray addObject:navVC];
    }
    self.viewControllers = navArray;
    
}

#pragma mark - 未读系消息个数获取
- (void)timerAction{
    
    //请求数据
    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    //number_notify_9.png
    //Timeline_Notice_color
    //未读微博
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    CGFloat tabBarButtonWidth = kScreenWidth/5;
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeImageView.imageName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font =[UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeImageView addSubview:_badgeLabel];
        
    }
    if (count > 0) {
        _badgeImageView.hidden = NO;
        if (count > 99) {
            count = 99;
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }else{
        
        _badgeImageView.hidden = YES;
        
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
