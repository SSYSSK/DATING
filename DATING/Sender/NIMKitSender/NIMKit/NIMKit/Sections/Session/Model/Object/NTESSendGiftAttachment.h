//
//  NTESJanKenPonAttachment.h
//  NIM
//
//  Created by amao on 7/2/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESCustomAttachmentDefines.h"
#import "NTESJanKenPonAttachment.h"
#import "NIMKit.h"
@interface NTESSendGiftAttachment : NSObject<NIMCustomAttachment,NTESCustomAttachmentInfo>

//添加自定义消息元素
@property(nonatomic,copy)NSString*headerImage;
@property(nonatomic,copy)NSString*nameLabel;
@property(nonatomic,copy)NSString*priceLabel;
//数据源承接类
@property(nonatomic,strong)NSDictionary *messageDic;

@end
