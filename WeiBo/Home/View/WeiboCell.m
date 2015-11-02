//
//  WeiboCell.m
//  WeiBo
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "WeiboCell.h"

@implementation WeiboCell

- (void)awakeFromNib {
    // Initialization code
    _weiboView = [[WeiboView alloc] init];
    [self.contentView addSubview:_weiboView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//复写setLayoutFrame方法，当model设置的时候重新布局子视图
- (void)setLayout:(WeiboViewLayoutFrame *)layout{
    
    if (_layout != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        [self setNeedsLayout];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //1.头像
    [_headView sd_setImageWithURL:[NSURL URLWithString:_layout.model.userModel.profile_image_url]];
    
    //2.昵称
    _nickNameLabel.text = _layout.model.userModel.screen_name;
    
    //3.评论
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",[_layout.model.commentsCount stringValue]];
    
    //4.转发
    _repostLabel.text = [NSString stringWithFormat:@"转发:%@",[_layout.model.repostsCount stringValue]];
    
    //5.来源
    _sourceLabel.text = _layout.model.source;
    
    //6.对weiboView 进行布局显示
    _weiboView.frame = _layout.frame;
    
}

@end
