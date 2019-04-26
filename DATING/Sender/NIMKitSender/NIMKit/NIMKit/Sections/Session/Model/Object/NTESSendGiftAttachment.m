//
//  NTESJanKenPonAttachment.m
//  NIM
//
//  Created by amao on 7/2/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESSendGiftAttachment.h"
#import "NTESSessionUtil.h"
#import "DATING-Swift.h"
@implementation NTESSendGiftAttachment

//对数据源进行类型分配.
- (NSString *)encodeAttachment
{
    
    NSDictionary *dictContent = @{CM_GOODS_IMG: self.headerImage,CM_GOODS_NAME:self.nameLabel,CM_GOODS_PRICE: self.priceLabel};
    
    NSDictionary *dict = @{CMType : @(CustomMessageTypeSendGift),
                           CMData : dictContent};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:0
                                                     error:nil];
    NSString *content = nil;
    if (data) {
        content = [[NSString alloc] initWithData:data
                                        encoding:NSUTF8StringEncoding];
    }
    return content;
}

//实例化元素(懒加载...)
-(NSString *)headerImage{
    
    if (!_headerImage) {
        _headerImage =nil;
    }
    return _headerImage;
}
-(NSString *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel =nil;
    }
    return _nameLabel;
}
-(NSString *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel =nil;
    }
    return _priceLabel;
}

//数据源setter方法实现
-(void)setMessageDic:(NSDictionary *)messageDic
{
    _messageDic =messageDic;
    //给元素赋值
    self.headerImage = [NSString stringWithFormat:@"%@",_messageDic[CM_GOODS_IMG]];
    self.nameLabel = [NSString stringWithFormat:@"%@",_messageDic[CM_GOODS_NAME]];
    self.priceLabel =[NSString stringWithFormat:@"%@",_messageDic[CM_GOODS_PRICE]];
}
//设置自定义消息Bounds
- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width{
    
    return CGSizeMake(200, 70);
}
- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message
{
    if (message.session.sessionType == NIMSessionTypeChatroom)
    {
        CGFloat bubbleMarginTopForImage  = 15.f;
        CGFloat bubbleMarginLeftForImage = 12.f;
        return  UIEdgeInsetsMake(bubbleMarginTopForImage,bubbleMarginLeftForImage,0,0);
    }
    else
    {
        CGFloat bubbleMarginForImage    = 3.f;
        CGFloat bubbleArrowWidthForImage = 5.f;
        if (message.isOutgoingMsg) {
            return  UIEdgeInsetsMake(bubbleMarginForImage,bubbleMarginForImage,bubbleMarginForImage,bubbleMarginForImage + bubbleArrowWidthForImage);
        }else{
            return  UIEdgeInsetsMake(bubbleMarginForImage,bubbleMarginForImage + bubbleArrowWidthForImage, bubbleMarginForImage,bubbleMarginForImage);
        }
    }
}

//指向自定义view类
- (NSString *)cellContent:(NIMMessage *)message{
    return @"NIMSessionGiftContentView";
}

@end
