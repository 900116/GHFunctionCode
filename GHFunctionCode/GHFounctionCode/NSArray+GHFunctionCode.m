//
//  NSArray+GHFoundationCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/23.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSArray+GHFunctionCode.h"
#import "NSObject+GHFunctionCode.h"
#import "GHFunctionCode.h"

@implementation NSArray (GHFunctionCode)

-(id)__add__:(id)value
{
    if ([value isKindOfClass:[NSArray class]]) {
        return [self arrayByAddingObjectsFromArray:value];
    }
    return [self arrayByAddingObject:value];
}

-(id)__sub__:(id)value
{
    mlist_t array = [self mutableCopy];
    for (id obj in value) {
        if (array.contains(obj)) {
            array.remove(obj);
        }
    }
    return array;
}

-(dict_t)__dict__
{
    list_t arr = self;
    if (arr.count > 0) {
        list_t subArray = arr[0];
        if ([subArray isKindOfClass:[NSArray class]]) {
            if (subArray.count == 2) {
                mdict_t dict = [NSMutableDictionary new];
                for (list_t subArray in arr) {
                    [dict setObject:subArray[1] forKey:subArray[0]];
                }
                return dict;
            }
            return nil;
        }
        return nil;
    }
    return nil;
}

-(list_t)__list__
{
    return self;
}

-(mlist_t)__mlist__{
    return [self mutableCopy];
}


-(id)__sum__
{
    if (self.count == 0) {
        return nil;
    }
    if (self.count == 1) {
        return self[0];
    }
    obj_t sum = self[0];
    for (int i = 1; i < self.count; ++i) {
        sum = sum.add(self[i]);
    }
    return sum;
}

-(id)__and__:(id)value
{
    mlist_t result = [NSMutableArray new];
    list_t array = self;
    for (id obj in value) {
        if (array.contains(obj)) {
            result.append(obj);
        }
    }
    return result;
}

-(id)__or__:(id)value
{
    mlist_t m = [self mutableCopy];
    for (id  obj in value) {
        if (!m.contains(obj)) {
            m.append(obj);
        }
    }
    return [m copy];
}

-(NSUInteger)__len__
{
    return self.count;
}

-(BOOL)__contains__:(id)value
{
    return [self containsObject:value];
}

-(str_t(^)(c_str))join
{
    __weak list_t weakself = self;
    str_t(^join_func)(c_str) = ^ str_t(c_str sep)
    {
        str_t sepStr = nil;
        if (sep == NULL) {
            sepStr = @"";
        }
        else
        {
            sepStr = [[NSString alloc] initWithCString:sep encoding:NSUTF8StringEncoding];
        }
        return [weakself componentsJoinedByString:sepStr];
    };
    return [join_func copy];
}
@end
