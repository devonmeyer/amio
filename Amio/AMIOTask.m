//
//  AMIOTask.m
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOTask.h"
#import <Parse/PFObject+Subclass.h>

@implementation AMIOTask

@dynamic name, assignee, group, dueDate, frequency, type, frequencyUnit, status;

+ (NSString *) parseClassName
{
    
    return @"AMIOTask";
    
}

+ (NSArray *) getTasksForUser:(AMIOUser *)aUser
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"assignee" equalTo:aUser];
    
    NSArray * ret = [query findObjects];
    
    return ret;
    
}

+ (NSArray *) getTasksForGroup:(AMIOGroup *)aGroup
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    
    return [query findObjects];
    
}

+ (PFQuery *) getQueryTasksForGroup:(AMIOGroup *)aGroup
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    
    return query;
    
}

+ (PFQuery *) getQueryTasksForUser:(AMIOUser *)aUser
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"assignee" equalTo:aUser];
    
    return query;
    
}

+ (void) getTasksForUser:(AMIOUser *)aUser withBlock:(void (^)(NSArray *objects, NSError *error)) block
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"assignee" equalTo:aUser];
    
    [query findObjectsInBackgroundWithBlock:block];
    
}


- (id) init
{
    
    self = [super init];
    
    return self;
    
}

@end
