//
//  PlanHelper.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "PlanHelper.h"
#import "Plan.h"
@implementation PlanHelper

-(void)initContent
{
    listPlan = [[NSMutableArray alloc]init];
}

-(void)getPlanFromText
{
    contentFile = [self getContent];
}

-(NSString*)getContent
{
    
    // get a reference to our file
    NSString *myPath = [[NSBundle mainBundle]pathForResource:@"Resource/PointsList" ofType:@"txt"];
    
    // read the contents into a string
    NSString *myFile = [[NSString alloc]initWithContentsOfFile:myPath encoding:NSUTF8StringEncoding error:nil];
    
    return myFile;
}

-(Plan*)getData:(NSString*)strPoint
{
    
    strPoint = [strPoint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    Plan * tempPlan = [[Plan alloc]init];
    
    NSArray *data = [strPoint componentsSeparatedByString:@"\r\n"];
    NSString * temp = [ NSString stringWithFormat:@"%@", [data objectAtIndex:0]];
    if( ![temp isEqual:@""])
    {
        tempPlan.planID= [data objectAtIndex:0];
        tempPlan.desPlan = [data objectAtIndex:1];
        
        tempPlan.arrList = [data objectAtIndex:2];
        
        tempPlan.notePlan = [data objectAtIndex:3];
        tempPlan.listNumber = [data objectAtIndex:4];
    }
    else
    {
        tempPlan.planID= [data objectAtIndex:1];
        tempPlan.desPlan = [data objectAtIndex:2];
    
        tempPlan.arrList = [data objectAtIndex:3];
        
        tempPlan.notePlan = [data objectAtIndex:4];
        tempPlan.listNumber = [data objectAtIndex:5];
    
    }
    
    return tempPlan;
    
}

-(NSArray*)getListPlan
{
    [self initContent];
    
    NSString * tempStr = [self getContent];
    listData = [[NSArray alloc]init];
    
    listData = [tempStr componentsSeparatedByString:@"---"];
    
    for (int i = 0; i < listData.count -1; i++)
    {
        Plan * tempPlan = [self getData:[listData objectAtIndex:i]];
        [listPlan addObject:tempPlan];
    }
    
    return listPlan;
}

@end
