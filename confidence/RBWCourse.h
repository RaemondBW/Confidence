//
//  RBWCourse.h
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBWCourse : NSObject

@property NSString *school;
@property NSString *course;
@property NSString *objectID;
@property BOOL member;
@property BOOL changed;

- (NSString *) getString;
- (id)copyWithZone:(NSZone *)zone;

@end
