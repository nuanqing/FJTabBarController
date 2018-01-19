//
//  FJLeftViewController.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/11.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJLeftViewController.h"
#import "FourthViewController.h"
#import "SecondViewController.h"
#import "FJTabBarViewController.h"
#import "FJNavgationViewController.h"
#import "FJMainViewController.h"
#import "Macros.h"

static NSString *ideitifier = @"Cell";

@interface FJLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation FJLeftViewController

//手动赋值给self.view大小
- (void)loadView{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(-(fj_leftVCScale/2*FJWidth), 0, fj_leftVCScale*FJWidth, FJHeight);
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"dd");
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ideitifier];
    _tableView.estimatedRowHeight = 50;
    _tableView.tableHeaderView = nil;
}

#pragma mark - UItableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    cell.textLabel.text = @"点击跳转";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //closeLeftVC方法
    FourthViewController *fvc = [[FourthViewController alloc]init];
    FJTabBarViewController *tvc = (FJTabBarViewController *)[self mainViewController].tabBarVC;
    FJNavgationViewController *nvc = tvc.selectedViewController;
    [nvc pushViewController:fvc animated:NO];
    [[self mainViewController]closeLeftVC];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = self.view.bounds;
        NSLog(@"2%@",NSStringFromCGRect(self.view.bounds));
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    
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
