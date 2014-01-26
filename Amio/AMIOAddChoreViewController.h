//
//  AMIOChoreViewController.h
//  Amio
//
//  Created by Daniel Silva on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMIOMainViewController;

@interface AMIOAddChoreViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) IBOutlet UIPickerView *typePicker;
@property (strong, nonatomic)          NSArray *typeArray;

@property (strong, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UIButton *Typebutton1;
@property (strong, nonatomic) IBOutlet UIButton *Typebutton2;

@property (strong, nonatomic) IBOutlet UILabel *typeAnswerLabel;

@property (weak) AMIOMainViewController * mainView;

@property (strong) UITextField *nameField;

@property NSInteger activeFrequencyPickerIndex;
@property NSInteger activeUnitPickerIndex;

@end



