//
//  NTESSessionSendShopGoodsContentView.h
//  DATING
//
//  Created by 天星 on 17/8/16.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "NIMSessionMessageContentView.h"
//用于点击事件触发标识符!!!
extern NSString *const SendCustomWithGoodsClick;

@interface NTESSessionSendShopGoodsContentView : NIMSessionMessageContentView

//自定义展示商品信息控件
@property(nonatomic,strong)UIImageView *headerImg;
@property(nonatomic,strong)UILabel*nameLa;
@property(nonatomic,strong)UILabel*priceLa;

@end
