//
//  SchedulesViewController.h
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchedulesViewController : UIViewController<UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) UIToolbar *toolBar;

@property(strong, nonatomic) NSString *channelName;

@end
