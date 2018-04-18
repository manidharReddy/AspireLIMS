//
//  IMIHLRestService.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLRestService.h"
#import "AppDelegate.h"
/*
#define IMIHLRestPathNameTest @"http://144.76.40.143:8081/LIMS_Mobile/rest/get/"
#define IMIHLRestPathName @"http://144.76.40.143:8081/LIMS_Mobile/rest"
#define IMIHLDoctorRestPathName @"http://144.76.40.143:8081/DoctorRooster/rest/"
 */

//#define IMIHLRestPathNameTest @"http://183.82.109.67:8082/LIMS_Mobile/rest/get/"
//#define IMIHLRestPathName @"http://183.82.109.67:8082/LIMS_Mobile/rest"
//#define IMIHLDoctorRestPathName @"http://183.82.109.67:8082/DoctorRooster/rest/"

//#define IMIHLDoctorRestSpeciality @"http://144.76.40.143:8080/DoctorRooster/rest/get/"
/*
#define IMIHLRestPathNameTest @"http://192.168.1.100:8082/LIMS_Mobile_MM/rest/get/"
#define IMIHLRestPathName @"http://192.168.1.100:8082/LIMS_Mobile_MM/rest"
#define IMIHLDoctorRestPathName @"http://192.168.1.100:8082/DoctorRooster/rest/"
*/
#define IMIHLRestPathNameTest @"http://183.82.109.67:8080/Maven_LIMS/rest/get/"
#define IMIHLRestPathName @"http://183.82.109.67:8080/Maven_LIMS/rest"
//#define IMIHLRestPathNameTest @"https://aspirelims.com/LIMS_Mobile_MM/rest/get/"
//#define IMIHLRestPathName @"https://aspirelims.com/LIMS_Mobile_MM/rest"
#define IMIHLDoctorRestPathName @""

//#define IMIHLRestPathNameTest @"http://159.89.168.24:8080/Maven_LIMS_171/rest/get/"
//#define IMIHLRestPathName @"http://159.89.168.24:8080/Maven_LIMS_171/rest"


static IMIHLRestService *sharedRestInstance = nil;
@implementation IMIHLRestService



+(IMIHLRestService*)getSharedInstance{
    if (!sharedRestInstance) {
        sharedRestInstance = [[super allocWithZone:NULL]init];
        
    }
    return sharedRestInstance;
}


/*
 New Https Get Methods and Post Methods return type blocks
 */
//Login Service
-(void)newLoginWithUserIdPasswordByBlock:(NSString*)username :(NSString*)password withCompletionHandler:(void (^)(NSInteger))handler{
    NSString*postdata = [NSString stringWithFormat:@"{\"userId\":\"%@\",\"password\":\"%@\"}",username,password];
    ;
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/loginpage/login",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}

//Recent Activities
-(void)recentActivities:(NSString*)patientId withCompletionHandler:(void (^)(NSInteger))handler{
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/recentactivities/gethistory?patientid=%@",IMIHLRestPathName,patientId] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}
/*Remainders*/
-(void)remainders:(NSString*)patientId withCompletionHandler:(void (^)(NSInteger))handler{
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/reminders?patientid=%@",IMIHLRestPathName,patientId] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}

/*Patient Report Service*/
-(void)reports:(NSString*)registeredID :(NSString*)fromdate :(NSString*)todate withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"reports service");
    
    NSString*postdata = [NSString stringWithFormat:@"{\"patientId\":\"%@\",\"toDate\":\"%@\",\"fromDate\":\"%@\"}",registeredID,todate,fromdate];
    //NSLog(@"postdata:%@",postdata);
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/patientservicelistNew/getdatewasedetails",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}


/*Patient Info Service*/
-(void)getpatientInfo:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"patientinfo service");
    //NSLog(@"patientid:%@",patientid);
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/update/getdetails?patientid=%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    //NSLog(@"statuscode1:%d",statuscode);
    
}

/*Feedback Service*/
-(void)feedbackService:(NSString*)patientid :(NSString*)feedbacktype :(NSString*)feedbackcontent withCompletionHandler:(void (^)(NSInteger))handler{
    NSString*postdata = [NSString stringWithFormat:@"{\"patientId\":\"%@\",\"feedback_type\":\"%@\",\"feedback_content\":\"%@\"}",patientid,feedbacktype,feedbackcontent];
    //NSLog(@"postdata:%@",postdata);
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/feedback/details",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}


/*Change Password Service*/
-(void)changepasswordService:(NSString*)patientid :(NSString*)currentPass :(NSString*)changePass :(NSString*)reenterPass withCompletionHandler:(void (^)(NSInteger))handler{
    NSString*postdata = [NSString stringWithFormat:@"{\"patientId\":\"%@\",\"currentPass\":\"%@\",\"changePass\":\"%@\",\"reenterPass\":\"%@\"}",patientid,currentPass,changePass,reenterPass];
    //NSLog(@"postdata:%@",postdata);
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/password/change",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}
/*Forgot Password Service*/
-(void)forgotPasswordService:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Forgotpassword service");
    
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/forgotpassword/%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
    
}

/*Confirm Forgot Password Using OTP Service*/
-(void)confrimForgotPasswordService:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"confirmForgotpassword OTP service");
    
  
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/forgotpassword/reset/%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}



/*AboutUs  Service*/
-(void)getAboutUsService:(NSString*)aboutid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"AboutUs service");
    
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/aboutus/getdetails?id=%@",IMIHLRestPathName,aboutid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}




/*Appointment Creation Service*/
-(void)createAppointment:(NSString*)patientId :(NSString*)appointmentDate :(NSString*)locationid :(NSString*)departmentId :(NSString*)serviceId withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"create appointment service");
    
    //NSString*postdata = [NSString stringWithFormat:@"{\"patientId\":\"%@\",\"appointmentDate\":\"%@\",\"locid\":\"%@\",\"departmentId\":\"%@\",\"serviceId\":\"%@\"}",patientId,appointmentDate,locationid,departmentId,serviceId];
    NSString*postdata = [NSString stringWithFormat:@"{\"patientId\":\"%@\",\"appointmentDate\":\"%@\",\"locid\":\"%@\",\"servicesLst\":%@}",patientId,appointmentDate,locationid,serviceId];
    
    //NSLog(@"postdata:%@",postdata);
    
    
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/create",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
    
}

/*Cancel appointments*/
-(void)cancelAppointment:(NSString*)appntId :(NSString*)reason withCompletionHandler:(void (^)(NSInteger))handler{
    NSString*postdata = [NSString stringWithFormat:@"{\"appointmentId\":\"%@\",\"reason\":\"%@\"}",appntId,reason];
    
    //NSLog(@"postdata cancel appoints:%@",postdata);
    
    
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/cancel",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}
/*Reschedule appointments*/
-(void)reSchedule:(NSString *)appntId :(NSString *)reason withCompletionHandler:(void (^)(NSInteger))handler{
    NSString*postdata = [NSString stringWithFormat:@"{\"appointmentId\":\"%@\",\"reason\":\"%@\"}",appntId,reason];
    
    //NSLog(@"postdata cancel appoints:%@",postdata);
    
    
    
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/reschedule",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
    
}
/*Get Deparments  Service*/
-(void)getDepartments:(NSString*)locationid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Departments service");
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/getDepartments/%@",IMIHLRestPathName,locationid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}

/*Get Services  Service*/
-(void)getServices:(NSString*)departid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Services service");
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/getservices/%@",IMIHLRestPathName,departid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}

/*Get All Appointments  Service*/
-(void)getAllAppointments:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get All Appointments service");
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/getAllAppointments/%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}


-(void)getLocations:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Locations service");
    
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/appointments/getLocations/%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}

/*getSearchServices  Service*/
-(void)getSearchServices:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get All Appointments service");
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/patient/gettestrecords?patientid=%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}

-(void)getPatientOrdersList:(NSString *)patientid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Orders List service");
    
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@/get/patientorders?patientid=%@",IMIHLRestPathName,patientid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
    
}

/*getSearchResults  Service*/
-(void)getSearchResults:(NSString*)patientid :(NSString*)testid withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Search Results service");
    
    NSString*postdata = [NSString stringWithFormat:@"{\"patientid\":\"%@\",\"serviceId\":\"%@\"}",patientid,testid];
    //NSLog(@"postdata:%@",postdata);
    
    
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/patientservicelistNew/getrecordbytestname",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
   
}
/*getForgotPasswordChangePassword  Service*/
-(void)getForgotResetPassword:(NSString*)patientid :(NSString*)userid :(NSString*)password withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get Forgotpassword service");
    
    NSString*postdata = [NSString stringWithFormat:@"{\"userId\":\"%@\",\"patientId\":\"%@\",\"password\":\"%@\"}",userid,patientid,password];
    //NSLog(@"postdata:%@",postdata);
    
    
    
    [self httpPostCallTypeBlock:[NSString stringWithFormat:@"%@/forgotpassword/changePassword",IMIHLRestPathName] parameters:postdata withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
 
}

//getTestNameService
-(void)getTestName:(NSString*)testname :(NSString*)locid
 withCompletionHandler:(void (^)(NSInteger))handler{
    //NSLog(@"Get TestNameService");
    [self httpGetCallTypeBlock:[NSString stringWithFormat:@"%@servicename?testname=%@&locid=%@",IMIHLRestPathNameTest,testname,locid] parameters:@"" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}


-(void)reportDownloadPdf:(NSString*)orderid_str :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler{
    [self downloadTask:[NSString stringWithFormat:@"%@/get/testreportsave?orderid=%@",IMIHLRestPathName,orderid_str] orderId:orderid_str orderType:@"report" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}
-(void)invoiceDownloadPdf:(NSString *)orderid_str :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler{
    [self downloadTask:[NSString stringWithFormat:@"%@/get/getinvoice?orderid=%@",IMIHLRestPathName,orderid_str] orderId:orderid_str orderType:@"invoice" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}

-(void)reportDownloadInPDF:(NSString*)orderid_str :(NSString*)serviceId :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler{
    [self downloadTask:[NSString stringWithFormat:@"%@getlabreport?patientServiceid=%@",IMIHLRestPathNameTest,serviceId] orderId:[orderid_str stringByAppendingString:serviceId] orderType:@"report" withCompletionHandler:^(NSInteger response) {
        handler(response);
    }];
}

/////////////////////////////////End with New Service Blocks//////////////////////////




/*Profile Update and Upload ProfileImage*/

    
-(void)profileUpdateService:(NSString*)patientid :(NSString*)firstname :(NSString*)lastname :(NSString*)gender :(NSString*)dob :(NSString*)emailid  :(NSString*)mobilenumber :(NSData*)filedata :(void (^)(NSInteger))handler{
   //[self uploadData:[NSString stringWithFormat:@"%@/update/updatedetails",IMIHLRestPathName] :patientid :firstname :lastname :gender :dob :emailid :filedata];

    [self uploadData:[NSString stringWithFormat:@"%@/update/updatedetails",IMIHLRestPathName] :patientid :firstname :lastname :gender :dob :emailid :mobilenumber :filedata :^(NSInteger response) {
        handler(response);
    }];

}


/*
/////////////////////////////////////////Doctors//////////////////////////////////////////////
-(int)getDoctorLocations:(NSString*)patientid{
    //NSLog(@"Get Locations service");
    statuscode = [self sendHTTPGet:[NSString stringWithFormat:@"%@get/locations",IMIHLDoctorRestPathName] :@"drlocations"];
    return statuscode;
}
-(int)getDoctorDepartments:(NSString*)locationid{
    //NSLog(@"Get Departments service");
    statuscode = [self sendHTTPGet:[NSString stringWithFormat:@"%@subdept?locid=%@",IMIHLDoctorRestPathName,locationid] :@"drdepartments"];
    return statuscode;

}

-(int)getDoctorsList:(NSString*)loc_id :(NSString*)departid{
    //NSLog(@"Get Doctors service");
    
    NSString*postdata = [NSString stringWithFormat:@"{\"loc_Id\":\"%@\",\"dept_Id\":\"%@\"}",loc_id,departid];
    //NSLog(@"postdata:%@",postdata);
    
    statuscode = [self httpPostWithCustomDelegate:[NSString stringWithFormat:@"%@doctorprofile/get",IMIHLDoctorRestPathName] :postdata :@"doctorslist"];
    return statuscode;


}

-(int)getDoctorsDates:(NSString*)doctid{
    //NSLog(@"Get Doctors service");
    statuscode = [self sendHTTPGet:[NSString stringWithFormat:@"%@doctorAvailabilityDatesList?did=%@",IMIHLDoctorRestPathName,doctid] :@"dravialabledates"];
    return statuscode;

}

-(int)getDoctorsTimes:(NSString*)doctid{
    
    //NSLog(@"Get Doctors times service");
    statuscode = [self sendHTTPGet:[NSString stringWithFormat:@"%@get/doctorAvailabilityslots?did=%@",IMIHLDoctorRestPathName,doctid] :@"drtimes"];
    return statuscode;

    
}

-(int)getDoctorSpecialities:(NSString*)locationid{
    //NSLog(@"Get Specialities service");
    statuscode = [self sendHTTPGet:[NSString stringWithFormat:@"%@SpecialityDescription/get?locid=%@",IMIHLDoctorRestPathName,locationid] :@"drspectialities"];
    return statuscode;
    
}
-(int)createDoctorAppointment:(NSString*)appointmentDate appointmentTime:(NSString*)appointmentTime doctorId:(NSString*)doctorId patientId:(NSString*)patientId{
    
    NSString*postdata = [NSString stringWithFormat:@"{\"doct_appnt_date\":\"%@\",\"doct_appnt_time\":\"%@\",\"doctor_id\":\"%@\",\"patient_id\":\"%@\"}",appointmentDate,appointmentTime,doctorId,patientId];
    
    //NSLog(@"postdata:%@",postdata);
    
    statuscode = [self httpPostWithCustomDelegate:[NSString stringWithFormat:@"%@appointments/save",IMIHLDoctorRestPathName] :postdata :@"createappointment"];
    return statuscode;
}

/////////////////////////////////////////END/////////////////////////////////////////////////
*/

///forgotpassword/changePassword






# pragma POST UPLOAD

/*
 Post Upload Service with Basic  Authorization
 */


-(void)uploadData:(NSString*)urlpath :(NSString*)patientid :(NSString*)firstname :(NSString*)lastname :(NSString*)gender :(NSString*)dob :(NSString*)emailid  :(NSString*)mobilenumber :(NSData*)filedata :(void (^)(NSInteger))handler{
   
    @try {
        
        
        
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

    NSLog(@"urlpath uploadData:%@",urlpath);
  
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *now = [[NSDate alloc] init];
    NSString *imageName = [NSString stringWithFormat:@"Image_%@", [format stringFromDate:now]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];


        [request setURL:[NSURL URLWithString:urlpath]];
    
        [request setHTTPMethod:@"POST"];
    
   
    
    /*
     Set Header and content type of your request.
     */
       NSString *boundary= @"--------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    /*
     now lets create the body of the request.
     */
    NSMutableData *body = [NSMutableData data];
    
    
        
           
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"patientid"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", patientid] dataUsingEncoding:NSUTF8StringEncoding]];
   
            //NSLog(@"patientid:%@",patientid);
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"firstname"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", firstname] dataUsingEncoding:NSUTF8StringEncoding]];
      
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"lastname"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", lastname] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"dob"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", dob] dataUsingEncoding:NSUTF8StringEncoding]];

            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"gender"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", gender] dataUsingEncoding:NSUTF8StringEncoding]];

            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"emailid"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", emailid] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"mobilenumber"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", mobilenumber] dataUsingEncoding:NSUTF8StringEncoding]];
            
        
        
        

    if (filedata) {
       
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", imageName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:filedata];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // set body with request.
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%d", (int)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    ////NSLog(@"body data:%@",body);
    
    
    
    
        NSURLSessionUploadTask*uploadTask = [defaultSession uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                
                NSLog(@"StatusCode:%ld",httpResp.statusCode);
                if (httpResp.statusCode == 200) {
                    NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                    
                    
                }else{
                    NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                }
                handler(httpResp.statusCode);
            }
        }];
        [uploadTask resume];
      /*
    NSData*responcedata = [NSURLConnection sendSynchronousRequest:request returningResponse:&url_responce error:&error];
    NSHTTPURLResponse*httpresponse = (NSHTTPURLResponse*)url_responce;
    //NSLog(@"httpresponse code:%d",(int)[httpresponse statusCode]);
    statuscode = (int)[httpresponse statusCode];
    NSLog(@"statuscode service:%d",statuscode);
    self.restresult_dict = [self jsonResult:responcedata];
    //NSLog(@"restresult_dict:%@",self.restresult_dict);
    return statuscode;
       */
    }
    @catch (NSException *exception) {
        //NSLog(@"Exception Handle::%@",exception);
    }
    @finally {
        
        //NSLog(@"Finally Block");
    }
}


-(void)downloadTask:(NSString*)url_str orderId:(NSString*)orderId orderType:(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
   
    
    InternetConnection*ic = [InternetConnection getSharedInstance];
    if (ic.CheckNetwork==YES) {
        
        NSFileManager*filemanagerObj = [NSFileManager defaultManager];
        NSString*docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        
        NSString*filepath = nil ;
        if ([type isEqualToString:@"invoice"]) {
            filepath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.pdf",type,orderId]];
            
        }else{
            filepath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.pdf",type,orderId]];
            
        }
        NSLog(@"urlstr:%@",url_str);
        NSURL * url = [NSURL URLWithString:url_str];
        
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"GET"];
        
        /*
         NSString *authStr = [NSString stringWithFormat:@"%@:%@",@"rest",@"rest"];
         NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
         NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64Encoding]];
         
         [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
         [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
         */
        
        
        
        if ([filemanagerObj fileExistsAtPath:filepath]) {
            NSLog(@"File already Exist");
             handler(200);
        }else{
           // NSURL*urlFile = [NSURL URLWithString:filepath];
            NSURLSessionDownloadTask*downloadTask = [defaultSession downloadTaskWithRequest:urlRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSError *err = nil;
                 NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (error==nil) {
                    if (httpResp.statusCode == 200) {
                        
                        NSLog(@"LOcation File:%@",location);
                    if ([filemanagerObj createFileAtPath:filepath contents:[NSData dataWithContentsOfURL:location] attributes:nil])
                    {
                        NSLog(@"File is saved to =%@",docsDir);
                        //handler(httpResp.statusCode);
                        
                    }
                    else
                    {
                        NSLog(@"failed to move: %@",[err userInfo]);
                    }
                    }else if(httpResp.statusCode >=201 && httpResp.statusCode<=299){
                        
                    }else if(httpResp.statusCode >=300 && httpResp.statusCode<=399){
                        
                    }else if(httpResp.statusCode >=400 && httpResp.statusCode<=500){
                        
                    }
                }
                handler(httpResp.statusCode);
            }];
                    
            [downloadTask resume];
            
        }
        
    }else{
        handler(0);
        //NSLog(@"No NetworkConnection");
        
    }
    
}

#pragma JSON Serialization

/*Response will convert into JSON Formate*/

-(NSDictionary*)jsonResult:(NSData*)result{
    NSDictionary*dictjsonresult ;
    NSError*error;
     dictjsonresult = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:&error];
    return dictjsonresult;
}
-(void)saveJsonWithData:(NSData *)data :(NSString*)keystr{
    //NSLog(@"savejsonfile");
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@.json",keystr];
    //NSLog(@"savefile1");
    [data writeToFile:jsonPath atomically:YES];
    
}

-(NSData *)getSavedJsonData:(NSString*)keystr{
    //NSLog(@"getjsonfile");
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@.json",keystr];
    
    return [NSData dataWithContentsOfFile:jsonPath];
}


//Sample get request with blocks return type

-(void)httpGetCallTypeBlock:(NSString*)urlString parameters:(NSString*)parameter withCompletionHandler:(void (^)(NSInteger))handler{
    InternetConnection*ic = [InternetConnection getSharedInstance];
    if (ic.CheckNetwork==YES) {
    @try {
    NSURL *url = [NSURL URLWithString:urlString];
    
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
   // [request addValue: myEmail forHTTPHeaderField:@"user-email"];
    //[request addValue: mySessionToken forHTTPHeaderField:@"user-token"];
    
    //NSError *error = nil;
    
    
   
        
        NSURLSessionDataTask *downloadTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"response:%@",response);
            NSLog(@"error:%@",error);
            if (error == nil) {
                
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                
                NSLog(@"StatusCode:%ld",httpResp.statusCode);
                if (httpResp.statusCode == 200) {
                    NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                    
                    
                }else{
                    NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                }
                handler(httpResp.statusCode);
            }
            
            
            
        }];
        
        
        [downloadTask resume];
        
    
} @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
} @finally {
    NSLog(@"final block");
}
}else{
    handler(0);
}
}


-(void)httpPostCallTypeBlock:(NSString*)urlString parameters:(NSString*)parameter withCompletionHandler:(void (^)(NSInteger))handler{
    InternetConnection*ic = [InternetConnection getSharedInstance];
    if (ic.CheckNetwork==YES) {
    @try {
        
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"UrlString:%@",urlString);
    NSLog(@"parameters:%@",parameter);
   // NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
   // NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString * params =parameter;
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // [request addValue: myEmail forHTTPHeaderField:@"user-email"];
    //[request addValue: mySessionToken forHTTPHeaderField:@"user-token"];
    
    
   // NSError *error = nil;
    
    
    //if (!error) {
        
        NSURLSessionDataTask *downloadTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"response:%@",response);
            NSLog(@"error:%@",error);
            if (error == nil) {
                
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                
                NSLog(@"StatusCode:%ld",httpResp.statusCode);
                if (httpResp.statusCode == 200) {
                    NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                    
                    
                }else{
                     NSLog(@"StatusCode:%ld",httpResp.statusCode);
                    self.restresult_dict = [self jsonResult:data];
                    
                }
            handler(httpResp.statusCode);
            }
            
            
            
        }];
        
        
        [downloadTask resume];
        
    //}
    } @catch (NSException *exception) {
        NSLog(@"Exception:%@",exception);
    } @finally {
        NSLog(@"final block");
    }
    }else{
        handler(0);
    }
}



@end
