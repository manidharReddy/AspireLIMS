//
//  IMIHLRemaindersList.m
//  AspireLIMS
//
//  Created by ihub on 21/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLRemaindersList.h"

@implementation IMIHLRemaindersList


- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.remainders forKey:@"remainder"];
   
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.remainders = [decoder decodeObjectForKey:@"remainder"];
    
    return self;
    
}
-(IMIHLRemaindersList*)getRemainders:(NSDictionary*)response{
    self.remainders = [[NSMutableArray alloc]init];
    for (NSDictionary*localdict in response) {
       
        ALRemainders*remiander = [[ALRemainders alloc]init];
        //Appnt Id
        NSString*appntid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"appointmentId"]];
        if ([appntid_str isEqualToString:@""]||[appntid_str isEqualToString:@"(null)"]||appntid_str==nil||appntid_str==NULL||[appntid_str isEqualToString:@"<null>"]||[appntid_str isEqual:[NSNull null]])
        {
            //NSLog(@"appntid_str is :%@",appntid_str);
            appntid_str=@"";
        }else{
            
        }
        remiander.apptmtId = appntid_str;
        //NSLog(@"appntid_str:%@",appntid_str);
        // [self.testid_arr addObject:testid_str];
        
       
        
        //Name
        NSString*name_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"name"]];
        if ([name_str isEqualToString:@""]||[name_str isEqualToString:@"(null)"]||name_str==nil||name_str==NULL||[name_str isEqualToString:@"<null>"]||[name_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptid_str is :%@",deptid_str);
            name_str=@"";
        }else{
            
        }
        //NSLog(@"deptid_str:%@",deptid_str);
        // [self.testid_arr addObject:testid_str];
        remiander.name = name_str;
       
        

        //NSLog(@"self.testname_arr:%@",self.testname_arr);
        //Date
        NSString*date_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"date"]];
        if ([date_str isEqualToString:@""]||[date_str isEqualToString:@"(null)"]||date_str==nil||date_str==NULL||[date_str isEqualToString:@"<null>"]||[date_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptname_str is :%@",deptname_str);
            date_str=@"";
        }else{
            
        }
        
        remiander.appointmentDate = date_str;
        //NSLog(@"deptname_str:%@",deptname_str);
        // [self.testid_arr addObject:testid_str];
        
       
        
        //Booked Time name
        NSString*bookedtime_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"appointmentTime"]];
        if ([bookedtime_str isEqualToString:@""]||[bookedtime_str isEqualToString:@"(null)"]||bookedtime_str==nil||bookedtime_str==NULL||[bookedtime_str isEqualToString:@"<null>"]||[bookedtime_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookedtime_str is :%@",bookedtime_str);
            bookedtime_str=@"";
        }else{
            
        }
        
        remiander.appointmentTime = bookedtime_str;
        //NSLog(@"bookedtime_str:%@",bookedtime_str);
        // [self.testid_arr addObject:testid_str];
        
        
        
        //Status
        NSString*status_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"status"]];
        if ([status_str isEqualToString:@""]||[status_str isEqualToString:@"(null)"]||status_str==nil||status_str==NULL||[status_str isEqualToString:@"<null>"]||[status_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookeddate_str is :%@",bookeddate_str);
            status_str=@"";
        }else{
            
        }
        
        remiander.status = status_str;
        
        
        //Latitude
        NSString*latitute_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"latitute"]];
        if ([latitute_str isEqualToString:@""]||[latitute_str isEqualToString:@"(null)"]||latitute_str==nil||latitute_str==NULL||[latitute_str isEqualToString:@"<null>"]||[latitute_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookeddate_str is :%@",bookeddate_str);
            latitute_str=@"";
        }else{
            
        }
        
        remiander.latitute = latitute_str;
        //longitude
        NSString*longitude_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"longitude"]];
        if ([longitude_str isEqualToString:@""]||[longitude_str isEqualToString:@"(null)"]||longitude_str==nil||longitude_str==NULL||[longitude_str isEqualToString:@"<null>"]||[longitude_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookeddate_str is :%@",bookeddate_str);
            longitude_str=@"";
        }else{
            
        }
        remiander.longitude = longitude_str;
        [self.remainders addObject:remiander];
        
    }
       
    return self;
}
@end
