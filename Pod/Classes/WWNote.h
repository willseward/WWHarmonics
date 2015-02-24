//
//  SANote.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWInterval.h"

typedef enum {C, D, E, F, G, A, B } Note;
typedef enum { DOUBLEFLAT = -2, FLAT, NATURAL, SHARP, DOUBLESHARP } Accidental;

@interface WWNote : NSObject

@property Note noteName;
@property Accidental accidental;

+(WWNote*)noteWithNote:(WWNote*)note;
+(WWNote*)noteWithNote:(Note)note andAccidental:(Accidental)accidental;

-(void)transposeUp:(WWInterval)interval;
-(void)transposeDown:(WWInterval)interval;
-(NSInteger)stepsASCToNote:(WWNote*)note;
-(NSInteger)stepsDESCToNote:(WWNote*)note;
-(NSString*)englishNotation;
-(NSInteger)pitchNumber;
-(void)requestFlat;
-(void)requestSharp;
-(void)requestNatural;

-(Note)noteName;
-(WWNote*)note;
-(Accidental)accidental;

@end


