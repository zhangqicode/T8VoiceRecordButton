//
//  T8VoiceRecordButton.h
//  T8VoiceRecordButtonDemo
//
//  Created by 琦张 on 15/5/25.
//  Copyright (c) 2015年 琦张. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol T8VoiceRecordButtonProtocol <NSObject>

- (void)recordBegin;
- (void)recordSucceedWithData:(NSData *)voiceData playTime:(NSInteger)second;
- (void)recordFail;
- (void)recordCancel;

@end

@interface T8VoiceRecordButton : UIButton

@property (nonatomic,weak) id<T8VoiceRecordButtonProtocol> delegate;

@end
