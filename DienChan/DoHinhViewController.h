//
//  DoHinhViewController.h
//  DienChan
//
//  Created by vankhangfet on 6/28/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class DoHinhViewController;

@protocol DoHinhViewControllerDelegate <NSObject>
@required
-(void)selectedDoHinh:(DoHinhViewController*)controller;
-(void)selectedBack:(DoHinhViewController*)controller;
@end

@interface DoHinhViewController : ViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView * _dohinhCollection;
    NSArray * _listDoHinh;
    
    
    
    NSArray * listButton;
    
    IBOutlet UIButton * _btn1;
    IBOutlet UIButton * _btn2;
    IBOutlet UIButton * _btn3;
    IBOutlet UIButton * _btn4;
    IBOutlet UIButton * _btn5;
    IBOutlet UIButton * _btn6;
    IBOutlet UIButton * _btn7;
    IBOutlet UIButton * _btn8;
    IBOutlet UIButton * _btn9;
    IBOutlet UIButton * _btn10;
    IBOutlet UIButton * _btn11;
    IBOutlet UIButton * _btn12;
    IBOutlet UIButton * _btn13;
    IBOutlet UIButton * _btn14;
    
    IBOutlet UIButton * _btnBack;
    
}

@property (nonatomic,weak) id<DoHinhViewControllerDelegate> delegate;
@property (nonatomic,assign) int currentDoHinhIndex ;
-(void)setData:(NSArray*)list;

-(IBAction)btnBack:(id)sender;
@end
