//
//  NSMutableDictionary+GHFunctionCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFunctionType.h"
#import "NSObject+GHFunctionCode.h"

@interface NSMutableDictionary (GHFunctionCode)
PROPER_BLK_DEFINE_NP(clear, void);
PROPER_BLK_DEFINE(pop, id,c_str);
PROPER_BLK_DEFINE_NP(popitem, list_t);
PROPER_BLK_DEFINE(update, void,dict_t);
@end
