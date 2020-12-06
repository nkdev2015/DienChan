//
//  PointHelper.h
//  DienChan
//
//  Created by vankhangfet on 6/30/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointHelper : NSObject
{
    NSArray * listData;
    NSMutableArray * listFront;
    NSMutableArray * listEarLeft;
    NSMutableArray * listEarRight;
    NSMutableArray * listHalfLeft;
    NSMutableArray * listHalfRight;
    NSMutableArray * listNose;
    
    NSMutableArray * totalPoint;

}
-(void)getListData;
-(NSArray*)getDataEarLeft;
-(NSArray*)getDataFaceLeft;
-(NSArray*)getDataFront;
-(NSArray*)getDataFaceRight;
-(NSArray*)getDataEarRight;
-(NSArray*)getDataNose;
-(NSArray*)getAllPoint;
@end
