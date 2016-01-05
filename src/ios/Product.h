//
//  Product.h
//  libTest
//
//  Created by 1 on 15/12/24.
//  Copyright © 2015年 fami2u.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject


//价格
@property (nonatomic, assign) float price;
//标题
@property (nonatomic, copy) NSString *subject;
//商品描述
@property (nonatomic, copy) NSString *body;
//订单ID
@property (nonatomic, copy) NSString *orderId;
//回调URL
@property (nonatomic,strong)NSString *notify_url;

//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
@property (nonatomic,strong)NSString *appScheme;

//合作人id
@property (nonatomic,strong)NSString *partner;
//卖方id
@property (nonatomic,strong)NSString *seller;
//私钥
@property (nonatomic,strong)NSString *privateKey;

@end
