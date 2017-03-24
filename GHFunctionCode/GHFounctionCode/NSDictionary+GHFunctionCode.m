//
//  NSDictionary+GHFunctionCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSDictionary+GHFunctionCode.h"
#import "GHFunctionCode.h"

@implementation NSDictionary (GHFunctionCode)
-(id)__add__:(id)value
{
    mdict_t m = [self mutableCopy];
    m.update(value);
    return [m copy];
}

-(id)__or__:(id)value
{
    return [self __add__:value];
}

-(id)__and__:(dict_t)value
{
    return [self dictionaryWithValuesForKeys:self.keys().and(value.keys())];
}

-(id)__sub__:(mdict_t)value
{
    mdict_t m = [self mutableCopy];
    list_t allkey = value.keys();
    list_t final = allkey.and(value.keys());
    [m removeObjectsForKeys:final];
    return m;
}

-(dict_t)__dict__
{
    return self;
}

-(list_t)__list__
{
    return [self allKeys];
}

-(mdict_t)__mdict__
{
    return [self mutableCopy];
}

-(mlist_t)__mlist__{
    return [[self __list__] mutableCopy];
}

-(str_t)__str__
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}


-(NSUInteger)__len__
{
    return self.count;
}

-(BOOL)__In__:(id)value
{
    return [self.allKeys containsObject:value];
}

-(dict_t (^)())copy_
{
    __weak dict_t weakself = self;
    dict_t(^copy_func)() = ^dict_t{
        return (dict_t)[weakself copy];
    };
    return [copy_func copy];
}

-(BOOL (^)(c_str))has_key
{
    __weak dict_t weakself = self;
    BOOL(^has_func)(c_str) = ^BOOL(c_str key){
        str_t key_str = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
        return weakself.allKeys.contains(key_str);
    };
    return [has_func copy];
}

-(list_t (^)())keys
{
    __weak dict_t weakself = self;
    list_t(^keys_func)() = ^list_t{
        return [weakself allKeys];
    };
    return [keys_func copy];
}

-(list_t (^)())values
{
    __weak dict_t weakself = self;
    list_t(^values_func)() = ^list_t{
        return [weakself allValues];
    };
    return [values_func copy];
}

-(list_t (^)())items
{
    __weak dict_t weakself = self;
    list_t(^items_func)() = ^list_t{
        mlist_t m = [NSMutableArray new];
        [weakself enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            m.append(@[key,obj]);
        }];
        return m;
    };
    return [items_func copy];
}

-(dict_t (^)(list_t, id))fromkeys
{
    __weak dict_t weakself = self;
    dict_t(^fromkeys_func)(list_t,id) = ^dict_t(list_t keys,id value){
        mdict_t m = [weakself mutableCopy];
        if (!value) {
            value = [NSNull null];
        }
        for (id key in keys) {
            m[key] = value;
        }
        return [m copy];
    };
    return [fromkeys_func copy];
}

@end
