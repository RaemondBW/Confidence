//
//  RBWFeelingViewController.m
//  confidence
//
//  Created by Raemond on 4/9/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWFeelingViewController.h"
#import "RBWStudentTableViewController.h"

@interface RBWFeelingViewController ()

@end

@implementation RBWFeelingViewController

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
    NSLog(@"view did load called");
    if (_course != nil)
        NSLog(_course);
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = _course;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) unwindToString:(UIStoryboardSegue *) segue
{
    /*RBWStudentTableViewController *source = [segue sourceViewController];
    NSString *course = source.chosen;
    NSLog(@"Ran unwindToString");
    if (course != nil) {
        NSLog(course);
    }*/

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

- (IBAction)goodButton:(id)sender {
    
}

- (IBAction)neutralButton:(id)sender {
}

- (IBAction)badButton:(id)sender {
}

@end
