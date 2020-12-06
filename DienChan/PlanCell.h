//
//  PlanCell.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UICollectionViewCell
{
    UILabel * lblContent;
    UIImageView * img;
}
-(void)setData:(NSString*)str;
-(void)seletedCell:(BOOL)isSelected;
@end
