//
//  Plan.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "Plan.h"

@implementation Plan
@synthesize planID = _planID;
@synthesize desPlan = _desPlan;
@synthesize arrList = _arrList;
@synthesize notePlan = _notePlan;
@synthesize listNumber = _listNumber;
-(id)copyWithZone:(NSZone *)zone
{
    Plan * plan = [[Plan allocWithZone:zone]init];
    plan.planID = self.planID;
    plan.desPlan = self.desPlan;
    plan.arrList = self.arrList;
    plan.notePlan = self.notePlan;
    plan.listNumber = self.listNumber;
    return plan;
}
@end
