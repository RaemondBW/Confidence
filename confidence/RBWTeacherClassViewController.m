//
//  RBWTeacherClassViewController.m
//  confidence
//
//  Created by Raemond on 4/12/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWTeacherClassViewController.h"
#import "RBWAppDelegate.h"

@interface RBWTeacherClassViewController ()

@end

@implementation RBWTeacherClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _appDelegate = (RBWAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
