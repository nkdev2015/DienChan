//
//  Plan.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject <NSCopying>
@property (nonatomic,strong) NSString * planID;
@property (nonatomic,strong) NSString* desPlan;
@property (nonatomic,strong) NSString* arrList;
@property (nonatomic,strong) NSString* notePlan;
@property (nonatomic,strong) NSString* listNumber;
-(id)copyWithZone:(NSZone *)zone;
@end
