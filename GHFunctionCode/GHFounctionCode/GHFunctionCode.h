//
//  GHFunctionCode.h
//  GHFunctionCode
//
//  Created by YongCheHui on 2017/3/23.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#ifndef GHFunctionCode_h
#define GHFunctionCode_h
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GHFunctionType.h"
#import "NSObject+GHFunctionCode.h"
#import "NSString+GHFunctionCode.h"
#import "NSMutableArray+GHFunctionCode.h"
#import "NSArray+GHFunctionCode.h"
#import "NSDictionary+GHFunctionCode.h"
#import "NSMutableDictionary+GHFunctionCode.h"
#import "ReObject.h"

typedef id(^map_blk_t)(id obj);
typedef id(^reduce_blk_t)(id obj,id obj2);
typedef BOOL(^filter_blk_t)(id obj);
static inline list_t map(map_blk_t blk,list_t arr)
{
    mlist_t temp = [NSMutableArray new];
    for (id obj in arr) {
        [temp addObject:blk(obj)];
    }
    return [temp copy];
}

static inline id reduce(reduce_blk_t blk,list_t arr)
{
    if (arr.count < 2) {
        assert(@"数组必须有两个元素以上");
        return nil;
    }
    id temp = arr[0];
    for (int i = 1;i < arr.count;++i) {
        id temp2 = arr[i];
        temp = blk(temp,temp2);
    }
    return temp;
}

static inline list_t filter(filter_blk_t blk,list_t arr)
{
    mlist_t temp = [NSMutableArray new];
    for (id obj in arr) {
        if (blk(obj)) {
            [temp addObject:obj];
        }
    }
    return [temp copy];
}

static inline list_t zip(list_t arr,...){
    va_list args;
    mlist_t temp = [NSMutableArray new];
    va_start(args, arr);
    for (int i = 0; i < arr.count; ++i) {
        [temp addObject:[NSMutableArray new]];
    }
    while (arr) {
        if (arr.count > temp.count) {
            [temp removeLastObject];
        }
        for (int i = 0; i < arr.count; ++i) {
            [temp[i] addObject:arr[i]];
        }
        arr = va_arg(args, id);
    }
    va_end(args);
    return temp;
}

#define CREATE_BASE_TYPE_TRANS_FUNC(type) static inline type type##_(id value){\
return [value __##type##__]; \
}

CREATE_BASE_TYPE_TRANS_FUNC(int);
CREATE_BASE_TYPE_TRANS_FUNC(float);
CREATE_BASE_TYPE_TRANS_FUNC(double);
CREATE_BASE_TYPE_TRANS_FUNC(long);

#define CREATE_BASE_CONTAINER_TRANS_FUNC(type,d_value) static inline type##_t type(id value){\
if(!value)\
{\
    return d_value;\
}\
return [value __##type##__]; \
}

CREATE_BASE_CONTAINER_TRANS_FUNC(list,@[]);
CREATE_BASE_CONTAINER_TRANS_FUNC(str,@"");
CREATE_BASE_CONTAINER_TRANS_FUNC(dict,@{});
CREATE_BASE_CONTAINER_TRANS_FUNC(mlist,[NSMutableArray new]);
CREATE_BASE_CONTAINER_TRANS_FUNC(mdict,[NSMutableDictionary new]);

static inline id sum(id obj)
{
    return [obj __sum__];
}

static inline NSUInteger len(id obj)
{
    return [obj __len__];
}

static inline int ord(char x)
{
    return (int)x;
}

static inline char chr(int x)
{
    return (char)x;
}

static inline str_t hex(int x)
{
    return [NSString stringWithFormat:@"0x%x",x];
}

static inline str_t oct(int x)
{
    return [NSString stringWithFormat:@"0%o",x];
}

static inline str_t bin(int x)
{
    mstr_t string = [@"" mutableCopy];
    while (x)
    {
        [string insertString:(x & 1)? @"1": @"0" atIndex:0];
        x /= 2;
    }
    [string insertString:@"0b" atIndex:0];
    return [string copy];
}


static inline list_t Range_3(int begin,int end,int step)
{
    mlist_t array = [NSMutableArray new];
    int j = begin;
    while (step > 0?j < end:j > end) {
        [array addObject:@(j)];
        if (step > 0) {
            j+= step;
        }
        else
        {
            j-= abs(step);
        }
    }
    return array;
}

static inline list_t Range_2(int a,int b)
{
    int begin = a;
    int end = b;
    int step = 1;
    return Range_3(begin,end,step);
}


static inline list_t Range_1(int a)
{
    return Range_2(0,a);
}

#define GET_FUNCTION_NAME(_1,_2,_3,NAME,...) NAME
#define range(...) GET_FUNCTION_NAME(__VA_ARGS__,Range_3,Range_2,Range_1)(__VA_ARGS__)

typedef int* int_p;
typedef char* char_p;
typedef float* float_p;
typedef double* double_p;
#define MAP_FUNCTION_CREATE(type) static inline type##_p map_f_##type(type(^blk)(type value),type##_p arr,int size){\
if(size == 0)\
{\
return NULL;\
}\
type##_p temp = malloc(sizeof(type)*size); \
for (int i = 0;i < size;++i) \
{   \
temp[i] = blk(arr[i]); \
}\
return temp; \
}

MAP_FUNCTION_CREATE(int);
MAP_FUNCTION_CREATE(float);
MAP_FUNCTION_CREATE(char);
MAP_FUNCTION_CREATE(double);

#define REDUCE_FUNCTION_CREATE(type) static inline type reduce_f_##type(type(^blk)(type value,type value2),type ##_p arr,int size){\
if(size <2)\
{\
 assert(@"数组必须有两个元素以上");\
return -1;\
}\
 type temp = arr[0]; \
for (int i = 1; i < size; ++i) { \
    temp = blk(temp,arr[i]); \
} \
return temp; \
}

REDUCE_FUNCTION_CREATE(int);
REDUCE_FUNCTION_CREATE(float);
REDUCE_FUNCTION_CREATE(double);
REDUCE_FUNCTION_CREATE(char);

#define FILTER_FUNCTION_CREATE(type)  static inline type##_p filter_f_##type(BOOL(^blk)(type value),type##_p arr,int size,int_p r_size){\
    if(size == 0)\
    {\
        return NULL;\
    }\
    type##_p temp = malloc(sizeof(type)); \
    int j = 0;\
    for(int i =0;i < size;++i){ \
           if(blk(arr[i]))\
          { \
                 temp = realloc(temp,sizeof(type)*(j+1)); \
                 temp[j] = arr[i];\
                 j++;\
          } \
   }\
  *r_size = j;\
  return temp; \
}

FILTER_FUNCTION_CREATE(int);
FILTER_FUNCTION_CREATE(double);
FILTER_FUNCTION_CREATE(float);
FILTER_FUNCTION_CREATE(char);
#endif /* GHFunctionCode_h */
