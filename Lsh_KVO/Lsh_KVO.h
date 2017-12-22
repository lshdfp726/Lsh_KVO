//
//  Lsh_KVO.h
//  KVOApplication
//
//  Created by fns on 2017/11/13.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChangeBlock)(id _Nullable changeValue,NSString * _Nullable keyPath ,id _Nullable old);

@interface Lsh_KVO : NSObject
+ (instancetype _Nullable)LshInstance;

/**
 * observe 被观察的类
 * property 被观察的属性,如果属性名称不正确，不会引起崩溃，只会让观察者失去效果
 * change block 传值
 */
- (instancetype _Nullable )lshAddObserve:(NSObject *_Nullable)observe property:(NSString *_Nullable)property change:(ChangeBlock _Nullable )change;

@end
