//
//  DetailView.m
//  WeiBo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
    }
    [self setNeedsDisplay];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userImageView.layer.borderColor = [UIColor purpleColor].CGColor;
    _userImageView.layer.borderWidth = 1;
    _userImageView.layer.cornerRadius = _userImageView.width/2;
    _userImageView.layer.masksToBounds = YES;
    
    //用户头像
    NSString *url = self.weiboModel.userModel.avatar_large;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    //昵称
    _nameLabel.text = self.weiboModel.userModel.screen_name;
    
    //来源
    _sourceLabel.text = self.weiboModel.source;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
