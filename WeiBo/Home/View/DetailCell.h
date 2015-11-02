//
//  DetailCell.h
//  WeiBo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "WXLabel.h"
#import "ThemeManager.h"
#import "UIImageView+WebCache.h"

@interface DetailCell : UITableViewCell<WXLabelDelegate>{
    WXLabel *_commentTextLabel;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;


@property (nonatomic, strong) DetailModel *detailModel;

+ (float)getCommentHeight:(DetailModel *)detailModel;

@end
