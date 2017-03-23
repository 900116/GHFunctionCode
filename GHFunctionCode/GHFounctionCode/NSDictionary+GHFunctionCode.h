//
//  NSDictionary+GHFunctionCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GHFunctionCode.h"

@interface NSDictionary (GHFunctionCode)
PROPER_BLK_DEFINE_NP(copy_, dict_t);
PROPER_BLK_DEFINE(has_key, BOOL, c_str);
PROPER_BLK_DEFINE_NP(keys, list_t);
PROPER_BLK_DEFINE_NP(values, list_t);
PROPER_BLK_DEFINE_NP(items, list_t);
PROPER_BLK_DEFINE2(fromkeys, dict_t,list_t,id);
@end
