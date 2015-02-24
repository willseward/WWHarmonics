//
//  SAToneGenerator.h
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWToneGenerator : NSObject

@property BOOL hasOutput;

-(void)playTone:(double)frequency forSeconds:(double)seconds;
-(void)stop;


@end
