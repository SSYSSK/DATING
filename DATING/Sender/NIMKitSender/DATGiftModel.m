//
//  DATGiftModel.m
//  DATING
//
//  Created by 天星 on 17/8/15.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

#import "DATGiftModel.h"

@implementation DATGiftModel
-(instancetype)initWithDict:(NSDictionary *)dict {
    DATGiftModel *model = [[DATGiftModel alloc]init];
    model.name= dict[@"name"];
    model.iconPath= dict[@"icon"];
    model.price= dict[@"price"];
    
    return model;
}

-(NSString *)encodeAttachment {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"name"] = self.name;
    dict[@"icon"] = self.iconPath;
    dict[@"price"] = self.price;
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end
