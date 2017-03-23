//
//  NSObject+GHFuctionCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSObject+GHFunctionCode.h"

@implementation NSObject (GHFunctionCode)
PROPER_BLK_GETID_ID(add);
PROPER_BLK_GETID_ID(sub);
PROPER_BLK_GETID_ID(mul);
PROPER_BLK_GETID_ID(div);
PROPER_BLK_GETID_ID(and);
PROPER_BLK_GETID_ID(or);
PROPER_BLK_GETI_ID(pow);
PROPER_BLK_GETID_B(contains);
PROPER_BLK_GETA_B(In);
PROPER_BLK_GET_IMP(is, BOOL, id, NO)
-(str_t)__str__
{
    return [self description];
}

-(list_t)__list__
{
    return @[self];
}

-(dict_t)__dict__
{
    return nil;
}

-(int)__int__
{
    return (int)self;
}

-(float)__float__
{
    id value = self;
    if ([value respondsToSelector:@selector(floatValue)]) {
       return [value floatValue];
    }
    return 0.0f;
}

-(double)__double__
{
    id value = self;
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return 0.0;
}

-(double)__long__
{
    id value = self;
    if ([value respondsToSelector:@selector(longValue)]) {
        return [value longValue];
    }
    return (long)self;
}

-(id)__sum__
{
    return nil;
}

-(NSUInteger)__len__
{
    return 0;
}

-(BOOL)__In__:(list_t)value
{
    return [value containsObject:self];
}

-(BOOL)__is__:(id)value
{
    return [self isEqual:value];
}
@end
