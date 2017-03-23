//
//  NSNumber+GHFuctionCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSNumber+GHFuctionCode.h"

@implementation NSNumber (GHFuctionCode)
-(id)__add__:(id)value
{
    return @([self doubleValue] + [value doubleValue]);
}

-(id)__sub__:(id)value
{
    return @([self doubleValue] + [value doubleValue]);
}

-(id)__mul__:(id)value
{
    return @([self doubleValue] * [value doubleValue]);
}

-(id)__div__:(id)value
{
    return @([self doubleValue] / [value doubleValue]);
}

-(id)__pow__:(int)x
{
    return @(pow([self doubleValue], x));
}
@end
