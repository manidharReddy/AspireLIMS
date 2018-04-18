//
//  IMIHLLogin.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 22/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLLogin.h"

@implementation IMIHLLogin

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.patientid forKey:@"patientid"];
    [encoder encodeObject:self.firstname forKey:@"firstname"];
    [encoder encodeObject:self.lastname forKey:@"lastname"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.dob forKey:@"dob"];
    [encoder encodeObject:self.emailid forKey:@"emailid"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:self.bloodgroup forKey:@"bloodgroup"];
    [encoder encodeObject:self.profileimage forKey:@"profileimage"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
   
    self.patientid = [decoder decodeObjectForKey:@"patientid"];
    self.firstname = [decoder decodeObjectForKey:@"firstname"];
    self.lastname = [decoder decodeObjectForKey:@"lastname"];
    self.gender = [decoder decodeObjectForKey:@"gender"];
    self.dob = [decoder decodeObjectForKey:@"dob"];
    self.emailid = [decoder decodeObjectForKey:@"emailid"];
    self.mobile = [decoder decodeObjectForKey:@"mobile"];
    self.bloodgroup = [decoder decodeObjectForKey:@"bloodgroup"];
    self.profileimage = [decoder decodeObjectForKey:@"profileimage"];
    
    
    return self;
    
    
}


-(IMIHLLogin*)getLoginResult:(NSDictionary*)responseresult{
    
    //NSLog(@"getLoginResult calledddddd");
    //NSLog(@"responseresult:%@",responseresult);
    //for (NSDictionary*localdict in responseresult) {
        
        NSLog(@"localdict:%@",responseresult);
    NSLog(@"patientid :%@",[responseresult objectForKey:@"patientId"]);
    //Patient Id
    NSString*patientid_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"patientId"]];
    NSLog(@"patientid_str is :%@",patientid_str);
    if ([patientid_str isEqualToString:@""]||[patientid_str isEqualToString:@"(null)"]||patientid_str==nil||patientid_str==NULL||[patientid_str isEqualToString:@""]||[patientid_str isEqualToString:@"<null>"]||patientid_str==nil||patientid_str==NULL)
    {
        //NSLog(@"patientid_str is :%@",patientid_str);
        patientid_str=@"";
    }else{
        
    }
    //NSLog(@"patientid_str:%@",patientid_str);
    // [self.testid_arr addObject:testid_str];
    NSLog(@"check1");
    self.patientid = patientid_str;
NSLog(@"check2");
    
    //FirstName
    NSString*firstname_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"firstName"]];
    if ([firstname_str isEqualToString:@""]||[firstname_str isEqualToString:@"(null)"]||firstname_str==nil||firstname_str==NULL||[firstname_str isEqualToString:@""]||[firstname_str isEqualToString:@"<null>"]||firstname_str==nil||firstname_str==NULL)
    {
        //NSLog(@"firstname_str is :%@",firstname_str);
        firstname_str=@"";
    }else{
    
    }
    //NSLog(@"firstname_str:%@",firstname_str);
   [self setFirstname:firstname_str];


    //Lastname
     NSString*lastname_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"lastName"]];
     if ([lastname_str isEqualToString:@""]||[lastname_str isEqualToString:@"(null)"]||lastname_str==nil||lastname_str==NULL||[lastname_str isEqualToString:@""]||[lastname_str isEqualToString:@"<null>"]||lastname_str==nil||lastname_str==NULL)
     {
    //NSLog(@"lastname_str is :%@",lastname_str);
    lastname_str=@"";
    }else{
    
    }
    //NSLog(@"lastname_str:%@",lastname_str);


   [self setLastname:lastname_str];

   //Gender
   NSString*gender_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"gender"]];
   if ([gender_str isEqualToString:@""]||[gender_str isEqualToString:@"(null)"]||gender_str==nil||patientid_str==NULL||[gender_str isEqualToString:@""]||[gender_str isEqualToString:@"<null>"]||gender_str==nil||gender_str==NULL)
    {
    //NSLog(@"gender_str is :%@",gender_str);
    gender_str=@"";
    }else{
    
     }
    //NSLog(@"gender_str:%@",gender_str);

    [self setGender:gender_str];

    
    //DOB
    NSString*dob_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"dateOfBirth"]];
   if ([dob_str isEqualToString:@""]||[dob_str isEqualToString:@"(null)"]||dob_str==nil||dob_str==NULL||[dob_str isEqualToString:@""]||[dob_str isEqualToString:@"<null>"]||dob_str==nil||dob_str==NULL)
   {
    //NSLog(@"dob_str is :%@",dob_str);
    dob_str=@"";
   }else{
    
   }
   //NSLog(@"patiendob_strtid_str:%@",dob_str);
  [self setDob:dob_str];
    
    
  //Email Id
  NSString*emailid_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"mailId"]];
  if ([emailid_str isEqualToString:@""]||[emailid_str isEqualToString:@"(null)"]||emailid_str==nil||emailid_str==NULL||[emailid_str isEqualToString:@""]||[emailid_str isEqualToString:@"<null>"]||emailid_str==nil||emailid_str==NULL)
  {
    //NSLog(@"emailid_str is :%@",emailid_str);
    emailid_str=@"Email Not Avialable";
  }else{
    
  }
  //NSLog(@"emailid_str:%@",emailid_str);
  [self setEmailid:emailid_str];

 //Mobile No
 NSString*mobile_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"mobileNo"]];
 if ([mobile_str isEqualToString:@""]||[mobile_str isEqualToString:@"(null)"]||mobile_str==nil||mobile_str==NULL||[mobile_str isEqualToString:@""]||[mobile_str isEqualToString:@"<null>"]||mobile_str==nil||mobile_str==NULL)
 {
    //NSLog(@"mobile_str is :%@",mobile_str);
    mobile_str=@"";
 }else{
    
 }
 //NSLog(@"mobile_str:%@",mobile_str);

 [self setMobile:mobile_str];


 //Blood Group
 NSString*bloodgroup_str = [NSString stringWithFormat:@"%@",[responseresult objectForKey:@"booldGroup"]];
  // NSString*bloodgroup_str = @"A+";
 if ([bloodgroup_str isEqualToString:@""]||[bloodgroup_str isEqualToString:@"(null)"]||bloodgroup_str==nil||bloodgroup_str==NULL||[bloodgroup_str isEqualToString:@""]||[bloodgroup_str isEqualToString:@"<null>"]||bloodgroup_str==nil||bloodgroup_str==NULL)
 {
    //NSLog(@"bloodgroup_str is :%@",bloodgroup_str);
    bloodgroup_str=@"";
 }else{
    
 }
 //NSLog(@"bloodgroup_str:%@",bloodgroup_str);

 [self setBloodgroup:bloodgroup_str];
        
        
        
        
        
        //Profile Image Group
        //NSLog(@"checklll3");
    NSString*profilepic_str = [responseresult objectForKey:@"image"];
        //NSLog(@"checklll2");
    
   // NSString * profileImageString = [userInfo objectForKey:@"profile_image_url"];
    //NSData * profilepic_data = [profilepic_str dataUsingEncoding:NSUTF8StringEncoding];
  //  NSData * profilepic_data = [profilepic_data base64Encoding];
   // NSData*profile = [profilepic_data base64Encoding];
       // NSData*profilepic_data = [responseresult objectForKey:@"image"];
    
    
    NSData *profilepic_data;
    
    //NSLog(@"checklll");
        if ([profilepic_str isEqual:[NSNull null]])
        {
            //NSLog(@"profilepic_data is :%@",profilepic_data);
            profilepic_str = @"";
            
            profilepic_data= nil;
            
        }else{
    profilepic_data = [[NSData alloc] initWithBase64EncodedString:profilepic_str options:0];
        }
        //NSLog(@"profilepic_data:%@",profilepic_data);
        
        [self setProfileimage:profilepic_data];

// }

    return self;
}
@end
