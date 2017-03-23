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

-(void)testStr
{
    str_t str = @"abcdef";
    str = str.upper();
    str = str.lower();
    
    str = @"i have a dream";
    str = str.title();
    list_t list = str.split(",");
    NSLog(@"%@",list);
    NSLog(@"%d",str.startswith("I"));
    NSLog(@"%d",str.endswith("Dream"));
    int pos = str.find("A");
    str = @"   abc    ";
    str = str.strip();
    str = str.replace("a","x");
}

-(void)testList
{
    
    list_t arrlist = @[@(1),@(2),@(3),@(4),@(5)];
    NSLog(@"%@",sum(arrlist));
    NSLog(@"%ld",len(arrlist));
    
    str_t joinStr = arrlist.join(",");
    NSLog(@"%@",joinStr);
    
    mlist_t mlist = [arrlist mutableCopy];
    mlist.append(@(9));
    mlist.extend(arrlist);
    mlist.insert(@(22),1);
    mlist.remove(@(2));
    mlist.pop();
    mlist.reverse();
    mlist.sort(NULL);
    mlist.swap(3,5);
    
    list_t a = @[@(1),@(2),@(3)];
    list_t b = @[@(3),@(5),@(6)];
    list_t c = a.add(b);
    list_t d = a.sub(b);
    list_t e = a.and(b);
    list_t f = a.or(b);
}

-(void)testDict
{
    dict_t d = [NSDictionary new];
    dict_t d2 = d.copy_();
    d2 = @{@"a":@(5)};
    BOOL haskey = d2.has_key("a");
    list_t keys = d2.keys();
    list_t values = d2.values();
    list_t items = d2.items();
    dict_t d3 = d2.fromkeys(@[@"d",@"e",@"f"],nil);
    
    mdict_t md = [NSMutableDictionary new];
    md[@"hello"] = @"你好";
    md[@"abc"] = @"唉比赛";
    md[@"hey"] = @"嗨";
    id value = md.pop("abc");
    list_t l = md.popitem();
    md[@"abc"] = @"唉比赛";
    md[@"hey"] = @"嗨";
    dict_t md2 = md.copy_();
    md.clear();
    md.update(md2);
}


-(void)testTypeTrans
{
    list_t zip_arr =  zip(@[@"a",@"b",@"c"],@[@(1),@(2),@(3)],nil);
    NSLog(@"%@",zip_arr);
    
    dict_t dict_value = dict(zip_arr);
    NSLog(@"%@",dict_value);
    
    str_t string = str(dict_value);
    NSLog(@"%@",string);
    
    list_t array = list(string);
    NSLog(@"%@",array);
    
    str_t oct_v = oct(57);
    str_t hex_v = hex(57);
    str_t bin_v = bin(57);
    int x = ord('A');
    char y = chr(x);
}

-(void)testRange{
    
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

-(void)testfunctionCode
{
    list_t arrlist = @[@(1),@(2),@(3),@(4),@(5)];
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
}

-(void)testOCType
{
    [self testfunctionCode];
    [self testStr];
    [self testList];
    [self testDict];
    [self testTypeTrans];
    [self testRange];
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
