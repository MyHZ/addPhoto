//
//  DWBigPicViewController.m
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DWBigPicViewController.h"
#import "DMPhotoCollectionViewCell.h"

@interface DWBigPicViewController ()
{
    UIImage *_image;
    UIImageView* imageView;
    
    UITapGestureRecognizer *singleTapGestureRecognizer;
    UIPinchGestureRecognizer * _pinchGestureRecognize;
    CGFloat  _lastScale;
    
    UIButton* btn_reTake;
}
@end

@implementation DWBigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLayout];
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _image = image;
    }
    
    return self;
}

-(void)initLayout{
    CGRect imgFrame;
    if (_isEdit)
    {
        UIView* titleBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
        titleBar.backgroundColor = [UIColor blackColor];
        [self.view addSubview:titleBar];
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-100, 10, 80, 30)];
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:@"移除" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
        [titleBar addSubview:btn];
        imgFrame = CGRectMake(0, 70, ScreenWidth, ScreenHeight-100);
    }else
    {
        imgFrame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    
    NSLog(@"%@",_image);
    
    imageView = [[UIImageView alloc] initWithFrame:imgFrame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = _image;
    imageView.userInteractionEnabled = YES;
    [imageView setMultipleTouchEnabled:YES];
    
    singleTapGestureRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [imageView addGestureRecognizer:singleTapGestureRecognizer];
    
    _pinchGestureRecognize = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scale:)];
    [imageView addGestureRecognizer:_pinchGestureRecognize];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [imageView addGestureRecognizer:panGestureRecognizer];
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [imageView addGestureRecognizer:rotationGestureRecognizer];
    
    [self.view addSubview:imageView];
    
}

-(void)onClickImage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

-(void)scale:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeClick
{
    //NSLog(@"123123123");
    if (_remove)
    {
        _remove(_image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
