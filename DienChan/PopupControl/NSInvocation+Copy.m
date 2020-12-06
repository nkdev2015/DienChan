//
//  NSInvocation+Copy.m
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import "NSInvocation+Copy.h"
#import <string.h>

BOOL jbb_strStartsWith(const char *aString, const char *aPrefix)
{
    return strncmp(aPrefix, aString, strlen(aPrefix)) == 0;
}

BOOL jbb_strCaseStartsWith(const char *aString, const char *aPrefix)
{
    return strncasecmp(aPrefix, aString, strlen(aPrefix)) == 0;
}

const char* jbb_removeObjCTypeQualifiers(const char *aType)
{
    if (jbb_strCaseStartsWith(aType, "r") || jbb_strCaseStartsWith(aType, "n") || jbb_strCaseStartsWith(aType, "o") || jbb_strStartsWith(aType, "V"))
    {
        char *newString = (char *)malloc(sizeof(aType) - 1);
        strncpy(newString, aType + 1, sizeof(aType) - 1);
        const char *returnString = jbb_removeObjCTypeQualifiers(newString);
        free(newString);
        return returnString;
    }
    else
    {
        return aType;
    }
}

BOOL jbb_ObjCTypeStartsWith(const char *objCType, const char *targetChar)
{
    const char *newObjCType = jbb_removeObjCTypeQualifiers(objCType);
    
    return strncmp(newObjCType, targetChar, 1);
}

BOOL jbb_areObjCTypesEqual(const char *lhs, const char *rhs)
{
    const char *newLhs = jbb_removeObjCTypeQualifiers(lhs);
    const char *newRhs = jbb_removeObjCTypeQualifiers(rhs);
    
    return strcmp(newLhs, newRhs) == 0;
}

@implementation NSInvocation (Copy)

- (id) copy
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self.methodSignature];
    NSUInteger numberOfArguments = [[self methodSignature] numberOfArguments];
    
    [invocation setTarget:self.target];
    [invocation setSelector:self.selector];
    
    if (numberOfArguments > 2)
    {
        for (int i = 0; i < (numberOfArguments - 2); i++)
        {
            NSInteger index = i+2;
            
            const char *typeForArg = [self.methodSignature getArgumentTypeAtIndex:index];
            
            if (jbb_areObjCTypesEqual(typeForArg, @encode(char)))
            {
                char arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(unsigned char)))
            {
                unsigned char arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(short)))
            {
                short arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(unsigned short)))
            {
                unsigned short arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(int)))
            {
                int arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(unsigned int)))
            {
                unsigned int arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(long)))
            {
                long arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(unsigned long)))
            {
                unsigned long arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(long long)))
            {
                long long arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(unsigned long long)))
            {
                unsigned long long arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(float)))
            {
                float arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(double)))
            {
                double arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(id)))
            {
                char buffer[sizeof(intmax_t)];
                [self getArgument:(void *)&buffer atIndex:i + 2];
                [invocation setArgument:(void *)&buffer atIndex:i + 2];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(SEL)))
            {
                SEL arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(Class)))
            {
                Class arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(char *)))
            {
                char *arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(NSRange)))
            {
                NSRange arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(CGPoint)))
            {
                CGPoint arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(CGSize)))
            {
                CGSize arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_areObjCTypesEqual(typeForArg, @encode(CGRect)))
            {
                CGRect arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_ObjCTypeStartsWith(typeForArg, "^"))
            {
                void *arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            
            else if (jbb_ObjCTypeStartsWith(typeForArg, "@"))
            {
                id arg;
                [self getArgument:&arg atIndex:index];
                [invocation setArgument:&arg atIndex:index];
            }
            else
            {
                NSAssert1(false, @"Unhandled ObjC Type (%s)", typeForArg);
            }
            
        }
    }
    
    return invocation;
}

@end
