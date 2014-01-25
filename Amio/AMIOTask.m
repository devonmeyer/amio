//
//  AMIOTask.m
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOTask.h"
#import "AMIOGroup.h"
#import "AMIOUser.h"
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

+ (void) getTasksForGroup:(AMIOGroup *)aGroup withBlock:(void (^)(NSArray *objects, NSError *error)) block;
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    
    [query findObjectsInBackgroundWithBlock:block];
    
}

+ (void) getTasksForGroup:(AMIOGroup *)aGroup exceptUser:(AMIOUser *)aUser withBlock:(void (^)(NSArray *, NSError *))block
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    [query whereKey:@"assignee" notEqualTo:aUser];
    
    [query findObjectsInBackgroundWithBlock:block];
    
}

+ (void) getTasksForUser:(AMIOUser *)aUser withTarget:(id)aTarget withSelector:(SEL)aSelector
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"assignee" equalTo:aUser];
    
    [query findObjectsInBackgroundWithTarget:aTarget selector:aSelector];
    
}

+ (void) getTasksForGroup:(AMIOGroup *)aGroup withTarget:(id)aTarget withSelector:(SEL)aSelector
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    
    [query findObjectsInBackgroundWithTarget:aTarget selector:aSelector];
    
}

+ (void) getTasksForGroup:(AMIOGroup *)aGroup exceptUser:(AMIOUser *)aUser  withTarget:(id)aTarget withSelector:(SEL)aSelector
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"group" equalTo:aGroup];
    [query whereKey:@"assignee" notEqualTo:aUser];
    
    [query findObjectsInBackgroundWithTarget:aTarget selector:aSelector];
    
}


- (id) init
{
    
    self = [super init];
    
    if (self) {
                
    }
    
    
    return self;
    
}

- (void) assignUserToTaskWithArray:(NSArray *) objects withError:(NSError *) error
{
    
    if (!error) {
        
        [self setAssignee:objects[0]];
        
        // Set due date... for now, just add a week.
        
        [[self dueDate] dateByAddingTimeInterval:604800];
        
        [self saveInBackground];
        
    }
    
}

- (void) taskCompleted
{
    
    // Re assign
    [[self group] fetchIfNeeded];
    
    AMIOUser * currentAssignee = [self assignee];
    int myIndex = [[[self group] members] indexOfObject:[currentAssignee objectId]];
    
    int numberGroupMembers = [[[self group] members] count];
    
    int newIndex = ((myIndex + 1) % numberGroupMembers);
    NSString * newUserId = [[[self group] members] objectAtIndex:newIndex];
    
    [AMIOUser getUserByID:newUserId withTarget:self withSelector:@selector(assignUserToTaskWithArray:withError:)];    
    
}

@end
