//
//  IMIHLDoctorTimings.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 03/11/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDoctorTimings.h"

@implementation IMIHLDoctorTimings
-(void)allocObjects{
    
    self.doctslottimes_arr = [[NSMutableArray alloc]init];
}
-(IMIHLDoctorTimings*)getDoctorTimesResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getDoctortimes Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    //for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"responseresult:%@",responseresult);
        
        //Timings Slots
    
    NSArray*slotsarr = [responseresult objectForKey:@"slotTimes"];
    
    for (int time=0; time<slotsarr.count; time++) {
        
    
    
        NSString*slottime_str = [NSString stringWithFormat:@"%@",[slotsarr objectAtIndex:time]];
        if ([slottime_str isEqualToString:@""]||[slottime_str isEqualToString:@"(null)"]||slottime_str==nil||slottime_str==NULL||[slottime_str isEqualToString:@"<null>"])
        {
            //NSLog(@"slottime_str is :%@",slottime_str);
            slottime_str=@"not available";
        }else{
            
        }
        //NSLog(@"slottime_str:%@",slottime_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctslottimes_arr addObject:slottime_str];
        
    }
    
    //}
    //NSLog(@"self.doctslottimes_arr:%@",self.doctslottimes_arr);
    return self;
}

@end
