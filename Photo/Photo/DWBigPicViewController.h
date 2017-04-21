//
//  DWBigPicViewController.h
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^removeImage)(UIImage* image);

@interface DWBigPicViewController : UIViewController

- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic , assign) NSString* address;
@property BOOL isEdit;
@property (nonatomic , strong) removeImage remove;

@end
