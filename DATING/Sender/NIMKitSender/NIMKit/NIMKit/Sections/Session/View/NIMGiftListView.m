//
//  NIMGiftListView.m
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "NIMGiftListView.h"
#import "DATING-Swift.h"
@implementation NIMGiftListView

+(NIMGiftListView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NIMGiftListView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
    [self.bgView addGestureRecognizer:tapGesture];
    
    self.array = [NSMutableArray array];
    self.viewArray = [NSMutableArray array];
    self.nowDict = [NSMutableDictionary dictionary];

    
}

-(void)setArray:(NSMutableArray *)array {
    self.priceLabel.text = [NSString stringWithFormat:@"我的金币：%@",self.myPrice];
    _array = array;
    for ( int i = 0 ; i < _array.count; i++ ) {
        NSMutableDictionary *dict  = (NSMutableDictionary*)_array[i];
        UIView *view = [[UIView alloc]init];
        //所在的行
        int h = i/3;
        int l = i%3;
        int width = (self.scrollview.frame.size.width - 80 )/3;
        int height = (self.scrollview.frame.size.height - 10 )/2;
        int x = width * l + 20 * ( l + 1);
        int y = height * h + 10 * h;
        view.frame = CGRectMake(x, y, width, height);
        
        
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, width - 40, height - 30)];
        imageview.image = [UIImage imageNamed:dict[@"icon"]];
        [view addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame), width, 25)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blueColor];
        label.text = [NSString stringWithFormat:@"%@",dict[@"price"]];
        [view addSubview:label];
        
        [self.scrollview addSubview:view];
        
        UIButton  *button = [[UIButton alloc]init];
        button.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewArray addObject:view];
        [view addSubview:button];
    }
}

-(void)handleTapGesture{
    [self removeFromSuperview];
}

-(void)buttonAction:(UIButton *)button {
    NSMutableDictionary *dict = self.array[button.tag];
    self.nowDict = self.array[button.tag];
    
    for (int i = 0 ;i<self.viewArray.count; i++) {
        UIView *view = self.viewArray[i];
        [view setBackgroundColor:[UIColor whiteColor]];
    }
    UIView *view = button.superview;
    [view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:218/255.0 blue:185/255.0 alpha:1]];
}

- (IBAction)sendGift:(id)sender {
    [self removeFromSuperview];
    
    self.sendGiftActionBlock(self.nowDict);
    
}

@end
