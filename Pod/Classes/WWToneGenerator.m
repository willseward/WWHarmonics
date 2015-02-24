//
//  SAToneGenerator.m
//  SAHarmonics
//
//  Created by Wills Ward on 10/22/13.
//  Copyright (c) 2013 WillWorks. All rights reserved.
//

#import "WWToneGenerator.h"
#import <AudioToolbox/AudioToolbox.h>

@interface WWToneGenerator () {

}

@property AudioComponentInstance audioUnitInstance;
@property double currentTheta;
@property (nonatomic)  double frequency;

-(double)amplitude;

@end

OSStatus RenderTone(void *inRefCon, AudioUnitRenderActionFlags *ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData)
{
    // Fixed amplitude is good enough for our purposes
    
    // Get the tone parameters out of the view controller
    WWToneGenerator *container = (__bridge WWToneGenerator *)inRefCon;
    double theta = container.currentTheta;
    double theta_increment = 2.0 * M_PI * container.frequency / 44100.0;
    const double amplitude = [container amplitude];
    
    
    // This is a mono tone generator so we only need the first buffer
    const int channel = 0;
    Float32 *buffer = (Float32 *)ioData->mBuffers[channel].mData;
    
    // Generate the samples
    for (UInt32 frame = 0; frame < inNumberFrames; frame++)
    {
        buffer[frame] = sin(theta) * amplitude;
        
        theta += theta_increment;
        if (theta > 2.0 * M_PI)
        {
            theta -= 2.0 * M_PI;
        }
    }
    
    // Store the updated theta back in the view controller
    container.currentTheta = theta;
    
    return noErr;
}

@implementation WWToneGenerator {
    NSTimer* _timer;
    double _numRef;
    double _amplitude;
    double _buff;
}

-(id)init
{
    if (self = [super init]) {
        OSStatus result = AudioSessionInitialize(NULL, NULL, ToneInterruptionListener, (__bridge void *)(self));
        if (result == kAudioSessionNoError)
        {
            UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
            AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        }
        AudioSessionSetActive(true);
        [self createAudioUnit];
    }
    
    OSErr error = AudioUnitInitialize(_audioUnitInstance);
    NSAssert1(error == noErr, @"Error initializing audio unit: %hd", error);
    
    return self;
}

-(void)createAudioUnit
{
    AudioComponentDescription comp;
    comp.componentType = kAudioUnitType_Output;
    comp.componentSubType = kAudioUnitSubType_RemoteIO;
    comp.componentManufacturer = kAudioUnitManufacturer_Apple;
    comp.componentFlags = 0;
    comp.componentFlagsMask = 0;
    
    AudioComponent audioComponent = AudioComponentFindNext(NULL, &comp);
    NSAssert(audioComponent, @"Could not find output");
    
    OSErr error = AudioComponentInstanceNew(audioComponent, &_audioUnitInstance);
    NSAssert1(_audioUnitInstance, @"Error making audio component instance %hd", error);
    
    AURenderCallbackStruct inputFunction;
    inputFunction.inputProc = RenderTone;
    inputFunction.inputProcRefCon = (__bridge void *)(self);
    error = AudioUnitSetProperty(_audioUnitInstance, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Input, 0, &inputFunction, sizeof(inputFunction));
    NSAssert1(error == noErr, @"Error setting render function: %hd", error);
    
    const int bytesPerFloat = 4;
    const int bitsPerByte = 8;
    
    AudioStreamBasicDescription streamDescription;
    streamDescription.mSampleRate = 44100;
    streamDescription.mFormatID = kAudioFormatLinearPCM;
    streamDescription.mFormatFlags = kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    streamDescription.mBytesPerPacket = bytesPerFloat;
    streamDescription.mFramesPerPacket = 1;
    streamDescription.mBytesPerFrame = bytesPerFloat;
    streamDescription.mChannelsPerFrame = 1;
    streamDescription.mBitsPerChannel = bytesPerFloat * bitsPerByte;
    error = AudioUnitSetProperty(_audioUnitInstance, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &streamDescription, sizeof(streamDescription));
    NSAssert1(error == noErr, @"Error setting stream format: %hd", error);
}

-(void)playTone:(double)frequency forSeconds:(double)seconds
{
    AudioSessionSetActive(true);

    [self setFrequency:frequency];
    _amplitude = .25;
    _buff = 20;
    _numRef = 0;
    [self play];
    [self performSelectorInBackground:@selector(stopAfterDelay:) withObject:@(seconds)];
}

-(double)frequency
{
//    if (_numRef < _buff) {
//        double ret = -_frequency*((double)_numRef++ / _buff);
//        return ret;
//    }
    
    return _frequency;
}

-(double)amplitude
{
//    if (_numRef < _buff) {
//        double ret = _amplitude*((double)_numRef++ / _buff);
//        return ret;
//    }

    return _amplitude;
}

void ToneInterruptionListener(void *inClientData, UInt32 inInterruptionState)
{
	WWToneGenerator *container = (__bridge WWToneGenerator *)inClientData;
	
	[container stop];
}

-(void)play
{
    
    
    _hasOutput = YES;
    
    
    OSErr error = AudioOutputUnitStart(_audioUnitInstance);
    NSAssert1(error == noErr, @"Error starting audio: %hd", error);
    
//    while (_amplitude < .25) {
//        _amplitude += .0001;
//        //        _frequency -= 1;
//        [NSThread sleepForTimeInterval:.0001];
//    }
}

-(void)stop
{
    
//    while (_amplitude > 0) {
//        _amplitude -= .0001;
////        _frequency -= .0001;
//        [NSThread sleepForTimeInterval:.0001];
//    }
    
//    AudioOutputUnitStop(_audioUnitInstance);
//    AudioUnitUninitialize(_audioUnitInstance);
//    AudioComponentInstanceDispose(_audioUnitInstance);
//    _audioUnitInstance = nil;
    
    _hasOutput = NO;
//    AudioSessionSetActive(false);
}

-(void)stopAfterDelay:(NSNumber*)seconds
{
    [NSThread sleepForTimeInterval:(seconds.doubleValue)];
    [self stop];
}

@end
