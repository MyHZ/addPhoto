//
//  ViewController.m
//  Photo
//
//  Created by DM on 2017/4/18.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ViewController.h"
#import "DMPhotoCollectionView.h"
#import "DWBigPicViewController.h"

@interface ViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)DMPhotoCollectionView *collectionView;

@end

@implementation ViewController

-(DMPhotoCollectionView *)collectionView
{
    if (!_collectionView) {
        __weak ViewController *weakSelf = self;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(ScreenWidth/3, ScreenWidth/3);
        _collectionView = [[DMPhotoCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout maxItemCount:3];
        _collectionView.cellAddBtnClickWithModelBlock = ^(DMPhotoCollectionModel *model) {
            if (model.image)
            {
                [weakSelf seeBigImage:model];
            }
            else
            {
                [weakSelf addNewPhoto];
            }
        };
    }
    return _collectionView;
}

-(void)addNewPhoto
{
    NSLog(@"拍照");
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

-(void)seeBigImage:(DMPhotoCollectionModel *)model
{
    DWBigPicViewController* bigPicVC = [[DWBigPicViewController alloc] initWithImage:model.image];
    bigPicVC.isEdit = YES;
    [bigPicVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    bigPicVC.remove = ^(UIImage* image)
    {
        if ([image isEqual:model.image])
        {
            NSMutableArray *tempAry = self.collectionView.modelAry;
            [tempAry removeObject:model];
            self.collectionView.modelAry = tempAry;
        }
    };
    [self presentViewController:bigPicVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpView];
}

-(void)setUpView;
{
    [self.view addSubview:self.collectionView];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    DMPhotoCollectionModel *model = [DMPhotoCollectionModel new];
    model.image = image;
    
    NSMutableArray *tempAry = self.collectionView.modelAry;
    [tempAry insertObject:model atIndex:tempAry.count-1];
    self.collectionView.modelAry = tempAry;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
