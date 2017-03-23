//
//  NSString+GHFundationCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/23.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSString+GHFunctionCode.h"
#import "NSObject+GHFunctionCode.h"

@implementation NSString (GHFunctionCode)
-(id)__add__:(id)other
{
    return [NSString stringWithFormat:@"%@%@",self,other];
}

-(dict_t)__dict__
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    dict_t dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dict;
}

-(list_t)__list__
{
    str_t string = self;
    mlist_t array = [NSMutableArray new];
    for (int i = 0; i < string.length; ++i) {
        [array addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    return array;
}


-(NSUInteger)__len__
{
    return self.length;
}

-(str_t(^)(c_str,c_str))replace
{
    __weak str_t weakself = self;
    str_t(^replace_func)(c_str,c_str) = ^ str_t(c_str origin,c_str r_str)
    {
        str_t origin_str = [[NSString alloc]initWithCString:origin encoding:NSUTF8StringEncoding];
        str_t replace_str = [[NSString alloc]initWithCString:r_str encoding:NSUTF8StringEncoding];
        return [weakself stringByReplacingOccurrencesOfString:origin_str withString:replace_str];
    };
    return [replace_func copy];
}

-(list_t(^)(c_str))split
{
    __weak str_t weakself = self;
    list_t(^split_func)(c_str) = ^ list_t(c_str sep)
    {
        str_t sepStr = nil;
        if (sep == NULL) {
            sepStr = @"";
        }
        else
        {
            sepStr = [[NSString alloc] initWithCString:sep encoding:NSUTF8StringEncoding];
        }
        return [weakself componentsSeparatedByString:sepStr];
    };
    return [split_func copy];
}

-(str_t(^)())strip
{
    __weak str_t weakself = self;
    str_t(^strip_func)() = ^ str_t
    {
        return [weakself stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    };
    return [strip_func copy];
}

-(str_t(^)())lower
{
    __weak str_t weakself = self;
    str_t(^lower_func)() = ^ str_t
    {
        return [weakself lowercaseString];
    };
    return [lower_func copy];
}

-(str_t(^)())upper
{
    __weak str_t weakself = self;
    str_t(^upper_func)() = ^ str_t()
    {
        return [weakself uppercaseString];
    };
    return [upper_func copy];
}

-(BOOL(^)(c_str))startswith
{
    __weak str_t weakself = self;
    BOOL(^startswith_func)(c_str) = ^ BOOL(c_str startsWith)
    {
        str_t start = [[NSString alloc]initWithCString:startsWith encoding:NSUTF8StringEncoding];
        return [weakself rangeOfString:start].location == 0;
    };
    return [startswith_func copy];
}

-(BOOL(^)(c_str))endswith
{
    __weak str_t weakself = self;
    BOOL(^endswith_func)(c_str) = ^ BOOL(c_str endswith)
    {
        str_t end = [[NSString alloc]initWithCString:endswith encoding:NSUTF8StringEncoding];
        NSRange range = [weakself rangeOfString:end];
        return range.location+range.length == weakself.length;
    };
    return [endswith_func copy];
}

-(NSData*(^)(c_str))encode
{
    __weak str_t weakself = self;
    NSData*(^encode_func)(c_str) = ^ NSData*(c_str encodetype)
    {
        if (strcmp(encodetype, "utf-8")) {
            return [weakself dataUsingEncoding:NSUTF8StringEncoding];
        }
        if (strcmp(encodetype, "utf-16")) {
            return [weakself dataUsingEncoding:NSUTF16StringEncoding];
        }
        if (strcmp(encodetype, "ascii")) {
            return [weakself dataUsingEncoding:NSASCIIStringEncoding];
        }
        if (strcmp(encodetype, "gb2312") || strcmp(encodetype, "gbk") || strcmp(encodetype, "gb18030")) {
            NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            return [weakself dataUsingEncoding:enc];
        }
        return [weakself dataUsingEncoding:NSUTF8StringEncoding];
    };
    return [encode_func copy];
}

-(NSUInteger(^)(c_str))find
{
    __weak str_t weakself = self;
    NSUInteger(^find_func)(c_str) = ^ NSUInteger(c_str find)
    {
        str_t findstr = [[NSString alloc]initWithCString:find encoding:NSUTF8StringEncoding];
        return [weakself rangeOfString:findstr].location;
    };
    return [find_func copy];
}

-(str_t(^)())title
{
    __weak str_t weakself = self;
    str_t(^title_func)() = ^ str_t()
    {
        return [weakself capitalizedString];
    };
    return [title_func copy];
}

-(list_t(^)())splitlines
{
    __weak str_t weakself = self;
    list_t(^splitlines_func)() = ^ list_t()
    {
        return weakself.split("\n");
    };
    return [splitlines_func copy];
}

-(NSUInteger(^)(c_str))rfind
{
    __weak str_t weakself = self;
    NSUInteger(^find_func)(c_str) = ^ NSUInteger(c_str find)
    {
        str_t findstr = [[NSString alloc]initWithCString:find encoding:NSUTF8StringEncoding];
        return [weakself rangeOfString:findstr options:NSBackwardsSearch].location;
    };
    return [find_func copy];
}
@end
