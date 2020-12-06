//
//  MainViewController.m
//  DienChan
//
//  Created by vankhangfet on 6/26/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "MainViewController.h"
#import "PointHelper.h"
#import "PointView.h"
#import "MyPoint.h"
#import "PlanHelper.h"
#import "Plan.h"

const NSString * strEarLef = @"EarLeft";
const NSString * strHafFaceLeft = @"HafFaceLeft" ;
const NSString * strFront = @"Front";
const NSString * strHafFaceRight = @"HafFaceRight";
const NSString * strEarRight = @"EarRight";
const NSString * strNose = @"Nose";

NSString * const MATTRUOC = @"Resource/MatTruoc.png";
NSString * const MAT_TRAI = @"Resource/Mattrai.png";
NSString * const MAT_PHAI = @"Resource/MatPhai.png";
NSString * const TAI_TRAI = @"Resource/TaiTrai.png";
NSString * const TAI_PHAI = @"Resource/TaiPhai.png";
NSString * const MUI_DUOI = @"Resource/MuiDuoi.png";

NSString * const GRID_TRUOC = @"Resource/LuoiToaDoMatTruoc.png";
NSString * const GRID_TRAI = @"Resource/LuoiToaDoMatTrai.png";
NSString * const GRID_PHAI = @"Resource/LuoiToaDoMatPhai.png";

// Do Hinh
NSString * const DOHINH_1 = @"Resource/DoHinh0002.png";
NSString * const DOHINH_2 = @"Resource/DoHinh0003.png";
NSString * const DOHINH_3 = @"Resource/DoHinh0004.png";
NSString * const DOHINH_4 = @"Resource/DoHinh0005.png";
NSString * const DOHINH_5 = @"Resource/DoHinh0006.png";
NSString * const DOHINH_6 = @"Resource/DoHinh0007.png";
NSString * const DOHINH_7 = @"Resource/DoHinh0008.png";
NSString * const DOHINH_8 = @"Resource/DoHinh0009.png";
NSString * const DOHINH_9 = @"Resource/DoHinh0010.png";
NSString * const DOHINH_10 = @"Resource/DoHinh0011.png";
NSString * const DOHINH_11 = @"Resource/DoHinh0012.png";
NSString * const DOHINH_12 = @"Resource/DoHinh0013.png";
NSString * const DOHINH_13 = @"Resource/DoHinh0014.png";
NSString * const DOHINH_14 = @"Resource/DoHinh0015.png";

int const INDEX_TRUOC = 2;

enum
{
    EarLef ,
    HafFaceLeft ,
    Front ,
    HafFaceRight ,
    EarRight,
    Nose

};
typedef int FaceType;

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    imgBackGround.image = [UIImage imageNamed:MATTRUOC];
    
    //Show grid
    _imgGrid.image = [UIImage imageNamed:GRID_TRUOC];
    backgroundIndex = INDEX_TRUOC;
    
    arrBackground = [NSArray arrayWithObjects:TAI_TRAI,MAT_TRAI,MATTRUOC,MAT_PHAI,TAI_PHAI,nil];
    
    arrDoHinh = [NSArray arrayWithObjects:
                 DOHINH_1,
                 DOHINH_2,
                 DOHINH_3,
                 DOHINH_4,
                 DOHINH_5,
                 DOHINH_6,
                 DOHINH_7,
                 DOHINH_8,
                 DOHINH_9,
                 DOHINH_10,DOHINH_11,DOHINH_12,DOHINH_13,DOHINH_14,nil];
    
    dohinhIndex =0;
    isShowDoHinh = NO;
    _imgDoHinh = [[UIImageView alloc]initWithFrame:self.view.frame];
    _imgDoHinh.image = [UIImage imageNamed:DOHINH_1];
    [self showDoHinh:isShowDoHinh];
    [self.view addSubview:_imgDoHinh];
    
    isShowGrid = YES;
    
    
    btnTaiTrai.tag = 1;
    btnMatTrai.tag = 2;
    btnMatTruoc.tag =3;
    btnMatPhai.tag =4;
    btnTaiPhai.tag = 5;
    btnMui.tag = 6;
    
    btnNext.tag = 10;
    btnBack.tag = 11;
    btnSearch.tag =12;
    btnDow.tag = 13;
    btnDoHinh.tag = 14;
    btnSoHuyet.tag = 15;
    btnGrid.tag = 16;
    
    
    btnOpenDoHinh.tag = 17;
    btnShowAllPoint.tag = 18;
    btnOpenPlan.tag = 19;
    txtSearch.tag = 20;
    
    btnInfo.tag = 21;
    
    btnPlay.tag = 22;
    btnStop.tag = 23;
    btnRepeat.tag  = 24;
    
    [self updateStatus:3];
    btnUp.hidden = YES;
    
    PointHelper* myHelper = [[PointHelper alloc]init];
    listfront = [[NSArray alloc]init];

    [myHelper getListData];
    listfront = [myHelper getDataFront];
    
    [self displayHuyet:INDEX_TRUOC];
    
    isShowNumber = NO;
    [self showSoHuyet:isShowNumber];
    
    [txtSearch addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    arrActivePlan  = [[NSMutableArray alloc]init];
    arrPosition = [[NSMutableArray alloc]init];
    lblBoHuyet.hidden = YES;
    [self updatePlanControllStatus:NO];
    
    isShowDoHinh = NO;
   
}

#pragma mark - PlanDelegate
-(void)selectedBack:(DoHinhViewController*)controller
{
    [self resetPlanView];
    [self dismissSheetController];
    
}

-(void)selectedPlan:(PlanViewController*)controller
{
     activePlan = controller.currentPlan;
    [arrPosition removeAllObjects];
    nextItem =0;
    NSString * strMessage = [NSString stringWithFormat:@"Bạn đã chọn bộ huyệt: %@. Hãy nhấn biểu tượng Play để xem cách điều trị ",activePlan.desPlan];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:strMessage delegate:nil cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    
    [alert show];
    
   
    [self updateActivePlan:activePlan];
    lblBoHuyet.text = activePlan.desPlan;
    lblBoHuyet.hidden = NO;
    
    [self updatePlanControllStatus:YES];
    
    isShowDoHinh = NO;
    [self showDoHinh:isShowDoHinh];
    
    [self displayBoHuyet:INDEX_TRUOC];
}

-(void)updatePlanControllStatus:(BOOL)status
{
    
    btnRepeat.enabled = status;
    btnPlay.enabled = status;
    btnStop.enabled = status;
    
    btnRepeat.hidden = !status;
    btnPlay.hidden= !status;
    btnStop.hidden = !status;
}

-(void)updateActivePlan:(Plan*)plan
{
    [arrPosition removeAllObjects];
    
    NSString * strPlan = [NSString stringWithFormat:@"%@",plan.arrList];
    arrPlan = [[NSArray alloc]init];
    arrPlan = [strPlan componentsSeparatedByString:@","];
    
   PointHelper*  myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    NSArray *  tempArr0 = [myHelper getDataEarLeft];
    
    NSArray *  tempArr1 = [myHelper getDataFaceLeft];
    
    NSArray * tempArr2 = [myHelper getDataFront];
    
    NSArray * tempArr3 = [myHelper getDataFaceRight];
    
    NSArray * tempArr4 = [myHelper getDataEarRight];
    
    NSArray * tempArr5 = [myHelper getDataNose];
    
    for (int i = 0; i < arrPlan.count; i++) {
        
        if([self isInList:tempArr0 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"0"];
        }
        if([self isInList:tempArr1 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"1"];
        }
        if([self isInList:tempArr2 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"2"];
        }
        if([self isInList:tempArr3 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"3"];
        }
        if([self isInList:tempArr4 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"4"];
        }
        if([self isInList:tempArr5 andNumber:[arrPlan objectAtIndex:i]])
        {
            [arrPosition addObject:@"5"];
        }
    }
    
}


-(BOOL)isInList:(NSArray*)list andNumber:(NSString*)number
{
    BOOL ret = NO;
    for (int i = 0; i < list.count; i ++) {
        MyPoint * tempPoint = [list objectAtIndex:i];
        if ([tempPoint.pointID isEqual:number] )
        {
            ret = YES;
            break;
        }
        
    }
    
    
    
    return ret;
    
}

#pragma mark Reset Plan View

-(void)resetPlanView
{
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[PointView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[ActionPlanView class]])
        {
            [view removeFromSuperview];
        }
    }

}

-(void)removePlanViewInstrucsition
{
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[ActionPlanView class]])
        {
            [view removeFromSuperview];
        }
    }

}

#pragma mark - Display Bo Huyet 
-(void)displayBoHuyet:(int)index
{
    
  
    // ResetView
    [self resetPlanView];
    
    
    NSString * regionActive ;
    switch (index) {
        case 0:
            regionActive = [NSString stringWithFormat:@"%@",strEarLef];
            break;
        case 1:
            regionActive = [NSString stringWithFormat:@"%@",strHafFaceLeft];
            break;
        case 2:
            regionActive = [NSString stringWithFormat:@"%@",strFront];
            break;
        case 3:
            regionActive = [NSString stringWithFormat:@"%@",strHafFaceRight];
            break;
        case 4:
            regionActive = [NSString stringWithFormat:@"%@",strEarRight];
            break;
        case 5:
            regionActive = [NSString stringWithFormat:@"%@",strNose];
            break;
        default:
            break;
    }
    
    PointHelper*  myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    NSArray *  arrTotalPoint  = [myHelper getAllPoint];
    
    NSString * tempPos;
    for (int i = 0; i < arrPosition.count; i++)
    {
       tempPos = [arrPlan objectAtIndex:i];
        
        for (int k = 0; k < arrTotalPoint.count; k++)
        {
            MyPoint*  activePoint = [arrTotalPoint objectAtIndex:k];
            if([activePoint.pointID isEqual:tempPos] && [activePoint.region isEqual:regionActive])
            {
               // Display on View
                PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
                tempView.category = @"Huyet";
                
                
                CGRect f = tempView.frame;
                NSString * _x = [NSString stringWithFormat:@"%@",activePoint.x];
                NSString * _y = [NSString stringWithFormat:@"%@",activePoint.y];
                f.origin.x = [_x floatValue]/2;
                f.origin.y = [_y floatValue]/2;
                tempView.frame = f;
                isShowNumber = YES;
                [tempView setNumber:activePoint.number];
                [tempView showNumber:YES];
                
                [self.view addSubview:tempView];
                [self.view bringSubviewToFront:tempView];
            }
        }
    }
    
}

#pragma  mark Play, Stop, Repeat Plan
-(IBAction)btnPlayPlan:(id)sender
{
    [self disableButtonStartPlan];
    // Reset View;
   // [self resetPlanView];
    btnPlay.enabled = NO;
    btnRepeat.enabled = NO;
     nextItem =0;
    PointHelper*  myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    NSArray *  arrTotalPoint  = [myHelper getAllPoint];
    
    tempPostion  = [[arrPosition objectAtIndex:nextItem]intValue];
    // Update background and play
    NSString * tempPos = [arrPlan objectAtIndex:nextItem];
    for (int k = 0; k < arrTotalPoint.count; k++)
    {
        MyPoint*  activePoint = [arrTotalPoint objectAtIndex:k];
        if([activePoint.pointID isEqual:tempPos])
        {
            activeIndex = k;
            break;
            
        }
    }
    
    [self playDelay];

     t = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:YES];
    
}

-(void)disableButtonStartPlan
{
    btnNext.enabled = NO;
    btnUp.enabled = NO;
    btnBack.enabled = NO;
    btnDow.enabled = NO;
    txtSearch.enabled = NO;
    btnSearch.enabled = NO;
    
    btnDoHinh.enabled = NO;
    btnOpenPlan.enabled = NO;
    btnShowAllPoint.enabled = NO;
    btnSoHuyet.enabled = NO;
    
    btnOpenDoHinh.enabled = NO;
}
-(void)enableButtonEndPlan
{
    
    btnNext.enabled = YES;
    btnUp.enabled = YES;
    btnBack.enabled = YES;
    btnDow.enabled = YES;
    txtSearch.enabled = YES;
    btnSearch.enabled = YES;
    
    btnDoHinh.enabled = YES;
    btnOpenPlan.enabled = YES;
    btnShowAllPoint.enabled = YES;
    btnSoHuyet.enabled = YES;
    btnOpenDoHinh.enabled = YES;
}

-(void)onTick:(NSTimer *)timer {
    //do smth
    
    if(nextItem >= arrPosition.count)
    {
        btnRepeat.enabled = YES;
        [self enableButtonEndPlan];
        [t invalidate];
        t = nil;
        for (UIView * view in self.view.subviews) {
            if([view isKindOfClass:[ActionPlanView class]])
            {
                [view removeFromSuperview];
            }
        }
        [self endPlan];
        return;
    }
    
    PointHelper*  myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    NSArray *  arrTotalPoint  = [myHelper getAllPoint];

    tempPostion  = [[arrPosition objectAtIndex:nextItem]intValue];
    // Update background and play
    NSString * tempPos = [arrPlan objectAtIndex:nextItem];
    for (int k = 0; k < arrTotalPoint.count; k++)
    {
        MyPoint*  activePoint = [arrTotalPoint objectAtIndex:k];
        if([activePoint.pointID isEqual:tempPos])
        {
            activeIndex = k;
            break;
            
        }
    }
    
    [self playDelay];
    
   
    
     nextItem++;
}

-(void)endPlan
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Kết thúc điều trị" delegate:nil cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    [alert show];

}

-(IBAction)btnStopPlan:(id)sender
{
    [t invalidate];
    [self enableButtonEndPlan];
    [self resetPlanView];
    [self updatePlanControllStatus:NO];
    activePlan = nil;
    [arrPosition removeAllObjects];
    lblBoHuyet.text = @"";

}

-(IBAction)btnRepeat:(id)sender
{
    if(activePlan!=nil)
    {
        [self resetPlanView];
        [self btnPlayPlan:nil];
    
    }

}

-(void)displayIntrucsion:(int)index
{
    PointHelper*  myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    NSArray *  arrTotalPoint  = [myHelper getAllPoint];
    MyPoint* mypoint = [arrTotalPoint objectAtIndex:index];
    
    float x = [mypoint.x floatValue]/2;
    float y = [mypoint.y floatValue]/2;
    ActionPlanView * planView = [[ActionPlanView alloc]initWithFrame:CGRectMake(x, y, 80, 300)];
    [planView updateContent:mypoint.number];
    [self.view addSubview:planView];
    PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    tempView.category = @"Huyet";
    
    
    CGRect f = tempView.frame;
    
    f.origin.x = x;
    f.origin.y = y;
    tempView.frame = f;
    isShowNumber = YES;
    [tempView setNumber:mypoint.number];
    [tempView showNumber:isShowNumber];
    
    [self.view addSubview:tempView];
    [self.view bringSubviewToFront:tempView];

}

-(void)playDelay
{
    
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[ActionPlanView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    
    if(backgroundIndex!=tempPostion)
    {
        for (UIView * view in self.view.subviews) {
            if([view isKindOfClass:[PointView class]])
            {
                [view removeFromSuperview];
            }
        }
        
    }
    backgroundIndex = tempPostion;
    if(backgroundIndex <5)
    {
        imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
        [self showGrid:isShowGrid];
    }
    else
    {
       imgBackGround.image = [UIImage imageNamed:MUI_DUOI];
        _imgGrid.hidden = YES;
    }
    [self displayIntrucsion:activeIndex];
   
   
}

#pragma mark - Text Change 
-(void)textFieldDidChange:(id)sender
{

    keyNumber = ((UITextField*)sender).text;
    if(keyNumber.length ==0)
    {
        backgroundIndex =INDEX_TRUOC;
        imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
        for (UIView * view in self.view.subviews) {
            if([view isKindOfClass:[PointView class]])
            {
                [view removeFromSuperview];
            }
        }
        [self updateStatus:backgroundIndex+1];
        
        [self updateGridAndDoHinh];
        [self showAllPoint:nil];

    }
}

-(void)displayHuyetWithKey:(NSString*)key andIndex:(int)index
{

    NSArray * tempArr;
    PointHelper * myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    switch (index) {
        case 0:
            tempArr = [myHelper getDataEarLeft];
            break;
        case 1:
            tempArr = [myHelper getDataFaceLeft];
            break;
        case 2:
            tempArr = [myHelper getDataFront];
            break;
        case 3:
            tempArr = [myHelper getDataFaceRight];
            break;
        case 4:
            tempArr = [myHelper getDataEarRight];
            break;
        case 5:
            tempArr = [myHelper getDataNose];
            break;
        default:
            break;
    }
    
    
    
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[PointView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < tempArr.count; i ++) {
         MyPoint * tempPoint = [tempArr objectAtIndex:i];
        if ([tempPoint.number isEqual:key] || key.length ==0)
        {
            PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
            tempView.category = @"Huyet";
        
        
            CGRect f = tempView.frame;
            NSString * _x = [NSString stringWithFormat:@"%@",tempPoint.x];
            NSString * _y = [NSString stringWithFormat:@"%@",tempPoint.y];
            f.origin.x = [_x floatValue]/2;
            f.origin.y = [_y floatValue]/2;
            tempView.frame = f;
            isShowNumber = YES;
            [tempView setNumber:tempPoint.number];
            [tempView showNumber:isShowNumber];
        
            [self.view addSubview:tempView];
            [self.view bringSubviewToFront:tempView];
        }
        
    }
    
}

-(void)displayHuyet:(int)index
{
    NSArray * tempArr;
    PointHelper * myHelper = [[PointHelper alloc]init];
    [myHelper getListData];
    
    switch (index) {
        case 0:
            tempArr = [myHelper getDataEarLeft];
            break;
        case 1:
            tempArr = [myHelper getDataFaceLeft];
            break;
        case 2:
            tempArr = [myHelper getDataFront];
            break;
        case 3:
            tempArr = [myHelper getDataFaceRight];
            break;
        case 4:
            tempArr = [myHelper getDataEarRight];
            break;
        case 5:
            tempArr = [myHelper getDataNose];
            break;
        default:
            break;
    }
    
    
    
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[PointView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < tempArr.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.delegate = self;
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr objectAtIndex:i];
        
        CGRect f = tempView.frame;
        NSString * _x = [NSString stringWithFormat:@"%@",tempPoint.x];
        NSString * _y = [NSString stringWithFormat:@"%@",tempPoint.y];
        f.origin.x = [_x floatValue]/2;
        f.origin.y = [_y floatValue]/2;
        tempView.frame = f;
        
        [tempView setNumber:tempPoint.number];
        [tempView showNumber:isShowNumber];
        
        [self.view addSubview:tempView];
        [self.view bringSubviewToFront:tempView];
        
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UI 
-(void)updateGridAndDoHinh
{
    if(backgroundIndex!=INDEX_TRUOC)
    {
       // isShowDoHinh = NO;
        
            [self showDoHinh:NO];
            btnDoHinh.enabled = NO;
    }
    else
    {
        //isShowDoHinh = YES;
        if(keyNumber.length >0)
        {
            isShowDoHinh = NO;
            [self showDoHinh:isShowDoHinh];
        }
        else
        {
            if(isShowDoHinh)
            {
                isShowDoHinh = YES;
                [self showDoHinh:isShowDoHinh];
                btnDoHinh.enabled = isShowDoHinh;
            }
        }
    }
    
    if(isShowGrid)
    {
        switch (backgroundIndex) {
            case 1: // Mat trai
            {
                _imgGrid.image = [UIImage imageNamed:GRID_TRAI];
                 _imgGrid.hidden = NO;
                break;
            }
            case 2: // Mat truoc
            {
                _imgGrid.image = [UIImage imageNamed:GRID_TRUOC];
                 _imgGrid.hidden = NO;
                break;
            }
            case 3: // Mat phai
            {
                _imgGrid.image = [UIImage imageNamed:GRID_PHAI];
                 _imgGrid.hidden = NO;
                break;
            }
            default:
                _imgGrid.hidden = YES;
                break;
        }
    }

   
}

-(IBAction)btnInfoTouch:(id)sender
{
    InfoViewController * controller = [[InfoViewController alloc]init];
    controller.delegate = self;
    [self presentAsSheetController:controller];

}

-(IBAction)btnOpenPlanTouch:(id)sender
{
    
    [arrPosition removeAllObjects];
    CFRunLoopStop([[NSRunLoop currentRunLoop] getCFRunLoop]);
    
    PlanViewController * controller = [[PlanViewController alloc]init];
    controller.delegate = self;
    [self.navigationController pushViewController: controller animated: YES];
    
}
#pragma mark - InforControllerDelegate
-(void)selectedExit:(InfoViewController*)controller
{
    
    [self dismissSheetController];
}

-(IBAction)openDoHinh:(id)sender
{
    DoHinhViewController * controler = [[DoHinhViewController alloc]init];
    controler.delegate = self;
    [controler setData:arrDoHinh];
    [self presentAsSheetController: controler];

}

-(IBAction)showAllPoint:(id)sender
{
    if(activePlan==nil)
    {
        [self updatePlanControllStatus:NO];
    }
    
    [self Up:nil];

}

#pragma mark - Navigation View

-(IBAction)Up:(id)sender
{
    backgroundIndex = INDEX_TRUOC;
    imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
    
    [self updateStatus:backgroundIndex+1];
    
    [self updateGridAndDoHinh];
    [self displayHuyet:INDEX_TRUOC];
    btnUp.hidden = YES;
    
    btnBack.hidden = NO;
    btnNext.hidden = NO;
    if(activePlan!=nil)
    {
        [self displayBoHuyet:backgroundIndex];
    }
    [self removePlanViewInstrucsition];
}

-(IBAction)nextBackgound:(id)sender
{
    if(backgroundIndex <=3)
    {
        backgroundIndex +=1;
    
        imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
        
        [self updateStatus:backgroundIndex+1];
        
        [self updateGridAndDoHinh];
        if(keyNumber.length ==0)
        {
            [self displayHuyet:backgroundIndex];
        }
        else
        {
            [self displayHuyetWithKey:keyNumber andIndex:backgroundIndex];
        }
        
        if(activePlan!=nil)
        {
            [self displayBoHuyet:backgroundIndex];
        }
    }
    [self removePlanViewInstrucsition];
}

-(IBAction)backBackground:(id)sender
{
    if(backgroundIndex >=1)
    {
        backgroundIndex -=1;
    
        imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
        
        [self updateStatus:backgroundIndex+1];
        [self updateGridAndDoHinh];
        if(keyNumber.length ==0)
        {
            [self displayHuyet:backgroundIndex];
        }
        else
        {
            [self displayHuyetWithKey:keyNumber andIndex:backgroundIndex];
        
        }
        
        if(activePlan!=nil)
        {
            [self displayBoHuyet:backgroundIndex];
        }
    }
   [self removePlanViewInstrucsition];
}

-(IBAction)downBackground:(id)sender
{
    backgroundIndex = 5;
    imgBackGround.image = [UIImage imageNamed:MUI_DUOI];
    _imgGrid.hidden = YES;
    btnMui.enabled = YES;
    isShowDoHinh = NO;
    [self showDoHinh:isShowDoHinh];
    btnDoHinh.enabled = NO;
    btnUp.hidden = NO;
    btnUp.enabled = YES;
    if(keyNumber.length ==0)
    {
        [self displayHuyet:backgroundIndex];
    }
    else
    {
        [self displayHuyetWithKey:keyNumber andIndex:backgroundIndex];
        
    }
    
    btnBack.hidden = YES;
    btnNext.hidden = YES;
    
    if(activePlan!=nil)
    {
        [self displayBoHuyet:backgroundIndex];
    }
}

-(IBAction)btnShowDoHinh:(id)sender
{
    isShowDoHinh = !isShowDoHinh;
    [self showDoHinh:isShowDoHinh];
}

-(IBAction)btnShowGrid:(id)sender
{
    isShowGrid = !isShowGrid;
    [self showGrid:isShowGrid];
}
-(void)showGrid:(BOOL)isShow
{
    if(isShow)
    {
        _imgGrid.hidden = NO;
        [btnGrid setImage:[UIImage imageNamed:@"Resource/ShowGridButton.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        _imgGrid.hidden = YES;
        [btnGrid setImage:[UIImage imageNamed:@"Resource/HideGridButton.png"] forState:UIControlStateNormal];
    }



}
-(void)showDoHinh:(BOOL)isShow
{
    if(isShow)
    {
        if(backgroundIndex == INDEX_TRUOC)
        {
          _imgDoHinh.hidden = NO;
        }
        else
        {
          _imgDoHinh.hidden = YES;
        }
        [btnDoHinh setImage:[UIImage imageNamed:@"Resource/ShowDoHinh.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnDoHinh setImage:[UIImage imageNamed:@"Resource/HideDoHinh.png"] forState:UIControlStateNormal];
        _imgDoHinh.hidden = YES;
    }
    
}

-(void)showSoHuyet:(BOOL)isShow
{
    if(isShow)
    {
       
        
        [btnSoHuyet setImage:[UIImage imageNamed:@"Resource/ShowNumber.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnSoHuyet setImage:[UIImage imageNamed:@"Resource/HideNumber.png"] forState:UIControlStateNormal];
    }
    
    for (UIView * view in self.view.subviews) {
        if([view isKindOfClass:[PointView class]])
        {
            [(PointView*)view showNumber:isShow];
        }
    }
    
}

-(IBAction)showNumber:(id)sender
{
    isShowNumber = !isShowNumber;
    
    [self showSoHuyet:isShowNumber];

}


-(IBAction)searchHuyet:(id)sender
{
    keyNumber = [NSString stringWithFormat:@"%@",txtSearch.text];
    
    // keyNumber is null or empy. Reset view to front
    NSArray * arrFind = [self findHuyet:keyNumber];
    if(arrFind.count > 0)
    {
        backgroundIndex = [[arrFind lastObject]intValue];
        [self displayHuyetWithKey:keyNumber andIndex:backgroundIndex];
        if(backgroundIndex < 5 )
        {
            imgBackGround.image = [UIImage imageNamed:[arrBackground objectAtIndex:backgroundIndex]];
        }
        else
        {
             imgBackGround.image = [UIImage imageNamed:MUI_DUOI];
        }
        
        [self updateStatus:backgroundIndex+1];
        [self updateGridAndDoHinh];
        
        
        // Update button
        if([arrFind containsObject:@"2"])
        {
            btnMatTruoc.enabled = YES;
            
        }
        else
        {
            btnMatTruoc.enabled = NO;
        }
        
        if([arrFind containsObject:@"0"])
        {
            btnTaiTrai.enabled = YES;
            
        }
        else
        {
            btnTaiTrai.enabled = NO;
        }
        
        if([arrFind containsObject:@"1"])
        {
            btnMatTrai.enabled = YES;
            
        }
        else
        {
            btnMatTrai.enabled = NO;
        }
        
        if([arrFind containsObject:@"3"])
        {
            
            btnMatPhai.enabled = YES;
        }
        else
        {
            btnMatPhai.enabled = NO;
        }
        
        if([arrFind containsObject:@"4"])
        {
            btnTaiPhai.enabled = YES;
            
        }
        else
        {
            btnTaiPhai.enabled = NO;
        }
        
        if([arrFind containsObject:@"5"])
        {
            btnMui.enabled = YES;
            
        }
        else
        {
            btnMui.enabled = NO;
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Không tìm thấy huyệt nào! Hãy tìm huyệt khác" delegate:nil cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    
}


-(void)updateStatus:(int)index
{
    for (UIButton *btn in self.view.subviews)
    {
       if(btn.tag !=index && btn.tag < 7  )
       {
           btn.enabled = NO;
       }
        else
       {
          btn.enabled = YES;
           if(activePlan==nil)
           {
               btnPlay.enabled = NO;
               btnRepeat.enabled = NO;
               btnStop.enabled = NO;
           }
       }
    }

}

-(NSArray*)findHuyet:(NSString*)key
{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    
    PointHelper * myHelper = [[PointHelper alloc]init];
    [myHelper getListData];

   NSArray *  tempArr = [myHelper getDataEarLeft];
 
   NSArray *  tempArr1 = [myHelper getDataFaceLeft];

    NSArray * tempArr2 = [myHelper getDataFront];

    NSArray * tempArr3 = [myHelper getDataFaceRight];

    NSArray * tempArr4 = [myHelper getDataEarRight];

    NSArray * tempArr5 = [myHelper getDataNose];
  
    // Ear Left
    for (int i = 0; i < tempArr.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"0"];
            break;
        }
        
    }
    // Face Left
    for (int i = 0; i < tempArr1.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr1 objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"1"];
            break;
        }
        
    }
    // Front
    for (int i = 0; i < tempArr2.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr2 objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"2"];
            break;
        }
        
    }
    
    
    
    // Face Right
    for (int i = 0; i < tempArr3.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr3 objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"3"];
            break;
        }
        
    }

    
    // Ear Right
    for (int i = 0; i < tempArr4.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr4 objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"4"];
            break;
        }
        
    }
    
    // Nose
    for (int i = 0; i < tempArr5.count; i ++) {
        
        PointView * tempView = [[PointView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        tempView.category = @"Huyet";
        
        MyPoint * tempPoint = [tempArr5 objectAtIndex:i];
        
        if([tempPoint.number isEqual:key])
        {
            [result addObject:@"5"];
            break;
        }
        
    }
    
    return [result copy];

}


#pragma mark - DoHinhDelegate
-(void)selectedDoHinh:(DoHinhViewController*)controller
{
    
   _imgDoHinh.image = [UIImage imageNamed:[arrDoHinh objectAtIndex:controller.currentDoHinhIndex]];
    isShowDoHinh = YES;
    [self showDoHinh:isShowDoHinh];
  [self Up:nil];
  [self dismissSheetController];
}


@end
