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

typedef id(^map_blk_t)(id obj);
typedef id(^reduce_blk_t)(id obj,id obj2);
typedef BOOL(^filter_blk_t)(id obj);
static inline NSArray* map(map_blk_t blk,NSArray* arr)
{
    NSMutableArray* temp = [NSMutableArray new];
    for (id obj in arr) {
        [temp addObject:blk(obj)];
    }
    return [temp copy];
}

static inline id reduce(reduce_blk_t blk,NSArray* arr)
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

static inline NSArray* filter(filter_blk_t blk,NSArray* arr)
{
    NSMutableArray* temp = [NSMutableArray new];
    for (id obj in arr) {
        if (blk(obj)) {
            [temp addObject:obj];
        }
    }
    return [temp copy];
}

static inline NSArray* zip(NSArray* arr,...){
    va_list args;
    NSMutableArray* temp = [NSMutableArray new];
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

static inline NSString* str(id obj)
{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
        return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return [obj description];
}

static inline NSDictionary* dict(id obj){
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSData *jsonData = [obj dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err) {
            return nil;
        }
        else
        {
            return dict;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray* arr = obj;
        if (arr.count > 0) {
            NSArray* subArray = obj[0];
            if ([subArray isKindOfClass:[NSArray class]]) {
                if (subArray.count == 2) {
                    NSMutableDictionary* dict = [NSMutableDictionary new];
                    for (NSArray* subArray in obj) {
                        [dict setObject:subArray[1] forKey:subArray[0]];
                    }
                    return dict;
                }
                return nil;
            }
            return nil;
        }
        return nil;
    }
    return nil;
}

static inline NSArray* list(id obj)
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString* string = obj;
        NSMutableArray* array = [NSMutableArray new];
        for (int i = 0; i < string.length; ++i) {
            [array addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
        return array;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return [obj allKeys];
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    return nil;
}

static inline int int_(id value)
{
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return -1;
}

static inline float float_(id value)
{
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    return -1;
}

static inline double double_(id value)
{
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return -1;
}


static inline NSArray* Range_3(int begin,int end,int step)
{
    NSMutableArray* array = [NSMutableArray new];
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

static inline NSArray* Range_2(int a,int b)
{
    int begin = a;
    int end = b;
    int step = 1;
    return Range_3(begin,end,step);
}


static inline NSArray* Range_1(int a)
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
