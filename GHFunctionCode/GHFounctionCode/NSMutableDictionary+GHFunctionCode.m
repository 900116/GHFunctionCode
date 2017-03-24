//
//  NSMutableDictionary+GHFunctionCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "GHFunctionCode.h"
#import "NSMutableDictionary+GHFunctionCode.h"

@implementation NSMutableDictionary (GHFunctionCode)
-(void (^)())clear
{
    __weak mdict_t weakself = self;
    void(^clear_func)() = ^{
        [weakself removeAllObjects];
    };
    return [clear_func copy];
}

-(id (^)(c_str))pop
{
    __weak mdict_t weakself = self;
    id(^pop_func)(c_str) = ^id(c_str key){
        str_t key_str = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
        id obj = [weakself objectForKey:key_str];
        [weakself removeObjectForKey:key_str];
        return obj;
    };
    return [pop_func copy];
}

-(list_t (^)())popitem
{
    __weak mdict_t weakself = self;
    list_t(^popitem_func)() = ^list_t(){
        list_t keys = weakself.keys();
        id key = keys[0];
        id obj = weakself[key];
        [weakself removeObjectForKey:key];
        return @[key,obj];
    };
    return [popitem_func copy];
}

-(mdict_t)__mdict__
{
    return self;
}

-(void (^)(dict_t))update
{
    __weak mdict_t weakself = self;
    void(^update_func)(dict_t) = ^(dict_t other){
        [other enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            weakself[key] = obj;
        }];
    };
    return [update_func copy];
}
@end
