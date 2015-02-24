//
//  SATrombone.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWPitchedNote.h"

@protocol WWTrombone <NSObject>

-(NSArray*)slidePositionsGivenNote:(WWPitchedNote*)note inSimpleNotation:(BOOL)simple;

@property NSArray* harmonicSeries;

@end
