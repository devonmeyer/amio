//
//  AMIOMainViewController.h
//  Amio
//
//  Created by Jesse Chand on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class AMIOGroup, AMIOUser;

@interface AMIOMainViewController : UITableViewController
{
    
}

@property AMIOGroup * activeGroup;
@property AMIOUser * activeUser;

- (void) loadContentArrayFromArray:(NSArray *)objects
                         withError:(NSError *) error;

- (void) loadAllChoresArrayFromArray:(NSArray *)objects
                           withError:(NSError *) error;

- (void) loadActiveUserFromArray:(NSArray *)objects
                       withError:(NSError *) error;

- (void) loadActiveGroupFromArray:(NSArray *)objects
                        withError:(NSError *) error;

- (void) updateAllChoreArray;

- (void) updateContentArray;

- (void) updateBothArrays;


@end
