//
//  NSDictionary+PropertyCode.h
//  07-Runtime(字典转模型KVC实现)
//
//  Created by 1 on 15/12/26.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PropertyCode)

// 生成属性代码
- (void)propertyCode;

@end
