//
//  FJLeftViewController.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/11.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJLeftViewController.h"

@interface FJLeftViewController ()

@end

@implementation FJLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     NSLog(@"viewWillAppear");
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
