//
//  T8VoiceRecordButton.m
//  T8VoiceRecordButtonDemo
//
//  Created by 琦张 on 15/5/25.
//  Copyright (c) 2015年 琦张. All rights reserved.
//

#import "T8VoiceRecordButton.h"
#import "Mp3Recorder.h"
#import "UUProgressHUD.h"

@interface T8VoiceRecordButton ()<Mp3RecorderDelegate>
{
    BOOL isbeginVoiceRecord;
    NSInteger playTime;
    NSTimer *playTimer;
}

@property (nonatomic) Mp3Recorder *MP3;

@end

@implementation T8VoiceRecordButton

+ (UIButton *)buttonWithType:(UIButtonType)buttonType
{
    T8VoiceRecordButton *button = [super buttonWithType:buttonType];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    [button setTitle:@"Hold to Talk" forState:UIControlStateNormal];
    [button setTitle:@"Release to Send" forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:button action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:button action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [button addTarget:button action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [button addTarget:button action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    return button;
}

#pragma mark - method
- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}

#pragma mark - getter
- (Mp3Recorder *)MP3
{
    if (!_MP3) {
        _MP3 = [[Mp3Recorder alloc] initWithDelegate:self];
    }
    return _MP3;
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    [self.MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordBegin)]) {
        [self.delegate recordBegin];
    }
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [self.MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [self.MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"Cancel"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordCancel)]) {
        [self.delegate recordCancel];
    }
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Slide up to cancel"];
}

#pragma mark - Mp3RecorderDelegate
- (void)beginConvert
{
    
}

- (void)endConvertWithData:(NSData *)voiceData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordSucceedWithData:playTime:)]) {
        [self.delegate recordSucceedWithData:voiceData playTime:playTime+1];
    }
    [UUProgressHUD dismissWithSuccess:@"Success"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
}

- (void)failRecord
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordFail)]) {
        [self.delegate recordFail];
    }
    [UUProgressHUD dismissWithSuccess:@"Too short"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
}

@end
