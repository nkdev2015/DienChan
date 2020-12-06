//
//  PlanHelper.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanHelper : NSObject
{
    NSMutableArray * listPlan;
    NSString * contentFile;
    
    NSArray * listData;
}
-(NSString*)getContent;
-(NSArray*)getListPlan;
@end
