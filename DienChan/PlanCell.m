//
//  PlanCell.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "PlanCell.h"

@implementation PlanCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,386,50)];
        img.image = [UIImage imageNamed:@"Resource/NenPlanItem.png"];
        [self.contentView addSubview:img];
        
        lblContent = [[UILabel alloc]initWithFrame:CGRectMake(10,10,360,30)];
        [lblContent setFont:[UIFont fontWithName:@"Helvetica" size:25]];
        [lblContent setTextColor:[UIColor whiteColor]];
        //[self.contentView setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:lblContent];
        
    }
    return self;
}

-(void)setData:(NSString*)str
{
    lblContent.text = str;
}

-(void)seletedCell:(BOOL)isSelected
{
    img.hidden = !isSelected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
