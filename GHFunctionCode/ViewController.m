//
//  ViewController.m
//  GHFunctionCode
//
//  Created by YongCheHui on 2017/3/23.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "ViewController.h"
#import "GHFunctionCode.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)testBaseType
{
    int alen = 7;
    int a[] = {100,10,1,30,22,21,9};
    printf("------filter-------\n");
    int r_size = 0;
    int*b = filter_f_int(^BOOL(int value) {
        return value > 10;
    }, a, alen,&r_size);
    for (int i = 0; i < r_size; ++i) {
        printf("%d\n",b[i]);
    }
    free(b);
    
    printf("------map-------\n");
    b = map_f_int(^int(int value) {
        return value+5;
    }, a, alen);
    for (int i = 0; i < alen; ++i) {
        printf("%d\n",b[i]);
    }
    free(b);
    
    printf("------reudce-------\n");
    int c = reduce_f_int(^int(int value, int value2) {
        return value*value2;
    }, a, alen);
    printf("%d\n",c);
}


-(void)testOCType
{
    list_t arrlist = @[@(1),@(2),@(3),@(4),@(5)];
    NSLog(@"%@",sum(arrlist));
    list_t maplist = map(^id(number_t obj) {
        return [NSString stringWithFormat:@"file_name_%d",[obj intValue]];
    }, arrlist);
    NSLog(@"%@",maplist);
    
    list_t filterlist = filter(^BOOL(number_t obj) {
        return [obj intValue]%2;
    }, arrlist);
    NSLog(@"%@",filterlist);
    
    id result = reduce(^id(id obj, id obj2) {
        return [NSString stringWithFormat:@"%@*%@",obj,obj2];
    }, arrlist);
    NSLog(@"%@",result);
    
    str_t joinStr = arrlist.join(",");
    NSLog(@"%@",joinStr);
    
    list_t seplist = joinStr.split(",");
    NSLog(@"%@",seplist);
    
    list_t zip_arr =  zip(@[@"a",@"b",@"c"],@[@(1),@(2),@(3)],nil);
    NSLog(@"%@",zip_arr);
    
    dict_t dict_value = dict(zip_arr);
    NSLog(@"%@",dict_value);
    
    str_t string = str(dict_value);
    NSLog(@"%@",string);
    
    list_t array = list(string);
    NSLog(@"%@",array);
    
    for (number_t i in range(3)) {
        NSLog(@"%@",i);
    }
    NSLog(@"\n");
    
    for (number_t i in range(1,11)) {
        NSLog(@"%@",i);
    }
    NSLog(@"\n");
    
    for (number_t i in range(5,1,-1)) {
        NSLog(@"%@",i);
    }
    NSLog(@"\n");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self testBaseType];
    [self testOCType];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
