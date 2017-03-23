//
//  NSObject+GHFuctionCode.h
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFunctionType.h"
#define PROPER_BLK_DEFINE(Name,ReturnType,ParamType) \
@property(nonatomic,readonly) ReturnType(^Name)(ParamType value);

#define PROPER_BLK_DEFINE2(Name,ReturnType,ParamType,ParamType2) \
@property(nonatomic,readonly) ReturnType(^Name)(ParamType value,ParamType2 value2);

#define PROPER_BLK_DEFINE_NP(Name,ReturnType) \
@property(nonatomic,readonly) ReturnType(^Name)();

#define PROPER_BLK_FUNC(Name,ReturnType,ParamType) \
-(ReturnType)__##Name##__:(ParamType)value;

#define PROPER_BLK_DEFINE_FUNC(Name,ReturnType,ParamType) \
PROPER_BLK_DEFINE(Name,ReturnType,ParamType)\
PROPER_BLK_FUNC(Name,ReturnType,ParamType)\

#define PROPER_BLK_DEFINEID_ID(Name) PROPER_BLK_DEFINE_FUNC(Name,id,id)
#define PROPER_BLK_DEFINEI_ID(Name) PROPER_BLK_DEFINE_FUNC(Name,id,int)
#define PROPER_BLK_DEFINEID_B(Name) PROPER_BLK_DEFINE_FUNC(Name,BOOL,id)
#define PROPER_BLK_DEFINEA_B(Name) PROPER_BLK_DEFINE_FUNC(Name,BOOL,list_t)

#define PROPER_BLK_GET_FUNC(Name,ReturnType,ParamType,DefaultValue) \
-(ReturnType)__##Name##__:(ParamType)value \
{ \
return DefaultValue; \
} \

#define PROPER_BLK_GET_IMP(Name,ReturnType,ParamType,DefaultValue) \
-(ReturnType(^)(ParamType))Name \
{  \
__weak obj_t weakself = self; \
ReturnType(^Name##_func)(ParamType) = ^ ReturnType(ParamType other)\
{\
if ([weakself respondsToSelector:@selector(__##Name##__:)]) {\
return [weakself __##Name##__:other];\
}\
return DefaultValue;\
};\
return [Name##_func copy];\
}\

#define PROPER_BLK_GET(Name,ReturnType,ParamType,DefaultValue)\
PROPER_BLK_GET_FUNC(Name,ReturnType,ParamType,DefaultValue)\
PROPER_BLK_GET_IMP(Name,ReturnType,ParamType,DefaultValue)\

#define PROPER_BLK_GETID_B(Name) PROPER_BLK_GET(Name,BOOL,id,NO)
#define PROPER_BLK_GETI_ID(Name) PROPER_BLK_GET(Name,id,int,nil)
#define PROPER_BLK_GETID_ID(Name) PROPER_BLK_GET(Name,id,id,nil)
#define PROPER_BLK_GETA_B(Name) PROPER_BLK_GET_IMP(Name,BOOL,list_t,NO)

@interface NSObject (GHFunctionCode)
PROPER_BLK_DEFINEID_ID(add);
PROPER_BLK_DEFINEID_ID(sub);
PROPER_BLK_DEFINEID_ID(mul);
PROPER_BLK_DEFINEID_ID(div);
PROPER_BLK_DEFINEID_ID(and);
PROPER_BLK_DEFINEID_ID(or);
PROPER_BLK_DEFINEI_ID(pow);
PROPER_BLK_DEFINEID_B(contains);
PROPER_BLK_DEFINEID_B(is);
PROPER_BLK_DEFINEA_B(In);
-(str_t)__str__;
-(dict_t)__dict__;
-(list_t)__list__;
-(int)__int__;
-(float)__float__;
-(double)__double__;
-(double)__long__;
-(id)__sum__;
-(NSUInteger)__len__;
@end
