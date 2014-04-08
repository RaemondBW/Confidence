//
//  RBWLogInViewController.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWLogInViewController.h"
#import <Parse/Parse.h>


@interface RBWLogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RBWLogInViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender != self.logInButton) return;
    if (self.username.text.length > 0 || self.password.text.length > 0) {
        //self.toDoItem = [[QuizAppItem alloc] init];
        //self.toDoItem.itemName = self.textField.text;
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
}*/

- (IBAction)logInButton:(id)sender {
    if (_username.text.length > 0 && _password.text.length > 0) {
        [PFUser logInWithUsernameInBackground:_username.text password:_password.text block:^(PFUser *user, NSError *error) {
            if (!error) {
                NSLog(@"logged in user!");
                [self performSegueWithIdentifier:@"loginTransition" sender:self];
            }
        }];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
}
@end
