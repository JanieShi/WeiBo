//
//  common.h
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#ifndef WeiBo_common_h
#define WeiBo_common_h

#define kVersion   [[UIDevice currentDevice].systemVersion doubleValue]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kAppKey             @"3903520889"
#define kAppSecret          @"e81346121d95f140d62452ecbfb14e7c"
#define kAppRedirectURI     @"http://sina.com"


#define unread_count  @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments      @"comments/show.json"   //评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态


//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15  //微博字体
#define FontSize_ReWeibo(isDetail) isDetail?15:14 //转发微博字体

#endif
