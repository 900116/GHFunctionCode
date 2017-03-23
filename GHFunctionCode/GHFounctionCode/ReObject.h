//
//  ReObject.h
//  GHFunctionCode
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFunctionCode.h"
#define re [ReObject obj]

@interface ReObject : NSObject
+(instancetype)obj;
PROPER_BLK_DEFINE2(findall, list_t, c_str,c_str);
@end
