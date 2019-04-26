//
//  NTESCustomAttachmentDecoder.m
//  NIM
//
//  Created by amao on 7/2/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESCustomAttachmentDecoder.h"
#import "NTESCustomAttachmentDefines.h"
#import "NTESJanKenPonAttachment.h"
#import "NTESSnapchatAttachment.h"
#import "NTESChartletAttachment.h"
#import "NTESWhiteboardAttachment.h"
#import "NSDictionary+NTESJson.h"
#import "NTESSessionUtil.h"
#import "NTESSendGiftAttachment.h"
#import "DATING-Swift.h"
@implementation NTESCustomAttachmentDecoder

- (id<NIMCustomAttachment>)decodeAttachment:(NSString *)content
{
    id<NIMCustomAttachment> attachment = nil;
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:nil];
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            NSInteger type     = [dict jsonInteger:CMType];
            NSDictionary *data = [dict jsonDict:CMData];
//            switch (type) {
//                case CustomMessageTypeChartlet:
//                {
//                    attachment = [[NTESChartletAttachment alloc] init];
//                    ((NTESChartletAttachment *)attachment).chartletCatalog = [data jsonString:CMCatalog];
//                    ((NTESChartletAttachment *)attachment).chartletId      = [data jsonString:CMChartlet];
//                }
//                    break;
//                    
//                case CustomMessageTypeSendGift:
//                {
//                    attachment = [[NTESSendGiftAttachment alloc] init];
//                    ((NTESSendGiftAttachment *)attachment).headerImage = [data jsonString:CM_GOODS_IMG];
//                    ((NTESSendGiftAttachment *)attachment).nameLabel = [data jsonString:CM_GOODS_NAME];
//                    ((NTESSendGiftAttachment *)attachment).priceLabel = [data jsonString:CM_GOODS_PRICE];                }
//                default:
//                    break;
//            }
            switch (type) {
                case CustomMessageTypeJanKenPon:
                {
                    attachment = [[NTESJanKenPonAttachment alloc] init];
                    ((NTESJanKenPonAttachment *)attachment).value = [data jsonInteger:CMValue];
                    
                    
                }
                    break;
                case CustomMessageTypeSnapchat:
                {
                    attachment = [[NTESSnapchatAttachment alloc] init];
                    ((NTESSnapchatAttachment *)attachment).md5 = [data jsonString:CMMD5];
                    ((NTESSnapchatAttachment *)attachment).url = [data jsonString:CMURL];
                    ((NTESSnapchatAttachment *)attachment).isFired = [data jsonBool:CMFIRE];
                }
                    break;
                case CustomMessageTypeChartlet:
                {
                    attachment = [[NTESChartletAttachment alloc] init];
                    ((NTESChartletAttachment *)attachment).chartletCatalog = [data jsonString:CMCatalog];
                    ((NTESChartletAttachment *)attachment).chartletId      = [data jsonString:CMChartlet];
                }
                    break;
                case CustomMessageTypeWhiteboard:
                {
                    attachment = [[NTESWhiteboardAttachment alloc] init];
                    ((NTESWhiteboardAttachment *)attachment).flag = [data jsonInteger:CMFlag];
                }
                    break;
                case CustomMessageTypeSendGift:
                {
                    attachment = [[NTESSendGiftAttachment alloc] init];
                    ((NTESSendGiftAttachment *)attachment).headerImage = [data jsonString:@"icon"];
                    ((NTESSendGiftAttachment *)attachment).nameLabel = [data jsonString:@"name"];
                    ((NTESSendGiftAttachment *)attachment).priceLabel = [data jsonString:@"price"];                }
                    break;
                default:
                    break;
            }
            attachment = [self checkAttachment:attachment] ? attachment : nil;
        }
    }
    return attachment;
}


- (BOOL)checkAttachment:(id<NIMCustomAttachment>)attachment{
    BOOL check = NO;
    if ([attachment isKindOfClass:[NTESJanKenPonAttachment class]])
    {
        NSInteger value = [((NTESJanKenPonAttachment *)attachment) value];
        check = (value>=CustomJanKenPonValueKen && value<=CustomJanKenPonValuePon) ? YES : NO;
    }
    else if ([attachment isKindOfClass:[NTESSnapchatAttachment class]])
    {
        check = YES;
    }
    else if ([attachment isKindOfClass:[NTESChartletAttachment class]])
    {
        NSString *chartletCatalog = ((NTESChartletAttachment *)attachment).chartletCatalog;
        NSString *chartletId      =((NTESChartletAttachment *)attachment).chartletId;
        check = chartletCatalog.length&&chartletId.length ? YES : NO;
    }
    else if ([attachment isKindOfClass:[NTESWhiteboardAttachment class]])
    {
        NSInteger flag = [((NTESWhiteboardAttachment *)attachment) flag];
        check = ((flag >= CustomWhiteboardFlagInvite) && (flag <= CustomWhiteboardFlagClose)) ? YES : NO;
    }
    else if ([attachment isKindOfClass:[NTESSendGiftAttachment class]])
    {
        NSString *headerImg = ((NTESSendGiftAttachment *)attachment).headerImage;
        NSString *shopNameLa = ((NTESSendGiftAttachment *)attachment).nameLabel;
        NSString *priceLa = ((NTESSendGiftAttachment *)attachment).priceLabel;
        
        
        check = shopNameLa.length&&priceLa.length&&headerImg.length ? YES : NO;

    }
    
    return check;}
@end
