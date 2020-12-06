//
//  PlanViewController.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanHelper.h"
@class  Plan,PlanViewController;



@protocol PlanViewControllerDelegate <NSObject>
@required
-(void)selectedPlan:(PlanViewController*)controller;
@end
@interface PlanViewController : UIViewController
{

   IBOutlet UITextField * txtContent;
   IBOutlet UIButton * btnSearch;
    
    IBOutlet UICollectionView * collectionPlanView;
    
    NSMutableArray * listData;
    NSMutableArray * listSearch;
    PlanHelper * planHelper;
    int _total;
    
    IBOutlet UITextView * BoHuyet;
    IBOutlet UITextView * ChuTri;
    IBOutlet UITextView * SoHuyet;
    
    NSString * keyContent;
    
    Plan * _selectedPlan;
}
@property (nonatomic,strong) Plan * currentPlan;
@property (nonatomic,weak) id<PlanViewControllerDelegate> delegate;
-(IBAction)btnBackTouch:(id)sender;
-(IBAction)btnAcceptPlan:(id)sender;

-(IBAction)btnSearchPlan:(id)sender;
@end
