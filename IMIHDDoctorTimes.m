//
//  IMIHDDoctorTimes.m
//  iMediHubLIMS
//
//  Created by ihub on 12/29/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDDoctorTimes.h"

@implementation IMIHDDoctorTimes

-(void)allocate{
    self.drdates_arr = [[NSMutableArray alloc]init];
    self.drdatewisetimes_dict = [[NSMutableDictionary alloc]init];
}
-(IMIHDDoctorTimes*)getDoctorTimesResult:(NSDictionary*)responseresult{
    [self allocate];
//NSLog(@"doctor list times1");
    
    //NSLog(@"responseresult:%@",[responseresult objectForKey:@"dates"]);
   // for (NSDictionary*datesdict in responseresult) {
        //NSLog(@"doctor list times2");
    
        for (NSDictionary*dictlocal in [responseresult objectForKey:@"dates"]) {
            //NSLog(@"dictlocal:%@",dictlocal);
            
            [self.drdates_arr addObject:[dictlocal objectForKey:@"date"]];
                             [self.drdatewisetimes_dict setObject:[dictlocal objectForKey:@"ts"] forKey:[dictlocal objectForKey:@"date"]];
    
        }
                
       
            
                
    //NSLog(@"drdatewisetimes_dict:%@",self.drdatewisetimes_dict);
    
    return self;
}

-(IMIHDDoctorTimes*)getTimeSlotByDate:(NSDictionary*)timeslotdict{
    
    self.drtimeflag_arr=NULL;
    self.drtimes_arr=NULL;
    
    
    self.drtimeflag_arr = [[NSMutableArray alloc]init];
    self.drtimes_arr = [[NSMutableArray alloc]init];
        //NSLog(@"timeslotdict:%@",timeslotdict);
    for (NSDictionary *dictloc  in timeslotdict) {
        //NSLog(@"dictloc:%@",dictloc);
        //Dr Available slots
        
        NSString*time_str = [NSString stringWithFormat:@"%@",[dictloc objectForKey:@"timeSlot"]];
        if ([time_str isEqualToString:@""]||[time_str isEqualToString:@"(null)"]||time_str==nil||time_str==NULL||[time_str isEqualToString:@"<null>"])
        {
            //NSLog(@"time_str  doctoris :%@",time_str);
            time_str=@"";
        }else{
            
        }
        //NSLog(@"time_str doctor:%@",time_str);
            [self.drtimes_arr addObject:time_str];
        
            
        NSString*time_flag_str = [NSString stringWithFormat:@"%@",[dictloc objectForKey:@"flag"]];
        if ([time_flag_str isEqualToString:@""]||[time_flag_str isEqualToString:@"(null)"]||time_flag_str==nil||time_str==NULL||[time_flag_str isEqualToString:@"<null>"])
        {
            //NSLog(@"time_flag_str  doctoris :%@",time_flag_str);
            time_flag_str=@"";
        }else{
            
        }
        //NSLog(@"time_flag_str doctor:%@",time_flag_str);
            [self.drtimeflag_arr addObject:time_flag_str];

        
    }
    return self;
}
@end
