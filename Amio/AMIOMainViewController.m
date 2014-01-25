//
//  AMIOMainViewController.m
//  Amio
//
//  Created by Jesse Chand on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOConstants.h"
#import "AMIOMainViewController.h"

@interface AMIOMainViewController ()

@end

@implementation AMIOMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"amio";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"test";
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, CELL_HEIGHT)];

    /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_PADDING, CELL_PADDING, tableView.frame.size.width, 28)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    
    if (section == 0) {
        [label setText:@"Devon"];
    } else {
        [label setText:@"SPTrees"];
    }
    
    [view addSubview:label];
     */
    
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    
    CGRect headerFrame = view.frame;
    headerFrame.size.height = CELL_HEIGHT;
    view.frame = headerFrame;
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CELL_HEIGHT;
}

/*
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)] autorelease];
    [headerView setBackgroundColor:[UIColor colorWithRed: 39/255.0 green: 41/255.0 blue: 44/255.0 alpha: 1.0]];
    if (section == 0) {
        UILabel* labelAll = [[[UILabel alloc] initWithFrame: CGRectMake(12, 0, headerView.frame.size.width, headerView.frame.size.height)] autorelease];
        labelAll.backgroundColor = [UIColor colorWithRed: 39/255.0 green: 41/255.0 blue: 44/255.0 alpha: 1.0];;
        labelAll.font = [UIFont font1WithSize: 18];
        labelAll.text = NSLocalizedString(@"FILTER", nil);
        labelAll.textColor = [UIColor whiteColor];
        //labelAll.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:labelAll];
    }
    else if (section == 1) {
        UILabel* labelAll = [[[UILabel alloc] initWithFrame: CGRectMake(12, 0, headerView.frame.size.width, headerView.frame.size.height)] autorelease];
        labelAll.backgroundColor = [UIColor colorWithRed: 39/255.0 green: 41/255.0 blue: 44/255.0 alpha: 1.0];;
        labelAll.font = [UIFont font1WithSize: 18];
        labelAll.text = NSLocalizedString(@"FRATERNITIES", nil);
        labelAll.textColor = [UIColor whiteColor];
        //labelAll.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:labelAll];
    }
    else if (section == 2) {
        UILabel* labelAll = [[[UILabel alloc] initWithFrame: CGRectMake(12, 0, headerView.frame.size.width, headerView.frame.size.height)] autorelease];
        labelAll.backgroundColor = [UIColor colorWithRed: 39/255.0 green: 41/255.0 blue: 44/255.0 alpha: 1.0];;
        labelAll.font = [UIFont font1WithSize: 18];
        labelAll.text = NSLocalizedString(@"SORORITIES", nil);
        labelAll.textColor = [UIColor whiteColor];
        //labelAll.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:labelAll];
    }
    
    CGRect headerFrame = headerView.frame;
    headerFrame.size.height = 40;
    headerView.frame = headerFrame;
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    return headerView;
}
 */

@end
