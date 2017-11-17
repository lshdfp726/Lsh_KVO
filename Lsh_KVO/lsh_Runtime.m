//
//  lsh_Runtime.m
//  KVOApplication
//
//  Created by fns on 2017/11/13.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "lsh_Runtime.h"
#import <objc/runtime.h>
/**
switch (type[1]) {
    case 'B'://布尔值
        result = @"BOOL";
        break;
    case '@'://对象
        result = @"Object";
    default:
        break;
}
*/

@implementation lsh_Runtime

//属性分析
+ (BOOL)attributeAnalyse:(NSObject *)obj attribute:(NSString *)propertyName {
    BOOL flag = NO;
    NSArray *list = [self attributeList:[obj class]];

    for (NSString *p in list) {
        if ([p compare:propertyName] == 0) {
            flag = YES;
        }
    }
    return flag;
}


+ (NSArray *)attributeList:(Class)cls {
    unsigned int count = 0;
    objc_property_t *array =  class_copyPropertyList(cls, &count);
    NSMutableArray *result = [NSMutableArray array];
    for (unsigned int i  = 0; i < count; i ++) {
        objc_property_t p = array[i];
        const char *name = property_getName(p);
        NSString *ocName = [NSString stringWithFormat:@"%s",name];
        [result addObject:ocName];
    }
    return [NSArray arrayWithArray:result];
}

@end
