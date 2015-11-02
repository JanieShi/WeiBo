//
//  WeiboAnnotationView.m
//  WeiBo
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.bounds = CGRectMake(0, 0, 100, 40);
//        [self _createViews];
//    }
//    return self;
//    
//}

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 40);
        [self _createViews];
    }
    return self;
    
}

- (void)_createViews{
    
    //头像视图
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _headImageView.image = [UIImage imageNamed:@"002"];
    [self addSubview:_headImageView];
    
    _textLabel =[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 40)];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.text = @"Panda";
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    WeiboAnnotation *annotation = self.annotation;
    WeiboModel *model = annotation.weiboModel;
    
    _textLabel.text = model.text;
    
    
    NSString *urlStr = model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"001"]];
    
}

@end
