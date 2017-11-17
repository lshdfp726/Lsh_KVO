//
//  lsh_Runtime.h
//  KVOApplication
//
//  Created by fns on 2017/11/13.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface lsh_Runtime : NSObject
/**
 判断propertyName是否是obj的属性
 * obj 要分析的对象
 * propertyName 要分析的对象属性
 */

+ (BOOL)attributeAnalyse:(NSObject *)obj attribute:(NSString *)propertyName;//

/**
 * 返回cls的属性列表
 */
+ (NSArray *)attributeList:(Class)cls;
@end
