//
//  DATGiftDetailView.m
//  DATING
//
//  Created by 天星 on 17/8/17.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "DATGiftDetailView.h"
#import "DATING-Swift.h"
@implementation DATGiftDetailView

+(DATGiftDetailView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"DATGiftDetailView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
    
    [self.bgView addGestureRecognizer:tapGesture];
    
}

-(void)handleTapGesture{
    [self removeFromSuperview];
}

-(void)setDictStr:(NSDictionary *)dictStr {
    _dictStr = dictStr;
    self.imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",dictStr [CM_GOODS_IMG]]];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：%@ 金币",dictStr [CM_GOODS_PRICE]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",dictStr [CM_GOODS_NAME]];
}

@end
