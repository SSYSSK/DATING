//
//  NIMGiftContentConfig.m
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "NIMGiftContentConfig.h"
#import "NIMKitUIConfig.h"

@implementation NIMGiftContentConfig

- (CGSize)contentSize:(CGFloat)cellWidth message:(NIMMessage *)message
{
    return CGSizeMake(110.f, 55.f);
}

- (NSString *)cellContent:(NIMMessage *)message
{
    return @"NIMSessionGiftContentView";
}

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message
{
    NIMKitBubbleConfig *config = [[NIMKitUIConfig sharedConfig] bubbleConfig:message];
    return config.contentInset;
}


@end
