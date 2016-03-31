//
//  NSDictionary+PropertyCode.m
//  07-Runtime(字典转模型KVC实现)
//
//  Created by 1 on 15/12/26.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "NSDictionary+PropertyCode.h"

/**
    1.自动生成类
    2.如果有数组,搞个泛型占位符
 
 */

// isKindOfClass"判断是否是当前类或者他的子类
@implementation NSDictionary (PropertyCode)

- (void)propertyCode
{
    NSMutableString *propertyCode = [NSMutableString string];
    
    // 根据字典生成对应的属性代码
    // 遍历字典中所有key,生成对应的属性代码
    [self enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *code ;
        // 判断真实类型,才能确定属性代码
        if ([value isKindOfClass:[NSString class]]) {
           code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSString *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]){
             code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSDictionary *%@;",key];
        } else if ([value isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property(nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property(nonatomic, assign) NSInteger %@;",key];
        }
        
        // 拼接一次
        [propertyCode appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",propertyCode);
}
@end
