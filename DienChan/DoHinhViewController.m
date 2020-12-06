//
//  DoHinhViewController.m
//  DienChan
//
//  Created by vankhangfet on 6/28/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "DoHinhViewController.h"
#import "DoHinhCell.h"

NSString *const DOHINH_CELL_IDENTIFY = @"DoHinhCell";

// Do Hinh
NSString * const DOHINH_1_THUMB = @"Resource/DoHinhThumb0001.png";
NSString * const DOHINH_2_THUMB = @"Resource/DoHinhThumb0002.png";
NSString * const DOHINH_3_THUMB = @"Resource/DoHinhThumb0003.png";
NSString * const DOHINH_4_THUMB = @"Resource/DoHinhThumb0004.png";
NSString * const DOHINH_5_THUMB = @"Resource/DoHinhThumb0005.png";
NSString * const DOHINH_6_THUMB = @"Resource/DoHinhThumb0006.png";
NSString * const DOHINH_7_THUMB = @"Resource/DoHinhThumb0007.png";
NSString * const DOHINH_8_THUMB = @"Resource/DoHinhThumb0008.png";
NSString * const DOHINH_9_THUMB = @"Resource/DoHinhThumb0009.png";
NSString * const DOHINH_10_THUMB = @"Resource/DoHinhThumb0010.png";
NSString * const DOHINH_11_THUMB = @"Resource/DoHinhThumb0011.png";
NSString * const DOHINH_12_THUMB = @"Resource/DoHinhThumb0012.png";
NSString * const DOHINH_13_THUMB = @"Resource/DoHinhThumb0013.png";
NSString * const DOHINH_14_THUMB = @"Resource/DoHinhThumb0014.png";

@interface DoHinhViewController ()

@end

@implementation DoHinhViewController

@synthesize currentDoHinhIndex = _currentDoHinhIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[_dohinhCollection registerClass:[DoHinhCell class] forCellWithReuseIdentifier: DOHINH_CELL_IDENTIFY];
    
    
    _listDoHinh = [NSArray arrayWithObjects:DOHINH_1_THUMB,
                   DOHINH_2_THUMB,
                   DOHINH_3_THUMB,
                   DOHINH_4_THUMB,
                   DOHINH_5_THUMB,
                   DOHINH_6_THUMB,
                   DOHINH_7_THUMB,
                   DOHINH_8_THUMB,
                   DOHINH_9_THUMB,
                   DOHINH_10_THUMB,
                   DOHINH_11_THUMB,
                   DOHINH_12_THUMB,
                   DOHINH_13_THUMB,
                   DOHINH_14_THUMB, nil];
    
    listButton = [NSArray arrayWithObjects:_btn1,
                  _btn2,
                  _btn3,
                  _btn4,
                  _btn5,
                  _btn6,
                  _btn7,
                  _btn8,
                  _btn9,
                  _btn10,
                  _btn11,
                  _btn12,
                  _btn13,
                  _btn14, nil];
    int i = 0;
    for (UIButton * btn in  listButton) {
        
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[_listDoHinh objectAtIndex:i]] forState:UIControlStateNormal];
        i++;
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [[UIColor yellowColor] CGColor];
        [btn addTarget:self action:@selector(btnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSArray*)list
{
    return;
   // _listDoHinh = [[NSArray alloc]init];
    //_listDoHinh  = [list copy];

}

-(void)btnTouchUp:(id)sender
{
    // Update do hinh;
    _currentDoHinhIndex = ((UIButton*)sender).tag;
    [_delegate selectedDoHinh:self];

}

-(IBAction)btnBack:(id)sender
{
    // Close popup
   [_delegate selectedBack:self];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger) collectionView: (UICollectionView *) collectionView numberOfItemsInSection: (NSInteger) section
{
    return _listDoHinh.count;
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) collectionView cellForItemAtIndexPath: (NSIndexPath *) indexPath
{
    
    DoHinhCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: DOHINH_CELL_IDENTIFY forIndexPath:indexPath];
    
    [cell setImgeForCell:[_listDoHinh objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView: (UICollectionView *) collectionView layout: (UICollectionViewLayout*) collectionViewLayout sizeForItemAtIndexPath: (NSIndexPath *) indexPath
{
    return CGSizeMake(192, 256);
}

- (UIEdgeInsets) collectionView: (UICollectionView *) collectionView layout: (UICollectionViewLayout*) collectionViewLayout insetForSectionAtIndex: (NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView: (UICollectionView *) collectionView didSelectItemAtIndexPath: (NSIndexPath *) indexPath
{
    
}

@end
