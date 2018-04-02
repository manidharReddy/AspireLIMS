//
//  IMIHLDoctorDates.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDoctorDates.h"

@implementation IMIHLDoctorDates
-(void)allocObjects{
    //self.doctid_srt = [[NSMutableArray alloc]init];
    self.doctavalbl_arr = [[NSMutableArray alloc]init];
}
-(IMIHLDoctorDates*)getDoctorDatesResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getDoctorDatesResult Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    //for (NSDictionary*doctrdict in responseresult) {
    NSDictionary*doctrdict =responseresult;
        //NSLog(@"doctrdict:%@",doctrdict);
        
        //location Id
        
    
        //Dept name
        NSString*doctid_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_id"]];
        if ([doctid_str isEqualToString:@""]||[doctid_str isEqualToString:@"(null)"]||doctid_str==nil||doctid_str==NULL||[doctid_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctid_str is :%@",doctid_str);
            doctid_str=@"";
        }else{
            
        }
        //NSLog(@"doctid_str:%@",doctid_str);
        // [self.testid_arr addObject:testid_str];
        self.doctid_srt=doctid_str;
       
        NSArray*arr_tmp = [doctrdict objectForKey:@"aDates"];
        if (arr_tmp!=nil) {
            [self addAvailableDates:arr_tmp];
        }else{
            //NSLog(@"Empty Dates");
        }
        
        
    
   // }
    //NSLog(@"self.doctid_arr:%@",self.doctid_srt);
    return self;
}

-(void)addAvailableDates:(NSArray*)arrdates{
    //NSLog(@"ArrayDtaes:%@",arrdates);
    NSDictionary*dictavailble = [arrdates objectAtIndex:0];
    /////////Start Date/////////////////////////////////
    NSString*strtdate_str = [NSString stringWithFormat:@"%@",[dictavailble objectForKey:@"startDate"]];
    if ([strtdate_str isEqualToString:@""]||[strtdate_str isEqualToString:@"(null)"]||strtdate_str==nil||strtdate_str==NULL||[strtdate_str isEqualToString:@"<null>"])
    {
        //NSLog(@"strtdate_str is :%@",strtdate_str);
        strtdate_str=@"";
    }else{
        
    }
    //NSLog(@"strtdate_str:%@",strtdate_str);
    // [self.testid_arr addObject:testid_str];
    
    self.startdate_str=strtdate_str;

    
    
    
    
    ////End Date////////////////////////////
    NSString*enddate_str = [NSString stringWithFormat:@"%@",[dictavailble objectForKey:@"endDate"]];
    if ([enddate_str isEqualToString:@""]||[enddate_str isEqualToString:@"(null)"]||enddate_str==nil||enddate_str==NULL||[enddate_str isEqualToString:@"<null>"])
    {
        //NSLog(@"enddate_str is :%@",enddate_str);
        enddate_str=@"";
    }else{
        
    }
    //NSLog(@"enddate_str:%@",enddate_str);
    // [self.testid_arr addObject:testid_str];
    
    self.enddate_str=enddate_str;

    
    NSArray*tmpdates = [dictavailble objectForKey:@"adates"];
    for (int i=0;i<tmpdates.count ; i++) {
        [self.doctavalbl_arr addObject:[tmpdates objectAtIndex:i]];
    }
}

@end
