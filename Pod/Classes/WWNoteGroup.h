//
//  SANoteGroup.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWPitchedNote.h"

@interface WWNoteGroup : NSObject <NSFastEnumeration>

+(WWNoteGroup*)noteGroup;

-(void)setNotes:(NSMutableArray*)array;
-(WWPitchedNote*)previousNote;
-(WWPitchedNote*)nextNote;
-(WWPitchedNote*)noteAtIndex:(NSInteger)index;
-(WWPitchedNote*)randomNote;

@end
