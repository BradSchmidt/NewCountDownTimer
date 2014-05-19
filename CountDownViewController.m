//
//  CountDownViewController.m
//  NewCountDownTimer
//
//  Created by Bradley Robert Schmidt on 4/28/14.
//  Copyright (c) 2014 Bradley Robert Schmidt. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

@synthesize startDate, viewDidLoadDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSInteger savedCountDownTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"CountDownTime"];
    countDownTimer.countDownDuration = savedCountDownTime;
    NSLog(@"The SAVED COUNTDOWN TIME IS %ld MINUTES", (long)savedCountDownTime/60);
    
    viewDidLoadDate = [NSDate date];
    NSLog(@"The VIEW DID APPEAR DATE IS %@", viewDidLoadDate);
    
    NSDate *savedStartDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartDate"];
    NSLog(@"The SAVED START DATE IS %@", savedStartDate);
    
    timeDifference = [viewDidLoadDate timeIntervalSinceDate:savedStartDate];
    NSLog(@"The TIME DIFFERENCE IS: %d", timeDifference);
    
    int fireTime = savedCountDownTime*15-timeDifference;  //final
    //int fireTime = 3*15-timeDifference;
    
    BOOL savedIsTimerRunning = [[NSUserDefaults standardUserDefaults] boolForKey:@"isTimerRunning"];
    if (savedIsTimerRunning == true) {
        [self set];
        NSLog(@"TIMER IS RUNNING");
        
        initialTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
        NSDate *timerFireDate = [NSDate dateWithTimeInterval:fireTime sinceDate:[NSDate date]];
        [initialTimer setFireDate:timerFireDate];
        
         }
        else if (savedIsTimerRunning == false) {
        [self cancel];
        NSLog(@"TIMER IS NOT RUNNING");
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [initialTimer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    //1. SETS THE LABEL AND BUTTONS ENALBE/DISABLE
    [self set];
    
    //2. start the notifications
    [self notifications:3];
    
    countDownTimer.datePickerMode = UIDatePickerModeCountDownTimer;
    countDownTime = countDownTimer.countDownDuration;
    NSLog(@"The COUNTDOWN TIME IS %d MINUTES", countDownTime/60);
    [[NSUserDefaults standardUserDefaults] setInteger:countDownTime forKey:@"CountDownTime"];
    
    startDate = [NSDate date];
    NSLog(@"THe START DATE is %@", startDate);
    [[NSUserDefaults standardUserDefaults] setObject:startDate forKey:@"StartDate"];
    
    isTimerRunning = true;
    [[NSUserDefaults standardUserDefaults] setBool:isTimerRunning forKey:@"isTimerRunning"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //3. Set the time for the time page (if staying there completely)
    initialTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
    NSDate *timerFireDate = [NSDate dateWithTimeInterval:15*countDownTime+0.1 sinceDate:startDate];
    [initialTimer setFireDate:timerFireDate];
}

- (IBAction)stopButton:(id)sender {
    [self cancel];
    isTimerRunning = false;
    [[NSUserDefaults standardUserDefaults] setBool:isTimerRunning forKey:@"isTimerRunning"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [initialTimer invalidate];
}

- (void)set
{
    timerRunningLabel.text = @"RUNNING";
    timerRunningLabel.textColor = [UIColor greenColor];
    timerRunningLabel.backgroundColor = [UIColor clearColor];
    timerRunningLabel.textAlignment = 3;
    [self buttonStateWithStartState:NO cancelState:YES];
}

- (void)cancel
{
    timerRunningLabel.text = @"STOPPED/CANCELED";
    timerRunningLabel.textColor = [UIColor redColor];
    timerRunningLabel.textAlignment = 3;
    timerRunningLabel.backgroundColor = [UIColor clearColor];
    [self buttonStateWithStartState:YES cancelState:NO];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)timerMethod
{
    [self cancel];
    NSLog(@"TIMER EXPIRED");
    isTimerRunning = false;
    [[NSUserDefaults standardUserDefaults] setBool:isTimerRunning forKey:@"isTimerRunning"];
}

- (void)notifications:(int)time
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Alert Action text";
    localNotification.alertBody = @"Take a break";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    for (int i = 1; i < 15; i++) {
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:time*i];  //time*i
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
    UILocalNotification *cancelNotification1 = [[UILocalNotification alloc] init];
    cancelNotification1.alertAction = @"Alert";
    cancelNotification1.alertBody = @"Timer Canceled.  Please Reset";
    cancelNotification1.timeZone = [NSTimeZone defaultTimeZone];
    cancelNotification1.soundName = UILocalNotificationDefaultSoundName;
    cancelNotification1.fireDate = [NSDate dateWithTimeIntervalSinceNow:time*15];
    [[UIApplication sharedApplication] scheduleLocalNotification:cancelNotification1];
    
    [[UIApplication sharedApplication] scheduledLocalNotifications];
}

- (void)buttonStateWithStartState:(BOOL)startState cancelState:(BOOL)cancelState
{
    self.startButtonOutlet.enabled = startState;
    self.stopButtonOutlet.enabled = cancelState;
    self.startButtonOutlet.alpha = 0.5;
    self.stopButtonOutlet.alpha = 0.5;
    if (startState)
    {
        self.startButtonOutlet.alpha = 1.0;
    }
    if (cancelState)
    {
        self.stopButtonOutlet.alpha = 1.0;
    }
}
@end
