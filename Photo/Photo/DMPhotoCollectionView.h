//
//  DMPhotoCollectionView.h
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPhotoCollectionViewCell.h"

@interface DMPhotoCollectionView : UICollectionView

<UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithFrame:(CGRect)frame
        collectionViewLayout:(UICollectionViewLayout *)layout
                maxItemCount:(NSInteger)count;

@property(nonatomic,assign)NSInteger maxItemCount;
@property(nonatomic,retain)NSMutableArray <DMPhotoCollectionModel *>*modelAry;
@property(nonatomic,retain)DMPhotoCollectionModel *addPhotoModel;

@property(nonatomic,copy) CellAddBtnClickWithModel cellAddBtnClickWithModelBlock;

@end
