//
//  SANoteRange.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWPitchedNote.h"

@interface WWNoteRange : NSObject

+(WWNoteRange*)noteRangeWithTopNote:(WWPitchedNote*)topNote andBottomNote:(WWPitchedNote*)bottomNote;

-(BOOL)rangeContainsNote:(WWPitchedNote*)note;

-(WWPitchedNote*)topNote;
-(WWPitchedNote*)bottomNote;

@end
