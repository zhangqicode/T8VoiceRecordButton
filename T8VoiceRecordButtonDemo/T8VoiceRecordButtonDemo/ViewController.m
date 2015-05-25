//
//  ViewController.m
//  T8VoiceRecordButtonDemo
//
//  Created by 琦张 on 15/5/25.
//  Copyright (c) 2015年 琦张. All rights reserved.
//

#import "ViewController.h"
#import "T8VoiceRecordButton.h"

@interface ViewController ()<T8VoiceRecordButtonProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    T8VoiceRecordButton *btn = [T8VoiceRecordButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, screenSize.height-55, screenSize.width-200, 50);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [btn.tintColor CGColor];
    btn.layer.cornerRadius = 5;
    btn.delegate = self;
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - T8VoiceRecordButtonProtocol
- (void)recordBegin
{
    NSLog(@"recordBegin...");
}

- (void)recordSucceedWithData:(NSData *)voiceData playTime:(NSInteger)second
{
    NSLog(@"recordSucceedWithData...");
}

- (void)recordFail
{
    NSLog(@"recordFail...");
}

- (void)recordCancel
{
    NSLog(@"recordCancel...");
}

@end
