//
//  RBWFeelingViewController.h
//  confidence
//
//  Created by Raemond on 4/9/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBWFeelingViewController : UIViewController

- (IBAction)goodButton:(id)sender;
- (IBAction)neutralButton:(id)sender;
- (IBAction)badButton:(id)sender;

- (IBAction) unwindToString:(UIStoryboardSegue *) segue;

@end
