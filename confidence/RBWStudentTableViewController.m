//
//  RBWStudentTableViewController.m
//  confidence
//
//  Created by Raemond on 4/8/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWStudentTableViewController.h"
#import "RBWSelectCoursesTableViewController.h"
#import "RBWCourse.h"
#import <Parse/Parse.h>

@interface RBWStudentTableViewController ()

@property NSMutableArray *courses;

@end

@implementation RBWStudentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) unwindToList:(UIStoryboardSegue *)segue
{
    RBWSelectCoursesTableViewController *source = [segue sourceViewController];
    NSMutableArray *classes = source.courses;
    if (classes != nil) {
        for (RBWCourse *class in classes) {
            if (class.member && ![_courses containsObject:[class getString]]) {
                [_courses addObject:[class getString]];
            }
        }
        //[self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _courses = [[NSMutableArray alloc] init];
    [self loadDataFromParse];
    
    // TODO here is where we would load the courses that we are already a member of.
    
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_courses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *item = [_courses objectAtIndex:indexPath.row];
    cell.textLabel.text = item;
    // Configure the cell...
    
    return cell;
}

- (void) loadDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"courses"];
    [query whereKey:@"students" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu courses.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                RBWCourse *class = [[RBWCourse alloc] init];
                class.course = object[@"courseName"];
                class.school = object[@"school"];
                class.member = YES;
                class.objectID = [object objectId];
                [self.courses addObject:[class getString]];
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
    _chosen = [_courses objectAtIndex:indexPath.row];
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
}


@end
