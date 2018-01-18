//
//  FourthViewController.m
//  cehuaDemo
//
//  Created by MacHeigh on 2018/1/8.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FourthViewController.h"
#import "Macros.h"
@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详细页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}
- (void)setupUI{
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake((FJWidth-60)/2, (FJHeight-60)/2, 60, 60);
    btn.backgroundColor = FJColor(155, 155, 155, 1);
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)click{
    UIViewController *fvc = [[UIViewController alloc]init];
    //fvc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:fvc animated:YES];
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
