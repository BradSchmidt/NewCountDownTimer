//
//  CountDownViewController.h
//  NewCountDownTimer
//
//  Created by Bradley Robert Schmidt on 4/28/14.
//  Copyright (c) 2014 Bradley Robert Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownViewController : UIViewController
{
    __weak IBOutlet UIDatePicker *countDownTimer;
    __weak IBOutlet UILabel *timerRunningLabel;
    
    int countDownTime;
    BOOL isTimerRunning;
    int timeDifference;
    
    NSTimer *initialTimer;
}

- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *stopButtonOutlet;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *viewDidLoadDate;

- (void)buttonStateWithStartState:(BOOL)startState cancelState:(BOOL)cancelState;
@end
