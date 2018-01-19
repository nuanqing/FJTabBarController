//
//  FJHeaderView.m
//  cehuaDemo
//
//  Created by MacBook on 2018/1/19.
//  Copyright © 2018年 MacHeigh. All rights reserved.
//

#import "FJHeaderView.h"
#import "Macros.h"

@interface FJHeaderView()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) CAShapeLayer *firstShapeLayer;
@property (nonatomic,strong) CAShapeLayer *secondShapeLayer;
@property (nonatomic,strong) CADisplayLink *displayLink;
@property (nonatomic,assign) CGFloat offsetX;
@property (nonatomic,assign) CGFloat offsetXT;
@property (nonatomic,assign) CGFloat waveSpeed;
@property (nonatomic,assign) CGFloat waveHeight;
@property (nonatomic,assign) CGFloat waveWidth;
@property (nonatomic,assign) CGFloat waveAmplitude;

@end

@implementation FJHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProperty];
        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化

- (void)setupProperty{
    self.offsetX = 0;
    self.offsetXT = 20;
    self.waveSpeed = 2;
    self.waveHeight = self.frame.size.height/7*6;
    self.waveWidth = self.frame.size.width;
    self.waveAmplitude = 8;
}

- (void)setupUI{
    [self.layer addSublayer:self.firstShapeLayer];
    [self.layer addSublayer:self.secondShapeLayer];
    [self addSubview:self.imageView];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)wave{
    [self firstShapeLayerWave];
    [self secondShapeLayerWave];
}

- (void)firstShapeLayerWave{
    self.offsetX += self.waveSpeed;
    //声明第一条波曲线的路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始点
    CGPathMoveToPoint(path, nil, 0, self.waveHeight);
    CGFloat y = 0.f;
    for (float x = 0.f; x<=self.waveWidth; x++) {
        y = self.waveAmplitude * sin((300 / self.waveWidth) * (x * M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //把绘图信息添加到路径里
    CGPathAddLineToPoint(path, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    //结束绘图信息
    CGPathCloseSubpath(path);
    
    self.firstShapeLayer.path = path;
    //释放绘图路径
    CGPathRelease(path);
}

- (void)secondShapeLayerWave{
    self.offsetXT += self.waveSpeed;
    CGMutablePathRef pathT = CGPathCreateMutable();
    CGPathMoveToPoint(pathT, nil,0, self.waveHeight);
    
    CGFloat yT = 0.f;
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        yT = self.waveAmplitude*1.3 * sin((280 / self.waveWidth) * (x * M_PI / 180) - self.offsetXT * M_PI / 180) + self.waveHeight;
        CGPathAddLineToPoint(pathT, nil, x, yT-10);
    }
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathT, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(pathT);
    self.secondShapeLayer.path = pathT;
    CGPathRelease(pathT);
}

#pragma mark - 懒加载

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, 80, 80);
        _imageView.center = self.center;
        _imageView.layer.cornerRadius = 40;
        _imageView.layer.borderWidth = 2;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [_imageView setImage:[UIImage imageNamed:@"me_icon"]];
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (CAShapeLayer *)firstShapeLayer{
    if (!_firstShapeLayer) {
        _firstShapeLayer = [CAShapeLayer layer];
        _firstShapeLayer.fillColor = FJColor(128, 128, 128, 0.1).CGColor;
    }
    return _firstShapeLayer;
}

- (CAShapeLayer *)secondShapeLayer{
    if (!_secondShapeLayer) {
        _secondShapeLayer = [CAShapeLayer layer];
        _secondShapeLayer.fillColor = FJColor(128, 128, 128, 0.1).CGColor;
    }
    return _secondShapeLayer;
}


@end
