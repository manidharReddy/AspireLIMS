//
//  IMIHLDoctorList.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 19/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDoctorList.h"

@implementation IMIHLDoctorList
-(void)allocObjects{
    self.doctid_arr = [[NSMutableArray alloc]init];
    self.doctname_arr = [[NSMutableArray alloc]init];
    self.doctfee_arr = [[NSMutableArray alloc]init];
    self.doctexp_arr = [[NSMutableArray alloc]init];
    self.doctprofileimg_arr = [[NSMutableArray alloc]init];
    self.doctstds_arr = [[NSMutableArray alloc]init];
    self.doctspecialty_arr = [[NSMutableArray alloc]init];
}
-(IMIHLDoctorList*)getDoctorListResult:(NSDictionary*)responseresult{
    [self allocObjects];
    //NSLog(@"getDoctorList Service calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    for (NSDictionary*doctrdict in responseresult) {
        
        //NSLog(@"doctrdict:%@",doctrdict);
        
        //doctor Id
        NSString*id_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_Id"]];
        if ([id_str isEqualToString:@""]||[id_str isEqualToString:@"(null)"]||id_str==nil||id_str==NULL||[id_str isEqualToString:@"<null>"])
        {
            //NSLog(@"id_str is :%@",id_str);
            id_str=@"";
        }else{
            
        }
        //NSLog(@"id_str:%@",id_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctid_arr addObject:id_str];
        
        //Doctor name
        NSString*doctrname_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_Name"]];
        if ([doctrname_str isEqualToString:@""]||[doctrname_str isEqualToString:@"(null)"]||doctrname_str==nil||doctrname_str==NULL||[doctrname_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctrname_str is :%@",doctrname_str);
            doctrname_str=@"";
        }else{
            
        }
        
        //NSLog(@"doctrname_str:%@",doctrname_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctname_arr addObject:doctrname_str];
        
        
        //Doctor Fee
        NSString*doctrfee_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_Fee"]];
        if ([doctrfee_str isEqualToString:@""]||[doctrfee_str isEqualToString:@"(null)"]||doctrfee_str==nil||doctrfee_str==NULL||[doctrfee_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctrfee_str is :%@",doctrfee_str);
            doctrfee_str=@"Not";
        }else{
            
        }
        
        //NSLog(@"doctrfee_str:%@",doctrfee_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctfee_arr addObject:doctrfee_str];
        
        
        
        
        //Doctor Experience
        NSString*doctrexp_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_Experience"]];
        if ([doctrexp_str isEqualToString:@""]||[doctrexp_str isEqualToString:@"(null)"]||doctrexp_str==nil||doctrexp_str==NULL||[doctrexp_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctrexp_str is :%@",doctrexp_str);
            doctrexp_str=@"";
        }else{
            
        }
        
        //NSLog(@"doctrexp_str:%@",doctrexp_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctexp_arr addObject:doctrexp_str];
        
        //DoctorProfile Image
        NSString*profilepic_str = [doctrdict objectForKey:@"doctor_Profile_Img"];
        //NSLog(@"checklll2");
        
        // NSString * profileImageString = [userInfo objectForKey:@"profile_image_url"];
        //NSData * profilepic_data = [profilepic_str dataUsingEncoding:NSUTF8StringEncoding];
        //  NSData * profilepic_data = [profilepic_data base64Encoding];
        // NSData*profile = [profilepic_data base64Encoding];
        // NSData*profilepic_data = [responseresult objectForKey:@"image"];
        
       // NSData *profilepic_data ;
        
        //NSLog(@"checklll");
        if ([profilepic_str isEqual:[NSNull null]])
        {
           // //NSLog(@"profilepic_data is :%@",profilepic_data);
            profilepic_str = @"";
           // profilepic_data= ;
            
        }else{
           //profilepic_data = [[NSData alloc] initWithBase64EncodedString:profilepic_str options:0];
        }
       // //NSLog(@"profilepic_data:%@",profilepic_data);
        [self.doctprofileimg_arr addObject:profilepic_str];
        //[self setProfileimage:profilepic_data];
        
        
        
        //Doctor Studies
        NSString*doctr_stds_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_studies"]];
        if ([doctr_stds_str isEqualToString:@""]||[doctr_stds_str isEqualToString:@"(null)"]||doctr_stds_str==nil||doctr_stds_str==NULL||[doctr_stds_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctr_stds_str is :%@",doctr_stds_str);
            doctr_stds_str=@"";
        }else{
            
        }
        
        //NSLog(@"doctr_stds_str:%@",doctr_stds_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctstds_arr addObject:doctr_stds_str];
        
        //Doctor Studies
        NSArray*spect_arr = [doctrdict objectForKey:@"doctor_Speciality"];
        //NSLog(@"spect_arr:%@",spect_arr);
        if (spect_arr.count!=0) {
           
            
            
            //NSLog(@"if..........1");
            NSMutableString*str_appd = [[NSMutableString alloc]init];
            for (int i=0; i<spect_arr.count; i++) {
                //NSLog(@"spect_arr heloooo:%@",[spect_arr objectAtIndex:i]);
               // [str_appd stringByAppendingString:[NSString stringWithFormat:@"%@",[spect_arr objectAtIndex:i]]];
                [str_appd appendFormat:@" %@",[spect_arr objectAtIndex:i]];
                //NSLog(@"str_appd:%@",str_appd);
            }
            
            //NSLog(@"else..........2");
            [self.doctspecialty_arr addObject:str_appd];
        }else{
             //NSLog(@" else count:");
[self.doctspecialty_arr addObject:@""];
        }
        
        /*
        NSString*doctr_specialities_str = [NSString stringWithFormat:@"%@",[doctrdict objectForKey:@"doctor_Speciality"]];
        if ([doctr_specialities_str isEqualToString:@""]||[doctr_specialities_str isEqualToString:@"(null)"]||doctr_specialities_str==nil||doctr_specialities_str==NULL||[doctr_specialities_str isEqualToString:@"<null>"])
        {
            //NSLog(@"doctr_specialities_str is :%@",doctr_specialities_str);
            doctr_specialities_str=@"";
        }else{
            
        }
        
        //NSLog(@"doctr_specialities_str:%@",doctr_specialities_str);
        // [self.testid_arr addObject:testid_str];
        
        [self.doctspecialty_arr addObject:doctr_specialities_str];
         */
        //NSLog(@"doctorspeciality:%@",self.doctspecialty_arr);
        
        
    }
    //NSLog(@"self.doctid_arr:%@",self.doctid_arr);
    return self;
}


@end
