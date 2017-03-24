# GHFunctionCode
根据python语言特点，编写的几个仿照python的api  
  
# list模块  
list_t ---->  NSArray *   
mlist_t ---->  NSMutableArray *   
[目前支持的api]  
-join(str)->str  l      
-append(id)->void  m  
-extend(list_t)->void  m  
-insert(id,int)->void  m  
-pop()->id  m   
-remove(id)->void  m  
-sort(BOOL(^)(id,id))->void m  
-reverse()->void  m  
-swap(int,int)->void  m  

# str模块  
str_t ----> NSString *  
c_str ----> const char *  
[目前支持的api] 
-split(str)->list        
-replace(c_str,c_str)->str    
-strip()->str    
-lower()->str    
-upper()->str     
-startswith(c_str)->BOOL  
-endswith(c_str)->BOOL   
-encode(c_str)->NSData *   
-find(c_str)->NSUInteger   
-rfind(c_str)->NSUInteger   
-title()->str    
-splitlines(str)->list  

# dict模块
dict_t ---->  NSDictionary *   
mdict_t ---->  NSMutableDictionary *  
[目前支持的api]  
-copy_()->dict_t  d
-has_key(c_str)->BOOL d
-keys()->list_t d  
-values()->list_t d  
-items()->list_t d  
-fromkeys(list_t,id)->dict_t  d
-clear()->void  m  
-pop(c_str)->id  m  
-popitem()->list_t  m
-update(dict_t)->void  m  

# obj模块  
obj_t ----> NSObject *  
[目前支持的api]  
-add(id)->id  
-sub(id)->id   
-mul(id)->id     
-div(id)->id     
-and(id)->id     
-or(id)->id   
-pow(int)->id    
-constains(id)->BOOL    
-is(id)->BOOL  
-In(list_t)->BOOL   


# 类型转换函数  
str(id)->str_t  
list(id)->list_t   
dict(id)->dict_t   
mlist(id)->mlist_t   
mdict(id)->mdict_t  

# 集合通用函数  
sum(id)->id  
len(id)->NSUInteger  

# 函数式  
map( id(^)(id) ,list_t)->list_t   
filter( BOOL(^)(id) ,list_t)->list_t  
reduce( id(^)(id,id) ,list_t)->id  
以及基本类型的
map_f_int
filter_f_int
reduce_f_int

map_f_float
filter_f_float
reduce_f_float

map_f_char
filter_f_char
reduce_f_char

map_f_double
filter_f_double
reduce_f_double