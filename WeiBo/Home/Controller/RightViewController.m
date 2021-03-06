//
//  RightViewController.m
//  WeiBo
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseNavigationController.h"
#import "SendViewController.h"
#import "LocViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadImage];
}

- (void)_createButton{
    // 图片的数组
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    
    for (int i = 0; i < imageNames.count; i++) {
        
        ThemeButton *btn = [[ThemeButton alloc] initWithFrame:CGRectMake(10, i*50+100, 50, 50)];
        
        btn.normalImageName = imageNames[i];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


- (void)buttonAction:(UIButton *)button{
    if (button.tag == 0) {
        // 发送微博
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            // 弹出发送微博控制器
            
            SendViewController *senderVc = [[SendViewController alloc] init];
            senderVc.title = @"发送微博";
            
            
            // 创建导航控制器
            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:senderVc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }else if (button.tag == 4){
        
        // 附近地点
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            
            
            LocViewController *vc = [[LocViewController alloc] init];
            vc.title = @"附近商圈";
            
            // 创建导航控制器
            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];

        
    }
    
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
