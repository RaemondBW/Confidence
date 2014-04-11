//
//  RBWCourse.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWCourse.h"

@implementation RBWCourse

- (void) RBWCourse
{
    _changed = NO;
}

- (NSString *) getString
{
    NSString *result = _school;
    result = [result stringByAppendingString:@" : "];
    result = [result stringByAppendingString:_course];
    return result;
}

- (id)copyWithZone:(NSZone *)zone
{
    RBWCourse *copy = [[RBWCourse alloc] init];

    // Copy NSObject subclasses
    copy.school = _school;
    copy.course = _course;
    copy.objectID = _objectID;
    copy.member = _member;
    
    return copy;
}

@end
