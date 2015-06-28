//
//  ViewController.m
//  InfoLounge
//
//  Created by Runpeng Liu on 6/28/15.
//  Copyright (c) 2015 Runpeng Liu. All rights reserved.
//

#import "ViewController.h"

@interface TimerController : NSObject

// The repeating timer is a weak property.
@property (weak) NSTimer *repeatingTimer;
@property (strong) NSTimer *unregisteredTimer;
@property NSUInteger timerCount;

- (IBAction)startOneOffTimer:sender;

- (IBAction)startRepeatingTimer:sender;
- (IBAction)stopRepeatingTimer:sender;

- (IBAction)createUnregisteredTimer:sender;
- (IBAction)startUnregisteredTimer:sender;
- (IBAction)stopUnregisteredTimer:sender;

- (IBAction)startFireDateTimer:sender;

- (void)targetMethod:(NSTimer*)theTimer;
- (void)invocationMethod:(NSDate *)date;
- (void)countedTimerFireMethod:(NSTimer*)theTimer;

- (NSDictionary *)userInfo;

@end

@implementation TimerController
- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}

- (void)targetMethod:(NSTimer*)theTimer {
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
}

- (void)invocationMethod:(NSDate *)date {
    NSLog(@"Invocation for timer started on %@", date);
}

- (IBAction)startOneOffTimer:sender {
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:[self userInfo]
                                    repeats:NO];
}

- (IBAction)startRepeatingTimer:sender {
    
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(targetMethod:)
                                                    userInfo:[self userInfo] repeats:YES];
    self.repeatingTimer = timer;
}

- (IBAction)createUnregisteredTimer:sender {
    
    NSMethodSignature *methodSignature = [self methodSignatureForSelector:@selector(invocationMethod:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(invocationMethod:)];
    NSDate *startDate = [NSDate date];
    [invocation setArgument:&startDate atIndex:2];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 invocation:invocation repeats:YES];
    self.unregisteredTimer = timer;
}

- (IBAction)startUnregisteredTimer:sender {
    
    if (self.unregisteredTimer != nil) {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.unregisteredTimer forMode:NSDefaultRunLoopMode];
    }
}

- (IBAction)startFireDateTimer:sender {
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                              interval:0.5
                                                target:self
                                              selector:@selector(countedTimerFireMethod:)
                                              userInfo:[self userInfo]
                                               repeats:YES];
    
    self.timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)stopRepeatingTimer:sender {
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
}

- (IBAction)stopUnregisteredTimer:sender {
    [self.unregisteredTimer invalidate];
    self.unregisteredTimer = nil;
}

- (void)countedTimerFireMethod:(NSTimer*)theTimer {
    
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
  //  NSLog(@"Timer started on %@; fire count %d", startDate, self.timerCount);
   /***
    self.timerCount++;
    if (self.timerCount > 3) {
        [theTimer invalidate];
    }
    ***/
    
}

@end


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://runpengliu.com:3000"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
