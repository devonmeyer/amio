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
    
    void (^loadContentArray)(NSArray *, NSError *);
    void (^loadAllChoresArray)(NSArray *, NSError *);
    
}

@property AMIOGroup * activeGroup;
@property AMIOUser * activeUser;


@end
