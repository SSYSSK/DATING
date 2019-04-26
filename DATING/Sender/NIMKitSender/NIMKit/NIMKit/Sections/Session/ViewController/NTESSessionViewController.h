//
//  NTESSessionViewController.h
//  NIM
//
//  Created by amao on 8/11/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NIMSessionViewController.h"
typedef enum Type {
    Video  = 0,
    Audio = 1
} TType;


@interface NTESSessionViewController : NIMSessionViewController

@property (nonatomic,assign) BOOL disableCommandTyping;  //需要在导航条上显示“正在输入”

@property (nonatomic,assign) BOOL disableOnlineState;  //需要在导航条上显示在线状态

-(void)deleteMoney:(TType)type time:(int)time block:(void (^)())block;
-(void)openMediaItemVideoChat:(NIMMediaItem *)item;
-(void)openMediaItemAudioChat:(NIMMediaItem *)item;
- (void)enterMoreCard:(id)sender;
@end
