//
//  DATGiftModel.h
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMKit.h"
NS_ASSUME_NONNULL_BEGIN
@interface DATGiftModel  : NSObject<NIMCustomAttachment>
@property(nonatomic,strong)NSString *iconPath;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
NS_ASSUME_NONNULL_END
