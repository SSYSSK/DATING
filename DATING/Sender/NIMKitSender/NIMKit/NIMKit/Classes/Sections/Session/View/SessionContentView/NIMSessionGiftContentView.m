//
//  NIMSessionGiftContentView.m
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "NIMSessionGiftContentView.h"
#import "NIMMessageModel.h"
#import "UIView+NIM.h"
#import "UIImage+NIMKit.h"
#import "NIMKitUIConfig.h"
#import "NTESSendGiftAttachment.h"
@interface NIMSessionGiftContentView()

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * lookButton;

@end
@implementation NIMSessionGiftContentView

- (instancetype)initSessionMessageContentView{
    self = [super initSessionMessageContentView];
    if (self) {
        
        
        _imageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift_rose"]];
        _imageView.frame = CGRectMake(10, 10, 25, 45);
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame), 10, 100, 20);
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        _lookButton = [[UIButton alloc]init];
        _lookButton.frame = CGRectMake(CGRectGetMaxX(_imageView.frame), CGRectGetMaxY(_titleLabel.frame) + 5, 100, 15);
        [_lookButton setTitle:@"点击查看" forState:UIControlStateNormal];
        [_lookButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _lookButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_lookButton];
    }
    return self;
}

- (void)refresh:(NIMMessageModel *)data{
    [super refresh:data];
    NIMCustomObject *customObject = (NIMCustomObject*)data.message.messageObject;
    id attachment = customObject.attachment;
    if([attachment isKindOfClass:[NTESSendGiftAttachment class]]) {
        NTESSendGiftAttachment *giftAttachment = attachment;
        self.titleLabel.text = giftAttachment.nameLabel;
        self.imageView.image = [UIImage imageNamed:giftAttachment.headerImage];
    }
   
}

- (void)onTouchUpInside:(id)sender
{
    NIMKitEvent *event = [[NIMKitEvent alloc] init];
    event.eventName = NIMKitEventNameTapContent;
    event.messageModel = self.model;
    [self.delegate onCatchEvent:event];
}
@end
