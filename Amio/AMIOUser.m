//
//  AMIOUser.m
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOUser.h"
#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@implementation AMIOUser

@dynamic name;

+ (NSString *) parseClassName
{
    
    return @"AMIOUser";
    
}

+(void) getUserByID:(NSString *)anId withTarget:(id)aTarget withSelector:(SEL)aSelector
{
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"objectId" equalTo:anId];
    
    [query findObjectsInBackgroundWithTarget:aTarget selector:aSelector];
    
}

+ (void) getUserByID:(NSString *)anId withBlock:(void (^)(NSArray *objects, NSError *error)) block;
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"objectId" equalTo:anId];
    
    [query findObjectsInBackgroundWithBlock:block];
    
}

+ (NSArray *) getUserByID:(NSString *)anId
{
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"objectId" equalTo:anId];
    
    return [query findObjects];
    
}

@end
