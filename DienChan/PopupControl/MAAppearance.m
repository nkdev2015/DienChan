//
//  MZApperance.m
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import "MAAppearance.h"

static NSMutableDictionary *instanceOfClassesDictionary = nil;

@interface MAAppearance ()
@property (strong, nonatomic) Class mainClass;
@property (strong, nonatomic) NSMutableArray *invocations;
@end

@implementation MAAppearance

- (id)initWithClass:(Class)thisClass
{
    _mainClass = thisClass;
    _invocations = [NSMutableArray array];
    
    return self;
}

- (void) applyInvocationTo: (id) target
{
    for (NSInvocation *invocation in self.invocations)
    {
        NSInvocation *targetInvocation = [invocation copy];
        [targetInvocation setTarget:target];
        [targetInvocation invoke];
        targetInvocation = nil;
    }
}

- (void) applyInvocationRecursivelyTo: (id) target upToSuperClass: (Class) superClass
{
    NSMutableArray *classes = [NSMutableArray array];
    
    for (Class class = [target class];
         [class isSubclassOfClass:superClass] || class == superClass;
         class = [class superclass])
    {
        [classes addObject:class];
    }
    
    NSEnumerator *reverseClasses = [classes reverseObjectEnumerator];
    
    for (Class class in reverseClasses)
    {
        [[MAAppearance appearanceForClass:class] applyInvocationTo:target];
    }
}

+ (id) appearanceForClass: (Class) aClass
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instanceOfClassesDictionary = [[NSMutableDictionary alloc] init];
    });
    
    if (![instanceOfClassesDictionary objectForKey:NSStringFromClass(aClass)])
    {
        id appearance = [[self alloc] initWithClass:aClass];
        [instanceOfClassesDictionary setObject:appearance forKey:NSStringFromClass(aClass)];
        return appearance;
    }
    else
    {
        return [instanceOfClassesDictionary objectForKey:NSStringFromClass(aClass)];
    }
    
}

- (void) forwardInvocation: (NSInvocation *) anInvocation;
{
    [anInvocation setTarget:nil];
    [anInvocation retainArguments];
    
    [self.invocations addObject:anInvocation];
}

- (NSMethodSignature *) methodSignatureForSelector: (SEL) aSelector
{
    return [self.mainClass instanceMethodSignatureForSelector:aSelector];
}

@end
