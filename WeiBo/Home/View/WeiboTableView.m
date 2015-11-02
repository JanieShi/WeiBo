//
//  WeiboTableView.m
//  WeiBo
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "WeiboTableView.h"

@implementation WeiboTableView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initTable];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib{
    
    [self _initTable];
    
}

- (void)_initTable{
    
    self.delegate = self;
    self.dataSource = self;
    
    //注册
//    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    
    [self registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _layoutFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell" forIndexPath:indexPath];
    //获得 某个cell的布局对象（各个frame  weiboModel）
    WeiboViewLayoutFrame *layout = _layoutFrameArray[indexPath.row];
    cell.layout = layout;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //cell
    //CELL,
    
    //可以提前算出高度,model
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    
    CGFloat height = layoutFrame.frame.size.height;
    
    
    
    return  height + 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboDetailViewController *detail = [[WeiboDetailViewController alloc] init];
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    detail.weiboModel = layoutFrame.model;
    //通过 view找viewController:原理，事件响应者链
    [self.viewController.navigationController pushViewController:detail animated:YES];
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 80;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
