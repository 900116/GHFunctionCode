//
//  NSMutableArray+GHFunctionCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFunctionType.h"
#import "NSObject+GHFunctionCode.h"

@interface NSMutableArray (GHFunctionCode)
PROPER_BLK_DEFINE(append,void, id);
PROPER_BLK_DEFINE(extend,void, list_t);
PROPER_BLK_DEFINE2(insert,void, id,int);
PROPER_BLK_DEFINE_NP(pop, id);
PROPER_BLK_DEFINE(remove, void,id);
typedef BOOL(^cmpBlk)(id obj,id obj2);
PROPER_BLK_DEFINE(sort,void,cmpBlk);
PROPER_BLK_DEFINE_NP(reverse, void);
PROPER_BLK_DEFINE2(swap, void,int,int);
@end
