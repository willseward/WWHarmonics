//
//  SAHarmonicSeries.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWPitchedNote.h"

@interface WWHarmonicSeries : NSObject

@property WWPitchedNote* bassNote;

+(WWHarmonicSeries*)harmonicSeriesWithNote:(WWPitchedNote*)note;

-(double)frequencyAtPartial:(NSInteger)partial;

@end
