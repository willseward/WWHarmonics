//
//  SAChromaticGroup.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/21/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWNoteGroup.h"
#import "WWNoteRange.h"
#import "WWScaleGroup.h"

@interface WWChromaticGroup : WWNoteGroup

+(WWChromaticGroup*)chromaticGroupForRange:(WWNoteRange*)range inOrder:(Order)order;

-(WWNoteRange*)range;
-(Order)order;

@end
