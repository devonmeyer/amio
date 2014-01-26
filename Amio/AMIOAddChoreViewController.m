//
//  AMIOChoreViewController.m
//  Amio
//
//  Created by Daniel Silva on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOAddChoreViewController.h"
#import "AMIOConstants.h"

@interface AMIOAddChoreViewController () <UITextFieldDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) UISegmentedControl* segmentedControl;
@property (nonatomic, strong) UILabel* onceLabel;
@property (nonatomic, strong) UILabel* alertLabel;
@property (nonatomic, strong) UIImageView* alertView;
@property (nonatomic, strong) UIPickerView* myPickerView;

@end


@implementation AMIOAddChoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }

    UIView *textContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, CELL_HEIGHT)];
    textContainer.backgroundColor = [UIColor colorWithRed:230.0 / 255.0 green:230.0 / 255.0 blue:230.0 / 255.0 alpha:1.0];
    [self.view addSubview:textContainer];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CELL_PADDING, 62, self.view.frame.size.width, CELL_HEIGHT)];
    textField.delegate = self;
    textField.placeholder = @"Task name";
    textField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
    textField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textField];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"once", @"repeating", @"alert", nil];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    _segmentedControl.frame = CGRectMake(CELL_PADDING, 60 + CELL_HEIGHT + CELL_PADDING, self.view.frame.size.width - CELL_PADDING*2, CELL_HEIGHT/2);
    _segmentedControl.selectedSegmentIndex = 1;
    _segmentedControl.tintColor = [UIColor orangeColor];
    [_segmentedControl addTarget:self
                         action:@selector(updateSegmentView)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    _onceLabel = [[UILabel alloc] init];
    _onceLabel.frame = CGRectMake(CELL_PADDING, 60 + CELL_HEIGHT + CELL_PADDING*2 + CELL_HEIGHT/2, self.view.frame.size.width - CELL_PADDING*2, CELL_HEIGHT/2);
    _onceLabel.backgroundColor = [UIColor clearColor];
    _onceLabel.text = @"task will be deleted upon completion";
    _onceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
    _onceLabel.textAlignment = NSTextAlignmentCenter;
    [_onceLabel setHidden:YES];
    [self.view addSubview:_onceLabel];
    
    _alertLabel = [[UILabel alloc] init];
    _alertLabel.frame = CGRectMake(CELL_PADDING, 60 + CELL_HEIGHT + CELL_PADDING*2 + CELL_HEIGHT/2, self.view.frame.size.width - CELL_PADDING*2, CELL_HEIGHT/2);
    _alertLabel.backgroundColor = [UIColor clearColor];
    _alertLabel.text = @"tap         to assign task when needed";
    _alertLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    [_alertLabel setHidden:YES];
    [self.view addSubview:_alertLabel];
    
    _alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert"]];
    _alertView.frame = CGRectMake(52, 145, 48, 48);
    [_alertView setHidden:YES];
    [self.view addSubview:_alertView];

    _myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CELL_PADDING, 60 + CELL_HEIGHT + CELL_PADDING*2 + CELL_HEIGHT/2, self.view.frame.size.width - CELL_PADDING*2, CELL_HEIGHT)];
    _myPickerView.delegate = self;
    _myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:_myPickerView];
    
    UILabel *doneLabel = [[UILabel alloc] init];
    doneLabel.frame = CGRectMake(0, self.view.frame.size.height - CELL_HEIGHT, self.view.frame.size.width, CELL_HEIGHT);
    doneLabel.backgroundColor = [UIColor orangeColor];
    doneLabel.text = @"Add Task";
    doneLabel.textAlignment = NSTextAlignmentCenter;
    doneLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:28.0f];
    doneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:doneLabel];
    
    doneLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [doneLabel addGestureRecognizer:tapGesture];
    
    return self;
}

- (void)didTapLabelWithGesture:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Tapped Done");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateSegmentView {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        [_onceLabel setHidden:NO];
        [_alertLabel setHidden:YES];
        [_alertView setHidden:YES];
        [_myPickerView setHidden:YES];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        [_onceLabel setHidden:YES];
        [_alertLabel setHidden:YES];
        [_alertView setHidden:YES];
        [_myPickerView setHidden:NO];
    } else {
        [_onceLabel setHidden:YES];
        [_alertLabel setHidden:NO];
        [_alertView setHidden:NO];
        [_myPickerView setHidden:YES];
    }
}

//Here we initiallize the array for UIPicker,
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"amio";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    [pickerView endEditing:YES];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows;
    if (component == 0) {
        numRows = 12;
    } else {
        numRows = 4;
    }
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    NSDictionary *titlesRight = @{ @0: @"day(s)",
                                   @1: @"week(s)",
                                   @2: @"month(s)",
                                   @3: @"year(s)"
                                   };
    
    
    if (component == 0) {
        title = [@"" stringByAppendingFormat:@"%d", row+1];
    } else {
        title = [titlesRight objectForKey:[NSNumber numberWithInt:row]];
    }
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth;
    if (component == 0) {
        sectionWidth = self.view.frame.size.width/3;
    } else {
        sectionWidth = self.view.frame.size.width/3*2;
    }
    return sectionWidth;
}

@end
