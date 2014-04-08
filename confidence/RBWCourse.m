//
//  RBWCourse.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWCourse.h"

@implementation RBWCourse

- (NSString *) getString
{
    NSString *result = _school;
    result = [result stringByAppendingString:@" : "];
    result = [result stringByAppendingString:_course];
    return result;
}

@end
