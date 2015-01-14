//
//  ViewController.h
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetChannelScheduleController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *channel;
@property (weak, nonatomic) IBOutlet UIPickerView *channelPicker;
- (IBAction)searchForSchedule:(UIButton *)sender;

@end

