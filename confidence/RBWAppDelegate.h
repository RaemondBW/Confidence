//
//  RBWAppDelegate.h
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property BOOL pushNotifications;
//@property NSDictionary *sentiments;
@property NSMutableArray *sentiments;
@property NSMutableArray *movingAverages;
@property NSString *currentCourse;
@property NSString *course;
@property BOOL changed;

@end
