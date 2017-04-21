//
//  DMPhotoCollectionViewCell.h
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DMPhotoCollectionModel : NSObject

@property(nonatomic,retain) UIImage *image;

@end

typedef void (^CellAddBtnClickWithModel)(DMPhotoCollectionModel *model);

@interface DMPhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic,retain) UIButton *addBtn;
@property(nonatomic,retain) DMPhotoCollectionModel *model;
@property(nonatomic,copy) CellAddBtnClickWithModel cellAddBtnClickWithModelBlock;

@end
