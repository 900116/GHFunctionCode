//
//  ReObject.m
//  GHFunctionCode
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "ReObject.h"

@implementation ReObject
+(instancetype)obj
{
    static dispatch_once_t onceToken;
    static ReObject* obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [ReObject new];
    });
    return obj;
}

-(list_t (^)(c_str,c_str))findall
{
    list_t(^findall_func)(c_str,c_str) = ^ list_t(c_str regex,c_str content)
    {
        return nil;
    };
    return [findall_func copy];

}
@end
