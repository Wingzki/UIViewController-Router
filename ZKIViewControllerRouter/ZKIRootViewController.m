//
//  ZKIRootViewController.m
//  ZKIViewControllerRouter
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIRootViewController.h"
#import "ZKISubViewController.h"
#import "ZKIPresentiewController.h"
#import "UIViewController+Router.h"

#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height

static NSString * const KCellNormal = @"CellNormal";

@interface ZKIRootViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerRouterProtocol>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ZKIRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"UIViewController+Router";
    
    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate              = self;
    self.tableView.dataSource            = self;
    self.tableView.rowHeight             = 50;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellNormal];
    
}

- (void)checkParameters {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *textArray = @[@"push", @"present", @"pushWithParameters", @"presentWithParameters", @"pushWithBuilder", @"presentWithBuilder"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellNormal];
    cell.textLabel.text = textArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            
            [self pushToViewControllerWithClassName:@"ZKISubViewController"];
            
            break;
            
        case 1:
            
            [self presentViewControllerWithClassName:@"ZKIPresentiewController"];
            
            break;
            
        case 2:
            
            [self pushToViewControllerWithClassName:@"ZKISubViewController"
                                         parameters:@{@"titleText" : @"pushWithParameters"}];
            
            break;
            
        case 3:
            
            [self presentViewContrllerWithClassName:@"ZKIPresentiewController"
                                         parameters:@{@"titleText" : @"presentWithParameters"}];
            
            break;
            
        case 4:
            
            [self pushToViewControllerWithClass:[ZKISubViewController class] builder:^(UIViewController *builder) {
                
                ZKISubViewController *tempVC = (ZKISubViewController *)builder;
                
                tempVC.titleText = @"pushWithBuilder";
                
            }];
            
            break;
            
        case 5:
            
            [self presentViewControllerWithClass:[ZKIPresentiewController class] builder:^(UIViewController *builder) {
                
                ZKIPresentiewController *tempVC = (ZKIPresentiewController *)builder;
                
                tempVC.titleText = @"pushWithBuilder";
                
            }];
            
            break;
            
        default:
            break;
    }
    
}


@end
