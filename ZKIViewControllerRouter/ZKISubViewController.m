//
//  ZKISubViewController.m
//  ZKIViewControllerRouter
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKISubViewController.h"
#import "UIViewController+Router.h"

@interface ZKISubViewController () <UIViewControllerRouterProtocol>

@end

@implementation ZKISubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (self.parametersDic) {
        self.titleText = self.parametersDic[@"titleText"];
    }
    
    self.navigationItem.title = self.titleText;
    
}

- (void)checkParameters {
    
    NSAssert(self.titleText, @"titleText没有初始化");
    
}

@end
