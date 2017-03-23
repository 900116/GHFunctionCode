//
//  NSArray+GHFoundationCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/23.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFunctionType.h"
#import "NSObject+GHFunctionCode.h"

@interface NSArray (GHFunctionCode)
PROPER_BLK_DEFINE(join, str_t, c_str);
@end
