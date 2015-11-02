//
//  BaseViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeButton.h"
#import "UIProgressView+AFNetworking.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadImage];
    
//    [self setNav];
}

- (void)setNav{
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    ThemeButton *left = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    left.bgNormalImageName = @"button_title";
    left.normalImageName = @"group_btn_all_on_title";
    [left setTitle:@"设置" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButtonItem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    ThemeButton *right = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    right.bgNormalImageName = @"button_title";
    right.normalImageName = @"group_btn_all_on_title";
    [right setTitle:@"编辑" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButtonItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.RightBarButtonItem = rightItem;
    
}

- (void)setAction{
    
    MMDrawerController *mmDC = self.mm_drawerController;
    [mmDC openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)editAction{
    
    MMDrawerController *mmDC = self.mm_drawerController;
    [mmDC openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}



-  (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

//当xib或者storyboard创建出来对象 的时候调用该init方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //注册通知监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return  self;
    
    
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadImage];
}

//加载图片
- (void)loadImage{
    
    //主题管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    //修改视图背景
    UIImage *bgImage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
}

- (void)showLoading:(BOOL)show{
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2 - 30, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        //添加加载图片
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.tag = 100;
        [_tipView addSubview:activityView];
        
        
        //02 label
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"正在加载";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        [_tipView addSubview:label];
        
        //调整位置
        label.left = (kScreenWidth-label.width)/2;
        activityView.right = label.left-5;
        
    }
    if (show) {
        
        UIActivityIndicatorView *activiyView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
        [activiyView startAnimating];
        [self.view addSubview:_tipView];
        
    }else{
        
        if (_tipView.superview) {
            UIActivityIndicatorView *activiyView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
            [activiyView stopAnimating];
            [_tipView removeFromSuperview];
            
        }
    }
    
    
    
}

- (void)showHUD:(NSString *)title{
    
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [_hud show:YES];
    _hud.labelText = title;
    
    //灰色背景视图覆盖掉其他视图
    _hud.dimBackground = YES;
    
}
- (void)hideHUD{
    
    [_hud hide:YES];
}

- (void)completeHUD:(NSString *)title{
    
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark@2x.png"]];
    
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    //持续延迟1.5s隐藏
    [_hud hide:YES afterDelay:1.5];
    
}

#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNotificationName object:nil];
    
    [self loadImage];
}



#pragma  mark - 状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation{
    
    if (_tipWindow == nil) {
        //01 创建window
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //02 显示文字 label
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor clearColor];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.font = [UIFont systemFontOfSize:13];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 100;
        [_tipWindow addSubview:tpLabel];
        
        
        //03 进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 20-3, kScreenWidth, 5);
        progressView.tag = 101;
        progressView.progress = 0.0;
        [_tipWindow addSubview:progressView];
    }
    
    UILabel *tpLabel = (UILabel*)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    
    
    if (show) {
        _tipWindow.hidden = NO;
        
        if (operation != nil) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else{
            progressView.hidden = YES;
        }
        
    }else{
        
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
    
}


- (void)removeTipWindow{
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
