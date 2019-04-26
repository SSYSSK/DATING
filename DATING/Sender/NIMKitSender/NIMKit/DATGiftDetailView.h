//
//  DATGiftDetailView.h
//  DATING
//
//  Created by 天星 on 17/8/17.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DATGiftDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
+(DATGiftDetailView *)instanceTextView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property(nonatomic,strong)NSDictionary *dictStr;
@end
