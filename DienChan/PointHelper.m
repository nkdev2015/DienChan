//
//  PointHelper.m
//  DienChan
//
//  Created by vankhangfet on 6/30/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "PointHelper.h"
#import "MyPoint.h"

const NSString * EarLef = @"EarLeft";
const NSString * HafFaceLeft = @"HafFaceLeft" ;
const NSString * Front = @"Front";
const NSString * HafFaceRight = @"HafFaceRight";
const NSString * EarRight = @"EarRight";
const NSString * Nose = @"Nose";

@implementation PointHelper

-(void)initContent
{

    listFront = [[NSMutableArray alloc]init];
    listEarLeft = [[NSMutableArray alloc]init];
    listEarRight = [[NSMutableArray alloc]init];
    listHalfLeft = [[NSMutableArray alloc]init];
    listHalfRight = [[NSMutableArray alloc]init];
    listNose = [[NSMutableArray alloc]init];

}

-(MyPoint*)getData:(NSString*)strPoint
{
    
    strPoint = [strPoint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    MyPoint * tempPoint = [[MyPoint alloc]init];
    
    NSArray *data = [strPoint componentsSeparatedByString:@"\r\n"];
    
    tempPoint.pointID = [data objectAtIndex:1];
    tempPoint.x = [data objectAtIndex:2];
    tempPoint.y = [data objectAtIndex:3];
    tempPoint.region = [data objectAtIndex:4];
    tempPoint.position = [data objectAtIndex:5];
    tempPoint.number = [data objectAtIndex:6];
    tempPoint.isMirron = [data objectAtIndex:7];
    return tempPoint;
    
}


-(void)getListData
{
    [self initContent];
    
    NSString * tempStr = [self getContent];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@">"
                                         withString:@""];
    listData = [[NSArray alloc]init];
    listData = [tempStr componentsSeparatedByString:@"<"];
    
    totalPoint = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < listData.count; i ++)
    {
       if(![[listData objectAtIndex:i] isEqualToString:@""])
       {
           MyPoint * tempPoint = [self getData:[listData objectAtIndex:i]];
           
           if([tempPoint.region isEqual:EarLef])
           {
               [listEarLeft addObject:tempPoint];
           }
           if([tempPoint.region isEqual:EarRight])
           {
               [listEarRight addObject:tempPoint];
           }
           else if( [tempPoint.region isEqual:HafFaceLeft])
           {
               [listHalfLeft addObject:tempPoint];
           }
           else if( [tempPoint.region isEqual:HafFaceRight])
           {
               [listHalfRight addObject:tempPoint];
           }
           else if( [tempPoint.region isEqual:Front])
           {
               [listFront addObject:tempPoint];
           }
           else if( [tempPoint.region isEqual:Nose])
           {
               [listNose addObject:tempPoint];
           }
           
           [totalPoint addObject:tempPoint];
       }
        
    }
}

-(NSArray*)getAllPoint
{
    NSArray * array  = [totalPoint copy];
    return array;
}

-(NSString*)getContent
{

    // get a reference to our file
    NSString *myPath = [[NSBundle mainBundle]pathForResource:@"Resource/Points" ofType:@"txt"];
    
    // read the contents into a string
    NSString *myFile = [[NSString alloc]initWithContentsOfFile:myPath encoding:NSUTF8StringEncoding error:nil];

    return myFile;
}

// Get Data

-(NSArray*)getDataEarLeft
{
    NSArray *array = [listEarLeft copy];
    return array;
}
-(NSArray*)getDataFaceLeft
{

    NSArray *array = [listHalfLeft copy];
    return array;
}
-(NSArray*)getDataFront
{
    NSArray *array = [listFront copy];
    return array;
}
-(NSArray*)getDataFaceRight
{
    NSArray *array = [listHalfRight copy];
    return array;
}
-(NSArray*)getDataEarRight
{
    NSArray *array = [listEarRight copy];
    return array;
}
-(NSArray*)getDataNose
{
    NSArray *array = [listNose copy];
    return array;

}



@end
