//
//  RBWSelectCoursesTableViewController.m
//  confidence
//
//  Created by Raemond on 4/8/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWSelectCoursesTableViewController.h"
#import <Parse/Parse.h>
#import "RBWCourse.h"

@interface RBWSelectCoursesTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

//@property NSMutableArray *memberCourses;

@end

@implementation RBWSelectCoursesTableViewController

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RBWCourse *tappedItem = [_courses objectAtIndex:indexPath.row];
    tappedItem.member = !tappedItem.member;
    tappedItem.changed = !tappedItem.changed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

- (void) loadCoursesFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"courses"];
    //[query whereKey:@"teacher" equalTo:[PFUser currentUser]];
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
                NSMutableArray *classmates = object[@"students"];
                
                if ([classmates count] == 0) {
                    class.member = NO;
                }
                
                for (PFUser *student in classmates) {
                    if ([[student objectId] compare:[[PFUser currentUser] objectId]] == NSOrderedSame) { // TODO UGH Linear Time Search Get rid of this
                        class.member = YES;
                        break;
                    } else {
                        class.member = NO;
                    }
                }
                
                [self.courses addObject:class];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    RBWCourse *item = [_courses objectAtIndex:indexPath.row];
    cell.textLabel.text = [item getString];
    if (item.member) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;
    for (RBWCourse *class in _courses) {
        if (class.changed) {
            if (class.member) {
                PFQuery *object = [PFQuery queryWithClassName:@"courses"];
                [object getObjectInBackgroundWithId:class.objectID block:^(PFObject *classObject, NSError *error) {
                    [classObject addObject:[PFUser currentUser] forKey:@"students"];
                    [classObject saveInBackground];
                }];
            } else {
                PFQuery *object = [PFQuery queryWithClassName:@"courses"];
                [object getObjectInBackgroundWithId:class.objectID block:^(PFObject *classObject, NSError *error) {
                    [classObject removeObject:[PFUser currentUser] forKey:@"students"];
                    [classObject saveInBackground];
                }];
            }
        }
    }
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
