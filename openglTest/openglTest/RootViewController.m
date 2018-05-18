//
//  RootViewController.m
//  openglTest
//
//  Created by linekong on 2018/5/17.
//  Copyright © 2018年 linekong. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
@interface RootViewController ()
@property (nonatomic, strong) ViewController *viewController;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.viewController = [[ViewController alloc] init];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.viewController.view.frame = CGRectMake(0, (size.height-size.width)/2, size.width, size.width);
    [self.view addSubview:self.viewController.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
