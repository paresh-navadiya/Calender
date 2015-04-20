//
//  ViewController.m
//  Calender
//
//  Created by ECWIT on 15/04/15.
//  Copyright (c) 2015 ECWIT. All rights reserved.
//

#import "ViewController.h"

#import "NSDate+TKCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mutArrEvents = [NSMutableArray arrayWithObjects:
                  @[@"Meeting with CEO, MD and COO", @"Paresh Navadiya Paresh Navadiya", @2, @0, @2, @15],
                  @[@"Call with HCA Client, Call with HCA Client, Call with HCA Client", @"Paresh Navadiya", @7, @0, @7, @45],
                  @[@"Break for 1 hour", @"Paresh Navadiya", @15, @0, @16, @00],
                  @[@"Break for 1 hour and 30 minutes", @"Paresh Navadiya", @15, @0, @16, @30],
                  @[@"Reports for product managment", @"Paresh Navadiya", @5, @30, @6, @0],
                  @[@"QC Task needed to be done", @"Paresh Navadiya", @19, @30, @24, @0], nil];
    
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 20;
    frame.size.height -= 20;
    
    self.dayView.frame = frame;
    
    //paresh
    NSDateComponents *compNow = [NSDate componentsOfCurrentDate];
    [self performSelector:@selector(updateToCurrentTime) withObject:self afterDelay:60.0f-compNow.second];
}

-(void)updateToCurrentTime
{
    if (self.dayView) {
        [self.dayView.nowLineView updateTime];
    }
    [self performSelector:@selector(updateToCurrentTime) withObject:self afterDelay:60.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TKCalendarDayViewDelegate
- (NSArray *) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventsForDate:(NSDate *)eventDate{
    
    NSLog(@"eventDate : %@",eventDate);
    
    if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]] == NSOrderedAscending)
        return @[];
    
    if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:24*60*60]] == NSOrderedDescending)
        return @[];
    
    NSDateComponents *info = [[NSDate date] dateComponentsWithTimeZone:calendarDayTimeline.calendar.timeZone];
    info.second = 0;
    NSMutableArray *ret = [NSMutableArray array];
    
    for(NSArray *ar in mutArrEvents){
        
        TKCalendarDayEventView *event = [calendarDayTimeline dequeueReusableEventView];
        if(event == nil) event = [TKCalendarDayEventView eventView];
        
        NSInteger col = arc4random_uniform(3);
        [event setColorType:col];
        
        event.identifier = nil;
        event.titleLabel.text = ar[0];
        event.locationLabel.text = ar[1];
        
        info.hour = [ar[2] intValue];
        info.minute = [ar[3] intValue];
        event.startDate = [NSDate dateWithDateComponents:info];
        
        info.hour = [ar[4] intValue];
        info.minute = [ar[5] intValue];
        event.endDate = [NSDate dateWithDateComponents:info];
        
        [ret addObject:event];
        
    }
    return ret;
    
    
}
- (void) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventViewWasSelected:(TKCalendarDayEventView *)eventView{
    NSLog(@"%@",eventView.titleLabel.text);
}


@end
