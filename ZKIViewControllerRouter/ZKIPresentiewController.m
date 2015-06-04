//
//  ZKIPresentiewController.m
//  ZKIViewControllerRouter
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIPresentiewController.h"
#import "UIViewController+Router.h"

@interface ZKIPresentiewController () <UIViewControllerRouterProtocol>

@end

@implementation ZKIPresentiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 0, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    if (self.parametersDic) {
        self.titleText = self.parametersDic[@"titleText"];
    }
    
    self.navigationItem.title = self.titleText;
    
}

- (void)checkParameters {
    
    NSAssert(self.titleText, @"titleText没有初始化");
    
}

- (IBAction)cancelButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
