//
//  RBWTClassCreatorViewController.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWTClassCreatorViewController.h"
#import <Parse/Parse.h>

@interface RBWTClassCreatorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *schoolName;
@property (weak, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation RBWTClassCreatorViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.addButton) return;
    if (_schoolName.text.length > 0 && _courseName.text.length > 0) {
        _course = [[RBWCourse alloc] init];
        _course.school = _schoolName.text;
        _course.course = _courseName.text;
        
        PFObject *classObject = [PFObject objectWithClassName:@"courses"];
        classObject[@"school"] = _schoolName.text;
        classObject[@"courseName"] = _courseName.text;
        classObject[@"teacher"] = [PFUser currentUser];
        [classObject saveInBackground];
    }
}



@end
