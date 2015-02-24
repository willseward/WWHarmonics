//
//  SASlidePosition.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWSlidePosition.h"

@implementation WWSlidePosition

+(WWSlidePosition*)slidePositionWithPartial:(NSInteger)partial slidePosition:(NSInteger)position withDeviation:(double)deviation onValve:(NSInteger)valve
{
    WWSlidePosition* slide = [[WWSlidePosition alloc] init];
    
    [slide setPartial:partial];
    [slide setSlidePosition:position];
    [slide setDeviation:deviation];
    [slide setValveNumber:valve];
    
    return slide;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"Position: %ld inPartial: %ld withDeviation: %f onValve: %ld", (long)[self slidePosition], (long)[self partial], [self deviation], (long)[self valveNumber]];
}

@end
