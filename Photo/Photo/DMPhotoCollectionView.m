//
//  DMPhotoCollectionView.m
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DMPhotoCollectionView.h"

static NSString *DMPhotoCollectionViewCellID = @"DMPhotoCollectionViewCellID";

@implementation DMPhotoCollectionView
@synthesize modelAry = _modelAry;
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout maxItemCount:(NSInteger)count
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[DMPhotoCollectionViewCell class] forCellWithReuseIdentifier:DMPhotoCollectionViewCellID];
        self.maxItemCount = count;
        [self.modelAry addObject:self.addPhotoModel];
        [self reloadData];
    }
    return self;
}

-(void)setMaxItemCount:(NSInteger)maxItemCount
{
    _maxItemCount = maxItemCount;
}

-(void)setModelAry:(NSMutableArray<DMPhotoCollectionModel *> *)modelAry
{
    _modelAry = modelAry;
    if (modelAry.count == 0)
    {
        [modelAry addObject:self.addPhotoModel];
    }
    else if (modelAry.count != self.maxItemCount  && ![modelAry containsObject:self.addPhotoModel])
    {
        [modelAry addObject:self.addPhotoModel];
    }
    
    if (modelAry.count == self.maxItemCount + 1)
    {
        [modelAry removeObject:self.addPhotoModel];
    }
    [self reloadData];
}

-(NSMutableArray <DMPhotoCollectionModel *>*)modelAry
{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }return _modelAry;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelAry.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DMPhotoCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:DMPhotoCollectionViewCellID forIndexPath:indexPath];
    cell.cellAddBtnClickWithModelBlock = ^(DMPhotoCollectionModel *model) {
        if (self.cellAddBtnClickWithModelBlock)
        {
            self.cellAddBtnClickWithModelBlock(model);
        }
    };
    cell.model = self.modelAry[indexPath.row];
    return cell;
}

-(DMPhotoCollectionModel *)addPhotoModel
{
    if (!_addPhotoModel) {
        _addPhotoModel = [[DMPhotoCollectionModel alloc]init];
        _addPhotoModel.image = nil;
    }
    return _addPhotoModel;
}

@end
