//
//  UIViewController+Router.m
//  QYER
//
//  Created by Wingzki on 14/11/3.
//  Copyright (c) 2014年 Wingzki. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

@implementation UIViewController (Router)

static const char *varKey = "parametersDic";

- (NSDictionary *)parametersDic {
    return (NSDictionary *)objc_getAssociatedObject(self, &varKey);
}

- (void)setParametersDic:(NSDictionary *)parametersDic {
    objc_setAssociatedObject(self, &varKey, parametersDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)pushToViewControllerWithClass:(Class)vcClass
                                            builder:(void(^)(UIViewController *builder))block {
    
    if (vcClass) {
        
        id viewController = [[vcClass alloc] init];
        
        if ([viewController isKindOfClass:[UIViewController class]]) {
            
            UIViewController *tempViewController = (UIViewController *)viewController;
            block(tempViewController);
            
            if ([tempViewController respondsToSelector:@selector(checkParameters)]) {
                [tempViewController performSelector:@selector(checkParameters)];
            }
            
            [self.navigationController pushViewController:tempViewController animated:YES];
            
            return tempViewController;
            
        }
        
    }
    
    return nil;
    
}

- (UIViewController *)presentViewControllerWithClass:(Class)vcClass
                                             builder:(void(^)(UIViewController *builder))block {
    
    if (vcClass) {
        
        id viewController = [[vcClass alloc] init];
        
        if ([viewController isKindOfClass:[UIViewController class]]) {
            
            UIViewController *tempViewController = (UIViewController *)viewController;
            block(tempViewController);
            
            if ([tempViewController respondsToSelector:@selector(checkParameters)]) {
                [tempViewController performSelector:@selector(checkParameters)];
            }
            
            return [self presentViewControllerWithVC:tempViewController];
            
        }
        
    }
    
    return nil;
    
}

- (UIViewController *)pushToViewControllerWithClassName:(NSString *)className {
    
    return [self pushToViewControllerWithClassName:className parameters:nil];
    
}

- (UIViewController *)presentViewControllerWithClassName:(NSString *)className {
    
    return [self presentViewContrllerWithClassName:className parameters:nil];
    
}

- (UIViewController *)pushToViewControllerWithClassName:(NSString *)className
                                             parameters:(NSDictionary *)dic {
    
    Class ViewControlerClass = NSClassFromString(className);
    
    if (ViewControlerClass) {
        
        id viewController = [[ViewControlerClass alloc] init];
        
        if ([viewController isKindOfClass:[UIViewController class]]) {
            
            UIViewController *tempViewController = (UIViewController *)viewController;
            tempViewController.parametersDic = dic;
            
            [self.navigationController pushViewController:viewController animated:YES];
            
            return tempViewController;
            
        }
        
    }
    
    return nil;
    
}

- (UIViewController *)presentViewContrllerWithClassName:(NSString *)className
                                             parameters:(NSDictionary *)dic {
    
    Class ViewControlerClass = NSClassFromString(className);
    
    if (ViewControlerClass) {
        
        id viewController = [[ViewControlerClass alloc] init];
        
        if ([viewController isKindOfClass:[UIViewController class]]) {
            
            UIViewController *tempViewController = (UIViewController *)viewController;
            tempViewController.parametersDic = dic;
            
            return [self presentViewControllerWithVC:tempViewController];
            
        }
        
    }
    
    return nil;
    
}

- (void)dismissViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - private

- (UIViewController *)presentViewControllerWithVC:(UIViewController *)viewController {
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (nav && [nav isKindOfClass:[UINavigationController class]]) {
        
        [nav.visibleViewController presentViewController:navigationController animated:YES completion:nil];
        
        return navigationController;
        
    }else {
        
        return nil;
        
    }
    
}

@end
