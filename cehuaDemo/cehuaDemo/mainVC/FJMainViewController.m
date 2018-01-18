//
//  FJMainViewController.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/11.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJMainViewController.h"
#import "FJTabBarViewController.h"
#import "FJLeftViewController.h"
#import "Macros.h"

@interface FJMainViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) FJTabBarViewController *tabBarVC;
@property (nonatomic,strong) FJLeftViewController *leftVC;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) CGPoint currentPoint;
@property (nonatomic,assign) CGPoint changedPoint;

@end

@implementation FJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    if (fj_shadowEffect) {
        [self setupShadow];
    }
    [self setupRecognizer];
}

#pragma mark - UI

- (void)setupUI{
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.tabBarVC.view];
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.tabBarVC];
    [self.view addSubview:self.maskView];
}

- (void)setupShadow{
    self.tabBarVC.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBarVC.view.layer.shadowOpacity = 0;
    self.tabBarVC.view.layer.shadowOffset = CGSizeMake(-4, 2);
}

#pragma mark - 手势

-(void)setupRecognizer{
    self.panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftMenu:)];
    [self.view addGestureRecognizer:_panRecognizer];
    self.tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeLeftVC)];
    [self.maskView addGestureRecognizer:self.tapRecognizer];
}

#pragma mark - 手势方法

- (void)leftMenu:(UIPanGestureRecognizer *)panRecognizer{
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        self.currentPoint = [panRecognizer locationInView:self.view];
        _leftVC.view.hidden = NO;
        _maskView.hidden = NO;
        if (fj_shadowEffect) {
            _tabBarVC.view.layer.shadowOpacity = 1;
        }
    }
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        self.changedPoint = [panRecognizer locationInView:self.view];
        if (!_isOpendLeftVC) {
            CGFloat pointX = _changedPoint.x - _currentPoint.x;
            if (pointX <= 0) {
                return;
            }
            if (pointX > fj_leftVCScale*FJWidth) {
                pointX = fj_leftVCScale*FJWidth;
            }
            _leftVC.view.center = CGPointMake(pointX/2, self.view.center.y);
            _tabBarVC.view.center = CGPointMake(self.view.center.x+pointX, self.view.center.y);
            _maskView.alpha = fj_maskScale * pointX/(fj_leftVCScale*FJWidth);
            _maskView.frame = CGRectMake(pointX, 0, FJWidth-pointX, FJHeight);
        }else{
            CGFloat pointX = _currentPoint.x - _changedPoint.x;
            if (pointX <= 0) {
                return;
            }
            if (pointX > fj_leftVCScale*FJWidth) {
                pointX = fj_leftVCScale*FJWidth;
            }
            _leftVC.view.center = CGPointMake((fj_leftVCScale*FJWidth-pointX)/2, self.view.center.y);
            _tabBarVC.view.center = CGPointMake(self.view.center.x+fj_leftVCScale*FJWidth-pointX, self.view.center.y);
            _maskView.alpha =fj_maskScale - (fj_maskScale * pointX/(fj_leftVCScale*FJWidth));
            _maskView.frame = CGRectMake(fj_leftVCScale*FJWidth - pointX, 0,(FJWidth - (fj_leftVCScale*FJWidth)) + pointX, FJHeight);
        }
       
    }
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        self.changedPoint = [panRecognizer locationInView:self.view];
        if (!_isOpendLeftVC) {
            if (_tabBarVC.view.center.x-self.view.center.x > FJWidth*fj_leftVPopCScale) {
                [self showLeftVC];
            }else{
                [self closeLeftVC];
            }
        }else{
            if (self.view.center.x+fj_leftVCScale*FJWidth-_tabBarVC.view.center.x < FJWidth*fj_leftVPopCScale) {
                [self showLeftVC];
            }else{
                [self closeLeftVC];
            }
        }
        
    }
}



#pragma mark - 推入推出

- (void)showLeftVC{
    _leftVC.view.hidden = NO;
    _maskView.hidden = NO;
    if (fj_shadowEffect) {
        _tabBarVC.view.layer.shadowOpacity = 1;
    }
    [UIView animateWithDuration:fj_animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _leftVC.view.center = CGPointMake(fj_leftVCScale/2*FJWidth, self.view.center.y);
        _tabBarVC.view.center = CGPointMake(self.view.center.x+fj_leftVCScale*FJWidth, self.view.center.y);
        _maskView.alpha = fj_maskScale;
        _maskView.frame = CGRectMake(fj_leftVCScale*FJWidth, 0, FJWidth-fj_leftVCScale*FJWidth, FJHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            _isOpendLeftVC = YES;
        }
    }];
   
   
}

- (void)closeLeftVC{
   
    [UIView animateWithDuration:fj_animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _tabBarVC.view.center = CGPointMake(self.view.center.x, self.view.center.y);
        _maskView.alpha = 0;
        _maskView.frame = CGRectMake(0, 0, FJWidth, FJHeight);
    }completion:^(BOOL finished) {
        if (finished) {
            _leftVC.view.center = CGPointMake(0, self.view.center.y);
            _isOpendLeftVC = NO;
            _leftVC.view.hidden = YES;
            _maskView.hidden = YES;
            if (fj_shadowEffect) {
                _tabBarVC.view.layer.shadowOpacity = 0;
            }
        }
    }];
    
   
}

#pragma mark - 懒加载

- (FJTabBarViewController *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = [[FJTabBarViewController alloc]init];
        _tabBarVC.view.frame = self.view.bounds;
    }
    return _tabBarVC;
}

- (FJLeftViewController *)leftVC{
    if (!_leftVC) {
        _leftVC = [[FJLeftViewController alloc]init];
        _leftVC.view.frame = CGRectMake(-fj_leftVCScale/2*FJWidth, 0, fj_leftVCScale*FJWidth, FJHeight);
        _leftVC.view.hidden = YES;
    }
    return _leftVC;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView=[[UIView alloc]init];
        _maskView.frame = self.view.frame;
        _maskView.backgroundColor = FJColor(128, 128, 128, fj_maskScale);
        _maskView.hidden = YES;
        _maskView.alpha = 0;
    }
    return _maskView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation UIViewController (FJMainViewController)

- (FJMainViewController *)mainViewController{
    UIViewController *parent = self;
    Class mainClass = [FJMainViewController class];
    while ( nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:mainClass] ) {}
    return (id)parent;
}

@end



