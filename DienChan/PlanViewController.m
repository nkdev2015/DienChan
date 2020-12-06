//
//  PlanViewController.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "PlanViewController.h"
#import "Plan.h"
#import "PlanCell.h"

NSString *const PLAN_CELL_IDENTIFY = @"PlanCell";

@interface PlanViewController ()

@end

@implementation PlanViewController
@synthesize currentPlan = _currentPlan;
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
    
    listData = [[NSMutableArray alloc]init];
    
    planHelper = [[PlanHelper alloc]init];
    [planHelper getContent];
    [collectionPlanView registerClass:[PlanCell class] forCellWithReuseIdentifier: PLAN_CELL_IDENTIFY];
    NSArray * tempArr  = [planHelper getListPlan];
    listData = [[NSMutableArray alloc]init];
    for (int i =0; i < tempArr.count; i++) {
        
        Plan * tempPlan = [[tempArr objectAtIndex:i] copy];
        [listData addObject:tempPlan];
    }
        _total = listData.count;
    
    // Default Bo huyet 1
    
    Plan *plan1 = [listData objectAtIndex:0];
    
    [self viewPlan:plan1];
    
    [txtContent addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    listSearch = [[NSMutableArray alloc]init];
}

-(void)viewPlan:(Plan*)plan
{
    BoHuyet.text = plan.desPlan;
    ChuTri.text = plan.notePlan;
    SoHuyet.text = plan.listNumber;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnSearchPlan:(id)sender
{
    [listSearch removeAllObjects];
    if(keyContent.length > 0)
    {
        for (int i = 0; i < listData.count ; i++) {
            
            Plan *tempPlan = [listData objectAtIndex:i];
            if([tempPlan.desPlan rangeOfString:keyContent].location != NSNotFound)
            {
            
                [listSearch addObject:[tempPlan copy]];
            }
        
        }
       
    }
    [collectionPlanView reloadData];
}

#pragma mark - Text Change
-(void)textFieldDidChange:(id)sender
{
    
    keyContent = ((UITextField*)sender).text;
    if(keyContent.length ==0)
    {
        [collectionPlanView reloadData];
    }
    
}


#pragma mark - UICollectionViewDatasource

- (NSInteger) collectionView: (UICollectionView *) collectionView numberOfItemsInSection: (NSInteger) section
{
    if(keyContent.length > 0)
    {
        return listSearch.count;
    
    }
    
    return listData.count; //_total;
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) collectionView cellForItemAtIndexPath: (NSIndexPath *) indexPath
{
    
    PlanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: PLAN_CELL_IDENTIFY forIndexPath:indexPath];
    
    Plan *tempPlan;
    if(keyContent.length > 0 )
    {
      tempPlan = [listSearch objectAtIndex:indexPath.row];
    
    }
    else
    {
       tempPlan = [listData objectAtIndex:indexPath.row];
    }
    
    [cell setData: [NSString stringWithFormat:@"%d. %@",indexPath.row + 1,tempPlan.desPlan] ];
    [cell seletedCell:NO];
    
    if (_selectedPlan == tempPlan) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:1 alpha:1];
    }
    else
    {
        cell.contentView.backgroundColor = nil;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView: (UICollectionView *) collectionView layout: (UICollectionViewLayout*) collectionViewLayout sizeForItemAtIndexPath: (NSIndexPath *) indexPath
{
    return CGSizeMake(380, 50);
}

- (UIEdgeInsets) collectionView: (UICollectionView *) collectionView layout: (UICollectionViewLayout*) collectionViewLayout insetForSectionAtIndex: (NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView: (UICollectionView *) collectionView didSelectItemAtIndexPath: (NSIndexPath *) indexPath
{

    Plan *tempPlan = [listData objectAtIndex:indexPath.row];
    self.currentPlan = tempPlan;
    [self viewPlan:tempPlan];
    _selectedPlan = tempPlan;
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:1 alpha:1];
    return;
}

- (void) collectionView: (UICollectionView *) collectionView didDeselectItemAtIndexPath:(NSIndexPath *) indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

#pragma mark - UI function
-(IBAction)btnBackTouch:(id)sender
{
   [self.navigationController popViewControllerAnimated: YES];
}

-(IBAction)btnAcceptPlan:(id)sender
{
    [self.delegate selectedPlan:self];
    [self.navigationController popViewControllerAnimated: YES];
    
}
@end
