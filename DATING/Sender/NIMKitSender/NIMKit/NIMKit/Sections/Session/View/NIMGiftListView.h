//
//  NIMGiftListView.h
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMKit.h"
typedef void(^SendGiftActionBlock) (NSMutableDictionary *dict);//1
@interface NIMGiftListView : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) NIMMediaItem *item;
@property (nonatomic,strong)NSMutableArray *array ;
@property (nonatomic,strong)NSMutableArray *viewArray;
@property (nonatomic,strong)NSMutableDictionary *nowDict;
@property (nonatomic,assign)NSString *myPrice;

+(NIMGiftListView *)instanceTextView;

@property (nonatomic,strong)SendGiftActionBlock sendGiftActionBlock;//2


- (IBAction)sendGift:(id)sender;
@end
