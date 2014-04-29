//
//  RBWFeelingViewController.m
//  confidence
//
//  Created by Raemond on 4/9/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWFeelingViewController.h"
#import "RBWStudentTableViewController.h"
#import <Parse/Parse.h>

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
    if (_course != nil) {
        NSLog(@"%@", [_course getString]);
    }
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = [_course getString];
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
    PFQuery *query = [PFQuery queryWithClassName:@"sentiment"];
    [query whereKey:@"course" equalTo:[_course objectID]];
    [query whereKey:@"student" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //NSLog([NSString stringWithFormat:@"%lu", objects.count]);
            if (objects.count == 0) {
                PFObject *sentiment = [PFObject objectWithClassName:@"sentiment"];
                sentiment[@"course"] = [_course objectID];
                sentiment[@"student"] = [PFUser currentUser];
                sentiment[@"sentiment"] = @3;
                [sentiment saveInBackground];
            }
            // Do something with the found objects
            for (PFObject *object in objects) {
                object[@"sentiment"] = @3;
                [object saveInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)neutralButton:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"sentiment"];
    [query whereKey:@"course" equalTo:[_course objectID]];
    [query whereKey:@"student" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0) {
                PFObject *sentiment = [PFObject objectWithClassName:@"sentiment"];
                sentiment[@"course"] = [_course objectID];
                sentiment[@"student"] = [PFUser currentUser];
                sentiment[@"sentiment"] = @2;
                [sentiment saveInBackground];
            }
            // Do something with the found objects
            for (PFObject *object in objects) {
                object[@"sentiment"] = @2;
                [object saveInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (IBAction)badButton:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"sentiment"];
    [query whereKey:@"course" equalTo:[_course objectID]];
    [query whereKey:@"student" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0) {
                PFObject *sentiment = [PFObject objectWithClassName:@"sentiment"];
                sentiment[@"course"] = [_course objectID];
                sentiment[@"student"] = [PFUser currentUser];
                sentiment[@"sentiment"] = @1;
                [sentiment saveInBackground];
            }
            // Do something with the found objects
            for (PFObject *object in objects) {
                object[@"sentiment"] = @1;
                [object saveInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

@end
