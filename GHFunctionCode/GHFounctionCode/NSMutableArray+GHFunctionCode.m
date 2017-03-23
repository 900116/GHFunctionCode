//
//  NSMutableArray+GHFunctionCode.m
//  TEST
//
//  Created by ZhaoGuangHui on 17/3/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSMutableArray+GHFunctionCode.h"
#import "GHFunctionCode.h"

@implementation NSMutableArray (GHFunctionCode)
-(void(^)(id))append
{
    __weak mlist_t weakself = self;
    void(^append_func)(id) = ^(id obj)
    {
        [weakself addObject:obj];
    };
    return [append_func copy];
}

-(void(^)(list_t))extend
{
    __weak mlist_t weakself = self;
    void(^extend_func)(list_t) = ^(list_t obj)
    {
        [weakself addObjectsFromArray:obj];
    };
    return [extend_func copy];
}

-(void(^)(id,int))insert
{
    __weak mlist_t weakself = self;
    void(^insert_func)(id,int) = ^(id obj,int index)
    {
        [weakself insertObject:obj atIndex:index];
    };
    return [insert_func copy];
}

-(id(^)())pop
{
    __weak mlist_t weakself = self;
    id(^pop_func)() = ^id
    {
        id obj = [weakself lastObject];
        [weakself removeLastObject];
        return obj;
    };
    return [pop_func copy];
}


-(void(^)(id))remove
{
    __weak mlist_t weakself = self;
    void(^remove_func)(id) = ^(id obj)
    {
        [weakself removeObject:obj];
    };
    return [remove_func copy];
}

-(void(^)(cmpBlk))sort
{
    __weak mlist_t weakself = self;
    void(^sort_func)(cmpBlk) = ^(cmpBlk blk)
    {
        if (!blk) {
            [weakself sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return obj1 > obj2;
            }];
        }
        else
        {
            [weakself sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return blk(obj1,obj2);
            }];
        }
    };
    return [sort_func copy];
}

-(void(^)(int,int))swap
{
    __weak mlist_t weakself = self;
    void(^swap_func)(int,int) = ^(int idx1,int idx2)
    {
        [weakself exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    };
    return [swap_func copy];
}

-(void(^)())reverse
{
    __weak mlist_t weakself = self;
    void(^reverse_func)() = ^
    {
        int lens = (int)len(weakself);
        for (int i = 0; i < lens/2+1;++i) {
            weakself.swap(i,lens-i-1);
        }
    };
    return [reverse_func copy];
}
@end
