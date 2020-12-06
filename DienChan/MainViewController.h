//
//  MainViewController.h
//  DienChan
//
//  Created by vankhangfet on 6/26/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoHinhViewController.h"
#import "ViewController.h"
#import "InfoViewController.h"
#import "PlanViewController.h"
#import "ActionPlanView.h"
#import "PointView.h"
@class PointHelper,MyPoint;

@interface MainViewController : ViewController <DoHinhViewControllerDelegate,InfoViewControllerDelegate,PlanViewControllerDelegate,PointViewDelegate>
{
    IBOutlet UIImageView * imgBackGround;
    
    IBOutlet UIImageView * _imgGrid;
    
    IBOutlet UIButton * btnTaiTrai;
    IBOutlet UIButton * btnMatTrai;
    IBOutlet UIButton * btnMatTruoc;
    IBOutlet UIButton * btnMatPhai;
    IBOutlet UIButton * btnTaiPhai;
    IBOutlet UIButton * btnMui;
    
    IBOutlet UIButton * btnNext;
    IBOutlet UIButton * btnBack;
    IBOutlet UIButton * btnSearch;
    IBOutlet UIButton * btnDow;
    IBOutlet UIButton * btnDoHinh;
    IBOutlet UIButton * btnSoHuyet;
    IBOutlet UIButton * btnGrid;
    IBOutlet UIButton * btnUp;
    
    IBOutlet UIButton * btnShowAllPoint;
    IBOutlet UIButton * btnOpenPlan;
    
    IBOutlet UIButton * btnOpenDoHinh;
    
    IBOutlet UITextField * txtSearch;
    
    IBOutlet UIButton * btnInfo;
    
    UIImageView * _imgDoHinh;
    
    NSArray * arrBackground;
    
    NSArray * arrDoHinh;
    
    int backgroundIndex;
    int dohinhIndex;
    
    // State
    BOOL isShowDoHinh;
    BOOL isShowGrid;
    
    BOOL isShowNumber;
    
    
    NSArray * listfront;
    
    NSString * keyNumber;
    
    Plan * activePlan;
    IBOutlet UIButton * btnPlay;
    IBOutlet UIButton * btnStop;
    IBOutlet UIButton * btnRepeat;
    
    NSMutableArray  * arrActivePlan;
    NSMutableArray * arrPosition;
    NSArray * arrPlan;
    int tempPostion;
    
    int activeIndex;
    
    IBOutlet UILabel * lblBoHuyet;
   
    NSTimer *t;
    int nextItem ;
}

-(IBAction)nextBackgound:(id)sender;
-(IBAction)backBackground:(id)sender;
-(IBAction)downBackground:(id)sender;
-(IBAction)btnShowDoHinh:(id)sender;
-(IBAction)btnShowGrid:(id)sender;
-(IBAction)Up:(id)sender;
-(IBAction)openDoHinh:(id)sender;
-(IBAction)showNumber:(id)sender;
-(IBAction)showAllPoint:(id)sender;
-(IBAction)searchHuyet:(id)sender;
-(IBAction)btnInfoTouch:(id)sender;
-(IBAction)btnOpenPlanTouch:(id)sender;
-(IBAction)btnPlayPlan:(id)sender;
-(IBAction)btnStopPlan:(id)sender;
-(IBAction)btnRepeat:(id)sender;
@end
