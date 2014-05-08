//
//  RBWTeacherClassViewController.m
//  confidence
//
//  Created by Raemond on 4/12/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWTeacherClassViewController.h"
#import "RBWAppDelegate.h"
#import "RBWSentiment.h"
#import "CorePlot-CocoaTouch.h"

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
    
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: hostView];
    
    //create the graph and add it to the subview
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineWidth = 1.0f;
    
    _graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) _graph.axisSet;
    CPTAxis *y = axisSet.yAxis;
    y.axisLineStyle = axisLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.majorTickLineStyle = gridLineStyle;
    y.majorTickLength = 1.0f;
    y.tickDirection = CPTSignNegative;
    
    hostView.hostedGraph = _graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) _graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 1 ) length:CPTDecimalFromFloat( 3 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 9 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle = [plot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 2.5;
    plot.dataLineStyle = lineStyle;
    CPTPlotSymbol *symbol = [CPTPlotSymbol ellipsePlotSymbol];
    symbol.lineStyle = lineStyle;
    symbol.size = CGSizeMake(6.0f, 6.0f);
    plot.plotSymbol = symbol;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [_graph addPlot:plot toPlotSpace:_graph.defaultPlotSpace];
    
    // Do any additional setup after loading the view.
    _movingAverages = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        [_movingAverages addObject:[NSNumber numberWithInt:2]];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshGraph) userInfo:nil repeats:YES];
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

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    return 10; // Our sample graph contains 10 'points'
}

-(NSNumber *) calculateCurrentAverage
{
    NSNumber *result = [NSNumber numberWithInt:0];
    for (int i=0; i<[_appDelegate.sentiments count]; i++) {
        RBWSentiment *sentiment = [_appDelegate.sentiments objectAtIndex:i];
        result = @([result integerValue] + [[sentiment value] integerValue]);
    }
    for (int i=0; i<10-[_appDelegate.sentiments count]; i++) {
        result = @([result integerValue] + 2);
    }
    result = @([result floatValue] / 10);
    return result;
}

- (void) refreshGraph
{
    NSLog(@"got the the refresh section");
    NSNumber *nextAverage = [self calculateCurrentAverage];
    NSLog(@"got passed the average Calculations");
    NSLog(@"%@", [nextAverage stringValue]);
    [_movingAverages insertObject:nextAverage atIndex:0];
    if ([_movingAverages count] > 10)
        [_movingAverages removeObjectAtIndex:10];
    [_graph reloadData];
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // We need to provide an X or Y (this method will be called for each) value for every index
    int x = index;
    
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithInt: x];
    } else {
        return [_movingAverages objectAtIndex:x];
    }
}

-(void) viewWillDisappear:(BOOL) animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [_timer invalidate];
    }
    [super viewWillDisappear:animated];
}



@end
