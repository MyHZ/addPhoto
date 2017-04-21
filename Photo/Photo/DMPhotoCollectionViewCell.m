//
//  DMPhotoCollectionViewCell.m
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DMPhotoCollectionViewCell.h"
#import <Masonry.h>

@implementation DMPhotoCollectionModel

@end

@implementation DMPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews
{
    [self.contentView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(1, 1, 1, 1));
    }];
}

-(UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(void)addBtnClick
{
    if (self.cellAddBtnClickWithModelBlock)
    {
        self.cellAddBtnClickWithModelBlock(self.model);
    }
}

-(void)setModel:(DMPhotoCollectionModel *)model
{
    _model = model;
    
    UIImage *btnImage = model.image?:[UIImage imageNamed:@"addPicture"];
    [_addBtn setImage:btnImage forState:UIControlStateNormal];
}

@end
