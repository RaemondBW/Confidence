//
//  RBWTeacherTableViewController.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWTeacherTableViewController.h"
#import "RBWTClassCreatorViewController.h"
#import "RBWCourse.h"
#import "RBWAppDelegate.h"
#import "RBWCourseTableViewCell.h"
#import "RBWTeacherClassViewController.h"
#import <Parse/Parse.h>

@interface RBWTeacherTableViewController ()

@property NSMutableArray *courses;
@property RBWTeacherClassViewController *controller;

@end

@implementation RBWTeacherTableViewController


-(IBAction) unwindToList:(UIStoryboardSegue *)segue
{
    RBWTClassCreatorViewController *source = [segue sourceViewController];
    RBWCourse *item = source.course;
    if (item != nil) {
        [self.courses addObject:item];
        [self.tableView reloadData];
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _courses = [[NSMutableArray alloc] init];
    [self loadCoursesFromParse];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_courses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RBWCourse *item = [_courses objectAtIndex:indexPath.row];
    cell.textLabel.text = [item getString];//item.course;
    // Configure the cell...
    
    /*RBWCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSLog(@"Called");
        //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RBWCourseTableViewCell" owner:self options:nil];
        //cell = [nib objectAtIndex:0];
        [tableView registerNib:[UINib nibWithNibName:@"RBWCourseTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    RBWCourse *item = [_courses objectAtIndex:indexPath.row];
    cell.schoolLable.text = item.school;
    cell.courseLabel.text = item.course;*/

    return cell;
}

- (void) loadCoursesFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"courses"];
    [query whereKey:@"teacher" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                RBWCourse *class = [[RBWCourse alloc] init];
                class.course = object[@"courseName"];
                class.school = object[@"school"];
                class.objectID = [object objectId];
                [self.courses addObject:class];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RBWCourse *course = [_courses objectAtIndex:indexPath.row];
    if ([course objectID] == nil) {
        PFQuery *query = [PFQuery queryWithClassName:@"courses"];
        [query whereKey:@"courseName" equalTo:[course course]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                NSLog([course course]);
                for (PFObject *object in objects) {
                    course.objectID = object[@"objectId"];
                    NSLog(course.objectID);
                }
                NSString *channel = @"c";
                channel = [channel stringByAppendingString:[course objectID]];
                RBWAppDelegate *delegate = (RBWAppDelegate *)[[UIApplication sharedApplication] delegate];
                delegate.currentCourse = [course objectID];
                
                PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                [currentInstallation addUniqueObject:channel forKey:@"channels"];
                [currentInstallation saveInBackground];
                _controller.course = [course getString];
            }
        }];
    } else {
        NSLog(@"called the selector in the teacher controller!");
        NSString *channel = @"c";
        channel = [channel stringByAppendingString:[course objectID]];
        NSLog(@"%@", channel);
        
        RBWAppDelegate *delegate = (RBWAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.currentCourse = [course objectID];
        
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        [currentInstallation addUniqueObject:channel forKey:@"channels"];
        [currentInstallation saveInBackground];
        
        _controller.course = [course getString];
    }
    
    //Here is how to remove a channel
    /*/ When users indicate they are no longer Giants fans, we unsubscribe them.
     PFInstallation *currentInstallation = [PFInstallation currentInstallation];
     [currentInstallation removeObject:@"Giants" forKey:@"channels"];
     [currentInstallation saveInBackground];*/
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    _controller = (RBWTeacherClassViewController *) segue.destinationViewController;
}



@end
