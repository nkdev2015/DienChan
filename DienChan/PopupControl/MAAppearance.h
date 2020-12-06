//
//  MZApperance.h
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MA_APPEARANCE_SELECTOR UI_APPEARANCE_SELECTOR

@protocol MAAppearance <NSObject>

+ (id) appearance;
@end

@interface MAAppearance : NSProxy

- (void) applyInvocationTo: (id) target;
- (void) applyInvocationRecursivelyTo: (id) target upToSuperClass: (Class) superClass;
+ (id) appearanceForClass: (Class) aClass;

@end
