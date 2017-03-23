//
//  NSString+GHFundationCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/23.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GHFunctionCode.h"
#import "GHFunctionType.h"

@interface NSString (GHFunctionCode)
PROPER_BLK_DEFINE(split, list_t, c_str);
PROPER_BLK_DEFINE2(replace, str_t, c_str, c_str);
PROPER_BLK_DEFINE_NP(strip, str_t);
PROPER_BLK_DEFINE_NP(lower, str_t);
PROPER_BLK_DEFINE_NP(upper, str_t);
PROPER_BLK_DEFINE(startswith, BOOL, c_str);
PROPER_BLK_DEFINE(endswith, BOOL, c_str);
PROPER_BLK_DEFINE(encode, NSData*,c_str);
PROPER_BLK_DEFINE(find, NSUInteger,c_str);
PROPER_BLK_DEFINE_NP(title, str_t);
PROPER_BLK_DEFINE_NP(splitlines, list_t);
PROPER_BLK_DEFINE(rfind, NSUInteger,c_str);
@end
