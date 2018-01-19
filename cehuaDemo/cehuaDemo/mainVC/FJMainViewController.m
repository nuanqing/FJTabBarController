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
#import "FJNavgationViewController.h"
#import "Macros.h"

@interface FJMainViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) CGPoint currentPoint;
@property (nonatomic,assign) CGPoint changedPoint;

@end

@implementation FJMainViewController

- (instancetype)initWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC{
    if (self = [super init]) {
        [self setLeftVC:leftVC];
        [self setTabBarVC:mainVC];
        [self.view addSubview:self.maskView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (fj_shadowEffect) {
        [self setupShadow];
    }
    [self setupRecognizer];
}

#pragma mark - 初始化

- (void)setLeftVC:(UIViewController *)leftVC{
    _leftVC = leftVC;
    [self addchildController:_leftVC];
    _leftVC.view.hidden = YES;
    _leftVC.view.frame = CGRectMake(-(fj_leftVCScale/2*FJWidth), 0, fj_leftVCScale*FJWidth, FJHeight);
}

- (void)setTabBarVC:(UIViewController *)tabBarVC{
    _tabBarVC = tabBarVC;
    [self addchildController:_tabBarVC];
     _tabBarVC.view.frame = self.view.bounds;
}

- (void)addchildController:(UIViewController *)childController{
    [childController beginAppearanceTransition:NO animated:NO];
    [childController.view removeFromSuperview];
    [childController endAppearanceTransition];
    [childController willMoveToParentViewController:nil];
    [childController removeFromParentViewController];
    [self.view addSubview:childController.view];
    [self addChildViewController:childController];
}

#pragma mark - 阴影效果

- (void)setupShadow{
    self.tabBarVC.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBarVC.view.layer.shadowOpacity = 0;
    self.tabBarVC.view.layer.shadowOffset = CGSizeMake(-10, 0);
}

#pragma mark - 手势

-(void)setupRecognizer{
    self.panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftMenu:)];
    [self.view addGestureRecognizer:_panRecognizer];
    self.tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewTap)];
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

- (void)maskViewTap{
    [self closeLeftVCWithAnimationTime:fj_animationTime isLeftVCCenterMove:YES isHiddenMaskView:NO isHaveShadow:YES];
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
    [self closeLeftVCWithAnimationTime:0.28 isLeftVCCenterMove:NO isHiddenMaskView:YES isHaveShadow:NO];
}


- (void)closeLeftVCWithAnimationTime:(NSTimeInterval)time isLeftVCCenterMove:(BOOL)isMove isHiddenMaskView:(BOOL)isHidden isHaveShadow:(BOOL)isShadow{
    if (!isShadow) {
          _tabBarVC.view.layer.shadowOpacity = 0;
    }
    if (isHidden) {
        _maskView.hidden = YES;
        _maskView.alpha = 0;
        _maskView.frame = CGRectMake(0, 0, FJWidth, FJHeight);
        
    }
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _tabBarVC.view.center = CGPointMake(self.view.center.x, self.view.center.y);
        if (isMove) {
             _leftVC.view.center = CGPointMake(0, self.view.center.y);
        }
        if (!isHidden) {
            _maskView.alpha = 0;
            _maskView.frame = CGRectMake(0, 0, FJWidth, FJHeight);
        }
    }completion:^(BOOL finished) {
        if (finished) {
            _isOpendLeftVC = NO;
            _leftVC.view.hidden = YES;
            if (!isHidden) {
                _maskView.hidden = YES;
            }
            if (fj_shadowEffect) {
                _tabBarVC.view.layer.shadowOpacity = 0;
            }
        }
    }];
    
   
}

#pragma mark - 懒加载

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



