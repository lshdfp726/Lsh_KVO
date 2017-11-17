//
//  Lsh_KVO.m
//  KVOApplication
//
//  Created by fns on 2017/11/13.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "Lsh_KVO.h"
#import "lsh_Runtime.h"

@interface Lsh_KVO ()
@property (nonatomic, strong, nullable) NSString *OBProperty;//要观察的属性
@property (nonatomic, strong, nullable) NSObject *OB;//要观察的对象
@property (nonatomic, strong, nullable) NSString *attributeDesc;//属性描述，判断OBProperty是什么类型
@property (nonatomic, copy  , nullable) ChangeBlock changeBlock;
@property (nonatomic, assign) BOOL isAllProperty;//是否是观察全部属性 YES 是，NO 不是
@end


@implementation Lsh_KVO
+ (instancetype)LshInstance {
    return [[[self class] alloc] init];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _isAllProperty = NO;
    }
    return self;
}


#pragma mark - 处理被观察的对象和属性
- (instancetype)lshAddObserve:(NSObject *_Nullable)observe property:(NSString *_Nullable)property change:(ChangeBlock)change {
    NSAssert(observe != nil, @"被观察的对象");

    _OB = observe;
    _OBProperty = property;
    _changeBlock = change;
    
    if (property.length == 0 | property == nil) {
        _isAllProperty = YES;
        //obvserve 的属性全部观察
        for (NSString *p in [lsh_Runtime attributeList:[observe class]]) {
            [self addObserver:p];
        }
        return self;
    } else {
        _isAllProperty = NO;
        //判断属性合法性
        if ([self judgeLegal:property]) {
            [self addObserver:property];//添加观察者
            return self;
        } else {
            return nil;
        }
    }
}


#pragma mark - 观察值变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (_isAllProperty) {
        if (_changeBlock) {
            _changeBlock(change[@"new"],keyPath,nil);
        }
    } else {
        if ([keyPath compare:_OBProperty] == 0) {
            if (_changeBlock) {
                _changeBlock(change[@"new"],keyPath,nil);
            }
        }
    }
}


#pragma mark - 判断属性合法性
- (BOOL)judgeLegal:(NSString *)attribute {
    if ([self attributeAttribute]) {
        return YES;
    } else {
        NSLog(@"属性名称%@不是%@属性",attribute,[_OB class]);
        return NO;
    }
}


#pragma mark - 添加观察者
- (void)addObserver:(NSString *)attribute {
    [_OB addObserver:self forKeyPath:attribute options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - 属性分析
- (BOOL)attributeAttribute {
    return [lsh_Runtime attributeAnalyse:_OB attribute:_OBProperty];
}


- (void)dealloc {
    if (_isAllProperty) {//全部属性观察
        for (NSString *p in [lsh_Runtime attributeList:[_OB class]]) {
            [_OB removeObserver:self forKeyPath:p];
        }
    } else {
        if ([self attributeAttribute]) {//如果属性正确就释放，否则不释放会奔溃
            [_OB removeObserver:self forKeyPath:_OBProperty];
        } else {
            
        }
    }
}

@end
