//
//  UIViewController+Router.h
//  QYER
//
//  Created by Wingzki on 14/11/3.
//  Copyright (c) 2014年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerRouterProtocol <NSObject>

@optional

/**
 *  用于检查必须的属性是否已经正确初始化
 */
- (void)checkParameters;

@end

@interface UIViewController (Router)
/**
 *  参数字典
 */
@property (nonatomic, strong) NSDictionary *parametersDic;

/**
 *  以建造者模式创建并Push页面
 *
 *  @param vcClass VC类
 *  @param block   对应类属性初始换block
 *
 *  @return 初始化好的VC
 */
- (UIViewController *)pushToViewControllerWithClass:(Class)vcClass
                                            builder:(void(^)(UIViewController *builder))block;

/**
 *  以建造者模式创建并present页面
 *
 *  @param vcClass VC类
 *  @param block   对应类属性初始换block
 *
 *  @return 初始化好的VC
 */
- (UIViewController *)presentViewControllerWithClass:(Class)vcClass
                                             builder:(void(^)(UIViewController *builder))block;

- (UIViewController *)pushToViewControllerWithClassName:(NSString *)className;
- (UIViewController *)presentViewControllerWithClassName:(NSString *)className;

/**
 *  以push的形式进行页面导航
 *
 *  @param className 下一级页面的类名
 *  @param dic       参数字典, 页面类需引用本Category
 */
- (UIViewController *)pushToViewControllerWithClassName:(NSString *)className
                                             parameters:(NSDictionary *)dic;

/**
 *  以present的形式进行页面导航
 *
 *  @param className 下一级页面的类名
 *  @param dic       参数字典, 页面类需引用本Category
 */
- (UIViewController *)presentViewContrllerWithClassName:(NSString *)className
                                             parameters:(NSDictionary *)dic;

/**
 *  Dismiss当前显示在前台的模态页面
 */
- (void)dismissViewController;

@end
