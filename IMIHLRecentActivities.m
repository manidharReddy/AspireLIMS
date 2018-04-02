//
//  IMIHLRecentActivities.m
//  AspireLIMS
//
//  Created by ihub on 09/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLRecentActivities.h"
#import "IMIHLOrdersList.h"
#import "IMIHLAppointments.h"
#import "ALRecentActivity.h"
@interface IMIHLRecentActivities (){
    NSMutableArray*appointmentIndexs;
    NSMutableArray*remainderIndexs;
    NSMutableArray*reportIndexs;
}
@end
@implementation IMIHLRecentActivities
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allRecentActivitiesDict = [[NSMutableDictionary alloc]init];
        self.allRecentActivities = [[NSMutableArray alloc]init];
        appointmentIndexs = [[NSMutableArray alloc]init];
        remainderIndexs = [[NSMutableArray alloc]init];
        reportIndexs = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(IMIHLRecentActivities*)setRecentActivitiesList:(NSDictionary*)responseDictionary{
    
    
    for (NSDictionary*localdict in responseDictionary) {
       
        //NSLog(@"localdict:%@",localdict);
        ALRecentActivity *alr = [[ALRecentActivity alloc]init];
        //Appnt Id
        NSString*acctivityType = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"activityType"]];
        if ([acctivityType isEqualToString:@""]||[acctivityType isEqualToString:@"(null)"]||acctivityType==nil||acctivityType==NULL||[acctivityType isEqualToString:@"<null>"]||[acctivityType isEqual:[NSNull null]])
        {
            //NSLog(@"appntid_str is :%@",appntid_str);
            acctivityType=@"";
        }else{
            
        }
        
        NSLog(@"alr:%@",alr);
        alr.activityType = acctivityType;
        
        
        
        //Department ID
        NSString*id_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"id"]];
        if ([id_str isEqualToString:@""]||[id_str isEqualToString:@"(null)"]||id_str==nil||id_str==NULL||[id_str isEqualToString:@"<null>"]||[id_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptid_str is :%@",deptid_str);
            id_str=@"";
        }else{
            
        }
        NSLog(@"deptid_str:%@",id_str);
        // [self.testid_arr addObject:testid_str];
        alr.activityId = id_str;
        
        
        
        NSArray*arrtest = [localdict objectForKey:@"patientOrderServices"];
        if ([arrtest isEqual:[NSNull null]]) {
            
        }else{
       // if (arrtest.count!=0) {
            
            //alr.patientOrderServices = arrtest;
            
        //}
        }
        
        
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
        
        alr.appointmentTime = bookedtime_str;
        
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
        
        alr.appointmentDate = bookeddate_str;
        
        //Dept name
        NSString*status_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"appointmentStatus"]];
        if ([status_str isEqualToString:@""]||[status_str isEqualToString:@"(null)"]||status_str==nil||status_str==NULL||[status_str isEqualToString:@"<null>"]||[status_str isEqual:[NSNull null]])
        {
            //NSLog(@"status_str is :%@",status_str);
            status_str=@"";
        }else{
            
        }
        NSLog(@"status_str:%@",status_str);
        // [self.testid_arr addObject:testid_str];
        
        alr.appointmentStatus = status_str;
        
        //Dept name
        NSArray*arrpptServices = [localdict objectForKey:@"appointmentServices"];
        if ([arrtest isEqual:[NSNull null]]) {
            
        }else{
           // if (arrpptServices.count!=0) {
           // alr.appointmentServices = arrpptServices;
       // }
        }
        NSLog(@"arrpptServices:%@",arrpptServices);
        // [self.testid_arr addObject:testid_str];
        
       
        
        //Dept name
        NSString*latitute_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"latitute"]];
        if ([latitute_str isEqualToString:@""]||[latitute_str isEqualToString:@"(null)"]||latitute_str==nil||latitute_str==NULL||[latitute_str isEqualToString:@"<null>"]||[latitute_str isEqual:[NSNull null]])
        {
            //NSLog(@"status_str is :%@",status_str);
            latitute_str=@"";
        }else{
            
        }
        //NSLog(@"status_str:%@",status_str);
        // [self.testid_arr addObject:testid_str];
        
        alr.latitute = latitute_str;
        
        //Dept name
        NSString*longitude_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"longitude"]];
        if ([longitude_str isEqualToString:@""]||[longitude_str isEqualToString:@"(null)"]||longitude_str==nil||longitude_str==NULL||[longitude_str isEqualToString:@"<null>"]||[longitude_str isEqual:[NSNull null]])
        {
            //NSLog(@"status_str is :%@",status_str);
            longitude_str=@"";
        }else{
            
        }
        //NSLog(@"status_str:%@",status_str);
        // [self.testid_arr addObject:testid_str];
        
        alr.longitude = longitude_str;
        
        //Dept name
        NSString*name_str = [NSString stringWithFormat:@"%@",[localdict objectForKey:@"name"]];
        if ([name_str isEqualToString:@""]||[name_str isEqualToString:@"(null)"]||name_str==nil||name_str==NULL||[name_str isEqualToString:@"<null>"]||[name_str isEqual:[NSNull null]])
        {
            //NSLog(@"deptname_str is :%@",deptname_str);
            name_str=@"";
        }else{
            
        }
        //NSLog(@"deptname_str:%@",deptname_str);
        // [self.testid_arr addObject:testid_str];
        
        alr.name = name_str;
        NSLog(@"activityTpe:%@",acctivityType);
        NSLog(@"activityId alr:%@",alr.activityId);
        if ([acctivityType isEqualToString:@"Patient Appointments"]) {
            [appointmentIndexs addObject:alr];
        }else if ([acctivityType isEqualToString:@"Patient Orders"]){
            [reportIndexs addObject:alr];
        }else if ([acctivityType isEqualToString:@"Patient Appointment Reminders"]){
            [remainderIndexs addObject:alr];
        }
        [self.allRecentActivities addObject:alr];
        
    }
    
    [self.allRecentActivitiesDict setObject:appointmentIndexs forKey:@"Patient Appointments"];
    [self.allRecentActivitiesDict setObject:reportIndexs forKey:@"Patient Orders"];
    [self.allRecentActivitiesDict setObject:remainderIndexs forKey:@"Patient Appointment Reminders"];
    return self;
}

-(NSArray*)filterArrayUsingCustomProperty:(NSArray*)arrayList value:(NSString*)value{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",value];
    return [arrayList filteredArrayUsingPredicate:predicate];
    
}

@end
