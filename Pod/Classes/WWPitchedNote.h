//
//  SAPitchedNote.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWNote.h"

typedef enum { O0 = 12, O1 = 24, O2 = 36, O3 = 48, O4 = 60, O5 = 72, O6 = 84, O7 = 96, O8 = 108 } Octave;


@interface WWPitchedNote : WWNote 

+(WWPitchedNote*)pitchedNoteWithNote:(WWNote*)note inOctave:(Octave)octave;
+(WWPitchedNote*)pitchedNoteWithNote:(WWNote*)note inOctave:(Octave)octave andTuningKey:(WWNote*)key;

-(double)frequency;
-(NSString*)scientificNotation;
-(NSInteger)compareTo:(WWPitchedNote*)note;
-(WWPitchedNote*)pitchedNote;

-(Octave)octave;
-(WWNote*)tuningKey;

@end

