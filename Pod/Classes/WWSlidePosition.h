//
//  SASlidePosition.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWSlidePosition : NSObject

@property NSInteger partial;
@property NSInteger slidePosition;
@property double deviation;
@property NSInteger valveNumber;

+(WWSlidePosition*)slidePositionWithPartial:(NSInteger)partial slidePosition:(NSInteger)position withDeviation:(double)deviation onValve:(NSInteger)valve;

@end
