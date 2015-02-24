//
//  SANoteRange.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWNoteRange.h"

@interface WWNoteRange ()

@property WWPitchedNote* topNote;
@property WWPitchedNote* bottomNote;

@end

@implementation WWNoteRange

+(WWNoteRange*)noteRangeWithTopNote:(WWPitchedNote *)topNote andBottomNote:(WWPitchedNote *)bottomNote
{
    WWNoteRange* range = [[WWNoteRange alloc] init];
    [range setTopNote:topNote];
    [range setBottomNote:bottomNote];
    
    return range;
}

-(BOOL)rangeContainsNote:(WWPitchedNote *)note
{
    return ([note compareTo:_bottomNote] >= 0) && ([note compareTo:_topNote] <= 0);
}

@end
