//
//  IMIHDDrPreviousAppts.m
//  iMediHubLIMS
//
//  Created by ihub on 06/06/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDDrPreviousAppts.h"
#import "IMIHLDBManager.h"
@implementation IMIHDDrPreviousAppts
-(void)allocObjects{
    self.doctname_arr = [[NSMutableArray alloc]init];
    self.dept_id_arr = [[NSMutableArray alloc]init];
    self.test_id_arr = [[NSMutableArray alloc]init];
    self.testname_arr = [[NSMutableArray alloc]init];
    self.deptname_arr = [[NSMutableArray alloc]init];
    self.bookedtime_arr = [[NSMutableArray alloc]init];
    self.bookeddate_arr = [[NSMutableArray alloc]init];
    self.status_arr = [[NSMutableArray alloc]init];
    
    
}

-(IMIHDDrPreviousAppts*)getAppointmentsList:(NSDictionary*)responseresult{
    
    [self allocObjects];
    //IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    //NSLog(@"getDepartment Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    for (NSDictionary*localdict in responseresult) {
        
        //NSLog(@"localdict:%@",localdict);
        /*
        //Appnt Id
        NSString*appntid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"doctorName"]];
        if ([appntid_str isEqualToString:@""]||[appntid_str isEqualToString:@"(null)"]||appntid_str==nil||appntid_str==NULL||[appntid_str isEqualToString:@"<null>"]||[appntid_str isEqual:[NSNull null]])
        {
            //NSLog(@"appntid_str is :%@",appntid_str);
            appntid_str=@"";
        }else{
            
        }
        //NSLog(@"appntid_str:%@",appntid_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.apointmentId_arr addObject:appntid_str];
        
      
        //Department ID
        NSString*deptid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"dept_id"]];
        if ([deptid_str isEqualToString:@""]||[deptid_str isEqualToString:@"(null)"]||deptid_str==nil||deptid_str==NULL||[deptid_str isEqualToString:@"<null>"]||[deptid_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptid_str is :%@",deptid_str);
            deptid_str=@"";
        }else{
            
        }
        //NSLog(@"deptid_str:%@",deptid_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.dept_id_arr addObject:deptid_str];
        
        //Test Id
        NSString*testid_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"test_id"]];
        if ([testid_str isEqualToString:@""]||[testid_str isEqualToString:@"(null)"]||testid_str==nil||testid_str==NULL||[testid_str isEqualToString:@"<null>"]||[testid_str isEqual:[NSNull null]])
        {
            //NSLog(@"testid_str is :%@",testid_str);
            testid_str=@"";
        }else{
            
        }
        //NSLog(@"testid_str:%@",testid_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.test_id_arr addObject:testid_str];
        
        //Test  name
        NSString*testname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"testname"]];
        if ([testname_str isEqualToString:@""]||[testname_str isEqualToString:@"(null)"]||testname_str==nil||testname_str==NULL||[testname_str isEqualToString:@"<null>"]||[testname_str isEqual:[NSNull null]])
        {
            //NSLog(@"testname_str is :%@",testname_str);
            testname_str=@"";
        }else{
            
        }
        //NSLog(@"testname_str:%@",testname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.testname_arr addObject:testname_str];
        
        //Dept name
        NSString*deptname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"deptname"]];
        if ([deptname_str isEqualToString:@""]||[deptname_str isEqualToString:@"(null)"]||deptname_str==nil||deptname_str==NULL||[deptname_str isEqualToString:@"<null>"]||[deptname_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptname_str is :%@",deptname_str);
            deptname_str=@"";
        }else{
            
        }
        //NSLog(@"deptname_str:%@",deptname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.deptname_arr addObject:deptname_str];
        */
        //Appnt Id
        NSString*doctname_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"doctorName"]];
        if ([doctname_str isEqualToString:@""]||[doctname_str isEqualToString:@"(null)"]||doctname_str==nil||doctname_str==NULL||[doctname_str isEqualToString:@"<null>"]||[doctname_str isEqual:[NSNull null]])
        {
            //NSLog(@"doctname_str is :%@",doctname_str);
            doctname_str=@"";
        }else{
            
        }
        //NSLog(@"doctname_str:%@",doctname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctname_arr addObject:doctname_str];

        
        
        //Booked Time name
        NSString*bookedtime_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"appointmentTime"]];
        if ([bookedtime_str isEqualToString:@""]||[bookedtime_str isEqualToString:@"(null)"]||bookedtime_str==nil||bookedtime_str==NULL||[bookedtime_str isEqualToString:@"<null>"]||[bookedtime_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookedtime_str is :%@",bookedtime_str);
            bookedtime_str=@"";
        }else{
            
        }
        //NSLog(@"bookedtime_str:%@",bookedtime_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.bookedtime_arr addObject:bookedtime_str];
        
        //Booked Date name
        NSString*bookeddate_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"date"]];
        if ([bookeddate_str isEqualToString:@""]||[bookeddate_str isEqualToString:@"(null)"]||bookeddate_str==nil||bookeddate_str==NULL||[bookeddate_str isEqualToString:@"<null>"]||[bookeddate_str isEqual:[NSNull null]])
        {
            //NSLog(@"bookeddate_str is :%@",bookeddate_str);
            bookeddate_str=@"";
        }else{
            
        }
        //NSLog(@"bookeddate_str:%@",bookeddate_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.bookeddate_arr addObject:bookeddate_str];
        
        //Dept name
        NSString*status_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"status"]];
        if ([status_str isEqualToString:@""]||[status_str isEqualToString:@"(null)"]||status_str==nil||status_str==NULL||[status_str isEqualToString:@"<null>"]||[status_str isEqual:[NSNull null]])
        {
            //NSLog(@"status_str is :%@",status_str);
            status_str=@"";
        }else{
            
        }
        //NSLog(@"status_str:%@",status_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.status_arr addObject:status_str];
        
        //[dbmanager savePatientAppoinments:appntid_str :testname_str :bookeddate_str :deptname_str :status_str];
        
    }
    ////NSLog(@"self.deptid_arr:%@",self.deptid_arr);
    return self;
}

@end
