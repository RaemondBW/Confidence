//
//  RBWTeacherClassViewController.h
//  confidence
//
//  Created by Raemond on 4/12/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBWAppDelegate.h"
#import "CorePlot-CocoaTouch.h"

@interface RBWTeacherClassViewController : UIViewController <CPTPlotDataSource>

@property RBWAppDelegate *appDelegate;
@property NSMutableArray *movingAverages;
@property CPTGraph * graph;
@property NSTimer *timer;

@end
