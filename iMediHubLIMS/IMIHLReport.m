//
//  IMIHLReport.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 19/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLReport.h"
#import "MyReportsVC.h"
#import "IMIHLReportValue.h"
#import "IMIHLDBManager.h"
#import "IMDIHLReport.h"
@interface IMIHLReport ()
@property(nonatomic,retain) NSMutableArray*patienttestdept_arr;
@property(nonatomic,retain) NSMutableArray*patienttestid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestrange_arr;
@property(nonatomic,retain) NSMutableArray*patienttestdate_arr;
@property(nonatomic,retain) NSMutableArray*patienttesttime_arr;
@property(nonatomic,retain)NSMutableArray*patientteststatus_arr;
@property(nonatomic,retain)NSMutableArray*patienttestunits_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisrepeated_arr;
@property(nonatomic,retain)NSMutableArray*patienttestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttesttype_arr;
@property(nonatomic,retain)NSMutableArray*patientgrouptestname_arr;
@property(nonatomic,retain)NSMutableArray*patientpaneltestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestminvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestmaxvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisready;
@property(nonatomic,retain)NSMutableArray*paneltests_arr;
@property(nonatomic,retain)NSMutableArray*panelgrps_arr;


@end

@implementation IMIHLReport

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self currentMonthWithDate];
    
        [self allocateArray];
   // self.labrprt_tblview.delegate=self;
    //self.labrprt_tblview.dataSource=self;
    self.navigation_name_str =@"0";
    //[self testData];
    [self setIcons];
    //self.calledchg_str=@"0";
   // self.navigationController
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";

    if (self.tempreportdict==nil) {
       // self.calledchg_str=@"1";
        
    //[self performSelector:@selector(callReportMain) withObject:nil afterDelay:0.1];
        //[self performSelectorInBackground:@selector(callReportMain) withObject:nil];
        [self callReportMain];
    }else{
        //self.id_str=@"1";
        //NSLog(@"viewdidload else:%@",self.id_str);
        //NSLog(@"self.tempreportdict main:%@",self.tempreportdict);
        self.dateshow_lbl.text = self.datestore_str;
    IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
        reportvalue= [reportvalue getReportResult:self.tempreportdict];
        [self testResults:reportvalue];
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden = NO;
    self.backBaritem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backBaritem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backBaritem];
}

- (void)goBack
{self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callReportMain{

    if ([self.id_str isEqualToString:@"1"]) {
        
        //self.id_str=@"0";
        //[self restServiceCall:self.patientid_str:self.fromdate_str  :self.todate_str];
        [self reports:self.patientid_str :self.fromdate_str :self.todate_str];
        
    }else{
       // self.id_str=@"0";
        [self currentMonthWithDate];
    }

}

-(void)allocateArray{
    self.patienttestid_arr = [[NSMutableArray alloc]init];
    self.patienttesttype_arr = [[NSMutableArray alloc]init];
    self.patienttestname_arr = [[NSMutableArray alloc]init];
    self.patienttestrange_arr = [[NSMutableArray alloc]init];
    self.patienttestdate_arr = [[NSMutableArray alloc]init];
    self.patienttesttime_arr = [[NSMutableArray alloc]init];
    self.patienttestvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestunits_arr = [[NSMutableArray alloc]init];
    self.patienttestminvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestmaxvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestisready = [[NSMutableArray alloc]init];
    self.patientgrouptestname_arr = [[NSMutableArray alloc]init];
    self.paneltests_arr = [[NSMutableArray alloc]init];
    self.panelgrps_arr = [[NSMutableArray alloc]init];
    self.patienttestdept_arr = [[NSMutableArray alloc]init];
    self.patienttestisrepeated_arr =[[NSMutableArray alloc]init];
}



-(void)restServiceCall:(NSString*)patientid :(NSString*)todate :(NSString*)fromdate{
    //NSLog(@"restServiceCall calleddddddd");
    
    //self.dateshow_lbl.text = [NSString stringWithFormat:@"%@%@to%@%@",todate,@" ",@" ",fromdate];
    self.dateshow_lbl.text = self.datestore_str;
    IMIHLRestService*restreport = [IMIHLRestService getSharedInstance];
    //@"MR16000070"
    //[restreport reports:patientid :todate :fromdate];
    
    IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
    //IMIHLReportValue
    int statuscode =[restreport reports:patientid :todate :fromdate];
    if (statuscode==200) {
        //NSLog(@"before try");
        
        
        self.tempreportdict = restreport.restresult_dict;
         reportvalue= [reportvalue getReportResult:restreport.restresult_dict];
         [self testResults:reportvalue];
        /*
        @try {
            [[NSUserDefaults standardUserDefaults] setObject:restreport.restresult_dict forKey:@"reportsdata"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } @catch (NSException *exception) {
            //NSLog(@"exception localstore:%@",exception);
        } @finally {
            //NSLog(@"finalyyyy");
        }
        */
       
        
        /*
        //NSLog(@"patientid rest login:%@",[restreport.restresult_dict objectForKey:@"patientId"]);
        NSString*patientid_str = [restlogin.restresult_dict objectForKey:@"patientId"];
        //NSLog(@"patientid login:%@",patientid_str);
        [restlogin getpatientInfo:patientid_str];
        
        IMIHLLogin*login = [[IMIHLLogin alloc]init];
        //NSLog(@"loinhdfdggdh");
        //NSLog(@"restloginresultdcn:%@",restlogin.restresult_dict);
        IMIHLLogin*loginresult = [login getLoginResult:restlogin.restresult_dict];
        //NSLog(@"loginresult:%@",loginresult);
        */
        
        //[reportvalue getReportResult:restreport.restresult_dict];
    
                /*
         
         
        IMIHLDBManager *dbmanager = [IMIHLDBManager getSharedInstance];
        
        BOOL isSuccess = [dbmanager savePatientTests: :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#> :<#(NSString *)#>];
        
        //NSLog(@"isSuccess:%d",isSuccess);
        if (isSuccess==YES) {
            //NSLog(@"PatientInfo insert in db sucess");
            [self loadViewControllerFromStoryBoard:@"dashboardvc"];
        }else{
            //NSLog(@"PatientInfo insert in db failed");
        }
        */
        
    }else if(statuscode==0){
      // //NSLog(@"reports  localldict:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"reportsdata"]);
        //restreport.restresult_dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"reportsdata"];
        //reportvalue= [reportvalue getReportResult:restreport.restresult_dict];
        
        //[self testResults:reportvalue];
        
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restreport.restresult_dict objectForKey:@"msg"]);
        [self showAlertController:@"No Records Found"];
    }
    
    //NSLog(@"endddd");
    
        //[self.labrprt_tblview reloadData];
    
    //NSLog(@"patientrange:%@",self.patienttestrange_arr);
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.labrprt_tblview reloadData];
    });
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)reports:(NSString*)patientid :(NSString*)todate :(NSString*)fromdate{
    
    self.dateshow_lbl.text = self.datestore_str;
    IMIHLRestService*restreport = [IMIHLRestService getSharedInstance];
    
   
    
   
   
  
    
    [restreport reports:patientid :todate :fromdate withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            
             IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
            self.tempreportdict = restreport.restresult_dict;
            NSLog(@"restreport.restresult_dict:%@",restreport.restresult_dict);
            reportvalue= [reportvalue getReportResult:restreport.restresult_dict];
            [self testResults:reportvalue];
            
            NSData *recentacitivitiesdata = [NSKeyedArchiver archivedDataWithRootObject:reportvalue];
            
            [[NSUserDefaults standardUserDefaults] setObject:recentacitivitiesdata forKey:@"testedreports"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.labrprt_tblview reloadData];
            
        }else if(response==0){
            
            [self showAlertController:@"No Network Connection"];
            NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [userdefaults objectForKey:@"testedreports"];
             IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
            reportvalue = (IMIHLReportValue*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self testResults:reportvalue];
        }else if(response==500){
            
            [self showAlertController:@"There is no services on this dates.please try with another dates"];
        }
        else{
            //NSLog(@"Error Message:%@",[]);
            
            [self showAlertController:[restreport.restresult_dict objectForKey:@"msg"]];
        }
    }];
   
    
    //NSLog(@"endddd");
    
    //[self.labrprt_tblview reloadData];
    
    //NSLog(@"patientrange:%@",self.patienttestrange_arr);
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.labrprt_tblview reloadData];
    });
     */
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)testResults:(IMIHLReportValue*)reportvalue{
    
    
    //NSLog(@"reportvalue check:%@",self.tempreportdict);
    
    //NSLog(@"datestore_str:%@",self.datestore_str);
    if ([self.id_str isEqualToString:@"0"] ||[self.calledchg_str isEqualToString:@"1"]) {
        //NSLog(@"id_str str:%@",self.id_str);
        if ([self.id_str isEqualToString:@"1"]) {
            self.calledchg_str=@"1";
        }else if ([self.id_str isEqualToString:@"0"] && self.datestore_str != (id)[NSNull null]){
            //NSLog(@"entreddddddddddddd");
        self.calledchg_str=@"1";
        }else{
        self.calledchg_str=@"0";
        }
       // self.calledchg_str=@"0";
    //    IMIHLDBManager *dbmanager = [IMIHLDBManager getSharedInstance];
        
        //BOOL isSuccess;
        for (int i=0; i<reportvalue.testname_arr.count; i++) {
            //NSLog(@"check1");
            
            [self.patienttestdept_arr addObject:[reportvalue.departmentname_arr objectAtIndex:i]];
            [self.patienttesttype_arr addObject:[reportvalue.type_arr objectAtIndex:i]];
            [self.patienttestname_arr addObject:[reportvalue.testname_arr objectAtIndex:i]];
            [self.patienttestisrepeated_arr addObject:[reportvalue.isrepeated_arr objectAtIndex:i]];
            //NSLog(@"is Type:%@",[reportvalue.type_arr objectAtIndex:i]);
            //NSLog(@"isEntered Value:%@",[reportvalue.isentered_arr objectAtIndex:i]);
            //NSLog(@"check2");
            if ([[reportvalue.type_arr objectAtIndex:i] isEqualToString:@"1"]) {
                //NSLog(@"check3");
                //NSLog(@"self.patienttestisready:%@",self.patienttestisready);
                //NSLog(@"i value:%d",i);
                //NSLog(@"self.patienttestisready count:%d",(int)self.patienttestisready.count);
                //NSLog(@"isentred:%@",reportvalue.isentered_arr);
                [self.patienttestisready addObject:[reportvalue.isentered_arr objectAtIndex:i]];
                if ([[reportvalue.isentered_arr objectAtIndex:i] isEqualToString:@"1"]) {
                    //NSLog(@"check4");
                    // isSuccess = [dbmanager savePatientTests:[reportvalue.testid_arr objectAtIndex:i] :[reportvalue.testname_arr objectAtIndex:i] :[reportvalue.type_arr objectAtIndex:i] :[reportvalue.testdate_arr objectAtIndex:i] :[reportvalue.departmentid_arr objectAtIndex:i] :[reportvalue.testunits_arr objectAtIndex:i] :[reportvalue.departmentname_arr objectAtIndex:i] :[reportvalue.testminvalue_arr objectAtIndex:i] :[reportvalue.testmaxvalue_arr objectAtIndex:i] :[reportvalue.testresultvalue_arr objectAtIndex:i] :[reportvalue.testcriticallowvalue_arr objectAtIndex:i] :[reportvalue.testcriticalhighvalue_arr objectAtIndex:i] :(int)[reportvalue.isentered_arr objectAtIndex:i]];
                    //NSLog(@"reportvalue.testresultvalue_arr:%@",reportvalue.testresultvalue_arr);
                    if ([[reportvalue.testresultvalue_arr objectAtIndex:i] isEqualToString:@"Positive"]||[[reportvalue.testresultvalue_arr objectAtIndex:i] isEqualToString:@"Negative"]) {
                        [self.patienttestrange_arr addObject:@""];
                        
                    }else{
                        
                        //NSLog(@"TestMaxValue:%@",[reportvalue.testmaxvalue_arr objectAtIndex:i]);
                        //NSLog(@"TestMaxValue:%@",[reportvalue.testmaxvalue_arr objectAtIndex:i]);
                        NSString*strrange = [NSString stringWithFormat:@"%@><%@",[reportvalue.testminvalue_arr objectAtIndex:i],[reportvalue.testmaxvalue_arr objectAtIndex:i]];
                        [self.patienttestrange_arr addObject:strrange];
                    }
                    //NSLog(@"check5");
                }else{
                    // isSuccess = [dbmanager savePatientTests:[reportvalue.testid_arr objectAtIndex:i] :[reportvalue.testname_arr objectAtIndex:i] :[reportvalue.type_arr objectAtIndex:i] :[reportvalue.testdate_arr objectAtIndex:i] :[reportvalue.departmentid_arr objectAtIndex:i] :@"" :[reportvalue.departmentname_arr objectAtIndex:i] :@"" :@"" :@"" :@"" :@"" :(int)[reportvalue.isentered_arr objectAtIndex:i]];
                    [self.patienttestrange_arr addObject:@""];
                }
                //NSLog(@"check6");
                [self.patienttestid_arr addObject:[reportvalue.testid_arr objectAtIndex:i]];
                [self.patienttestminvalue_arr addObject:[reportvalue.testminvalue_arr objectAtIndex:i]];
                [self.patienttestmaxvalue_arr addObject:[reportvalue.testmaxvalue_arr objectAtIndex:i]];
                [self.patienttestvalue_arr addObject:[reportvalue.testresultvalue_arr objectAtIndex:i]];
                
                //[self.patienttestname_arr addObject:[reportvalue.testname_arr objectAtIndex:i]];
                //NSLog(@"testdate:%@",[reportvalue.testdate_arr objectAtIndex:i]);
                NSString * strdate = [reportvalue.testdate_arr objectAtIndex:i];
                //NSLog(@"strdate:%@",strdate);
                
                NSArray * arr = [strdate componentsSeparatedByString:@" "];
                //NSLog(@"Array values are : %@",arr);
                //NSLog(@"date count:%ul",arr.count);
                if (arr.count>1) {
                    NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
                    //NSLog(@"[arr objectAtIndex:0]:%@",[arr objectAtIndex:0]);
                    [self.patienttestdate_arr addObject:[arr objectAtIndex:0]];
                    [self.patienttesttime_arr addObject:strtime];
                }else{
                    [self.patienttestdate_arr addObject:@""];
                    [self.patienttesttime_arr addObject:@""];
                
                }
                
                [self.patienttestunits_arr addObject:[reportvalue.testunits_arr objectAtIndex:i]];
                [self.patientgrouptestname_arr addObject:@""];
                [self.paneltests_arr addObject:@""];
                [self.panelgrps_arr addObject:@""];
                
                
            }else if ([[reportvalue.type_arr objectAtIndex:i] isEqualToString:@"2"]){
                // isSuccess = [dbmanager savePatientTests:@"grp2" :[reportvalue.testname_arr objectAtIndex:i] :[reportvalue.type_arr objectAtIndex:i] :@"" :@"" :@"" :@"" :@"" :@"" :@"" :@"" :@"" :(int)[reportvalue.isentered_arr objectAtIndex:i]];
                
                //NSLog(@"check7");
                [self.patienttestrange_arr addObject:@""];
                [self.patienttestminvalue_arr addObject:@""];
                [self.patienttestmaxvalue_arr addObject:@""];
                [self.patienttestvalue_arr addObject:@""];
                [self.patienttestdate_arr addObject:[reportvalue.testdatesplit_arr objectAtIndex:i]];
                [self.patienttesttime_arr addObject:[reportvalue.testtimesplit_arr objectAtIndex:i]];
                [self.patienttestunits_arr addObject:@""];
               // [self.patienttestisready addObject:@"0"];
                [self.patienttestisready addObject:[reportvalue.isentered_arr objectAtIndex:i]];
                [self.patientgrouptestname_arr addObject:[reportvalue.groupttestobj_arr objectAtIndex:i]];
                [self.paneltests_arr addObject:@""];
                [self.panelgrps_arr addObject:@""];
                
                
            }else if([[reportvalue.type_arr objectAtIndex:i] isEqualToString:@"3"]){
                //isSuccess = [dbmanager savePatientTests:@"panel3" :[reportvalue.testname_arr objectAtIndex:i] :[reportvalue.type_arr objectAtIndex:i] :@"" :@"" :@"" :@"" :@"" :@"" :@"" :@"" :@"" :(int)[reportvalue.isentered_arr objectAtIndex:i]];
                //NSLog(@"check8");
                [self.patienttestrange_arr addObject:@""];
                [self.patienttestminvalue_arr addObject:@""];
                [self.patienttestmaxvalue_arr addObject:@""];
                [self.patienttestvalue_arr addObject:@""];
                [self.patienttestdate_arr addObject:@""];
                [self.patienttesttime_arr addObject:@""];
                [self.patienttestunits_arr addObject:@""];
                [self.patienttestisready addObject:@"0"];
                [self.patientgrouptestname_arr addObject:@""];
                
                [self.paneltests_arr addObject:[reportvalue.paneltestobj_arr objectAtIndex:i]];
                [self.panelgrps_arr addObject:[reportvalue.panelgroupobj_arr objectAtIndex:i]];
            }
            //NSLog(@"isSuccess:%d",isSuccess);
            /*
             if (isSuccess==YES) {
             //NSLog(@"Patient Tests insert in db sucess");
             // [self loadViewControllerFromStoryBoard:@"dashboardvc"];
             }else{
             //NSLog(@"Patient Tests insert in db failed");
             }
             */
        }
        
        /*
         //NSLog(@"isSuccess:%d",isSuccess);
         if (isSuccess==YES) {
         //NSLog(@"PatientInfo insert in db sucess");
         [self loadViewControllerFromStoryBoard:@"dashboardvc"];
         }else{
         //NSLog(@"PatientInfo insert in db failed");
         }
         */
    }
    
[MBProgressHUD hideHUDForView:self.view animated:YES];

}


-(void)currentMonthWithDate{
    // Get todays date to set the monthly subscription expiration date
    NSDate *currentDate = [NSDate date];
    //NSLog(@"Current Date = %@", currentDate);
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = -10;
    
    NSDate *currentDatePlus1Month = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    //NSLog(@"Date = %@", currentDatePlus1Month);
    
    
    
    NSString*currentdate_str = [NSString stringWithFormat:@"%@",currentDate];
    NSString*currentDatePlus1Monthdate_str = [NSString stringWithFormat:@"%@",currentDatePlus1Month];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //formatter.dateFormat = @"dd-MM-yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    currentDatePlus1Monthdate_str = [formatter stringFromDate:currentDatePlus1Month];
    currentdate_str = [formatter stringFromDate:currentDate];
    
    formatter.dateFormat =@"dd-MM-yyyy";
    self.datestore_str = [NSString stringWithFormat:@"%@%@to%@%@",[formatter stringFromDate:currentDatePlus1Month],@" ",@" ",[formatter stringFromDate:currentDate]];
    
    
   //[self restServiceCall:self.patientid_str :currentDatePlus1Monthdate_str :currentdate_str];
    [self reports:self.patientid_str :currentDatePlus1Monthdate_str :currentdate_str];
    
   // [self restServiceCall:@"MR16000001" :currentDatePlus1Monthdate_str :currentdate_str];
    // [self restServiceCall:@"MR16000001" :@"2016-07-29" :@"2016-07-18"];
    
    //[self restServiceCall:@"MR16000025" :@"2016-08-5" :@"2016-08-4"];
    
    
}
-(void)setIcons{
    //[self.backBaritem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];

    [self.changebtn setImage:[UIImage imageWithIcon:@"fa-exchange" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:12] forState:UIControlStateNormal];
    
    //[self.dropdown_btn setBackgroundImage:[UIImage imageWithIcon:@"fa-ellipsis-v" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
}

-(void)testData{
    
    
    
    
    /*
    self.patienttestid_arr = [NSArray arrayWithObjects:@"TestID1", @"TestID2", @"TestID3", @"TestID4",@"TestID5",@"TestID6",@"TestID7",@"TestID8",@"TestID9",@"TestID1",nil];
    self.patienttestname_arr = [NSArray arrayWithObjects:@"TestA", @"TestB", @"TestC", @"TestD",@"GroupA",@"PanelA",@"TestE",@"TestF",@"TestG",@"TestH",nil];
    self.patienttesttype_arr = [NSArray arrayWithObjects:@"1", @"1", @"1", @"1",@"2",@"3",@"1",@"1",@"1",@"1",nil];
    self.patienttestrange_arr = [NSArray arrayWithObjects:@">15<40", @">15<40", @">15<40", @">15<40",@">15<40",@">15<40",@">15<40",@">15<40",@">15<40",@">15<40",nil];
    self.patienttestdate_arr = [NSArray arrayWithObjects:@"24th Jan 2016", @"29th Jan 2016", @"2th Feb 2016", @"12th Feb 2016",@"5th Mar 2016",@"15th Mar 2016",@"10th Apr 2016",@"16th May 2016",@"25th May 2016",@"20th Jun 2016",nil];
   self.patienttesttime_arr = [NSArray arrayWithObjects:@"10.30pm", @"10.30pm", @"10.30pm", @"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",@"10.30pm",nil];
    self.patientteststatus_arr = [NSArray arrayWithObjects:@"High", @"Normal", @"Normal", @"Normal",@"Normal",@"Normal",@"High",@"Normal",@"Low",@"Normal",nil];
    self.patienttestvalue_arr = [NSArray arrayWithObjects:@"41.2", @"18.2", @"32.2", @"16.2",@"15.2",@"22.2",@"36.2",@"34.2",@"10.2",@"21.2",nil];
    self.patienttestunits_arr = [NSArray arrayWithObjects:@"mmol/L", @"mmol/L", @"mmol/L", @"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",@"mmol/L",nil];
    self.patientgrouptestname_arr = [NSArray arrayWithObjects:@"TestA", @"TestB", @"TestC", @"TestD",@"TestX",@"TestY",@"TestE",@"TestF",@"TestG",@"TestH",nil];
    [self.labrprt_tblview reloadData];
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//////////////////////////////TableView Delegate Methods/////////////////////

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.patienttesttype_arr.count;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count patient names:%d",(int)self.patienttestname_arr.count);
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.view.frame.size.width<self.view.frame.size.height) {
        return (self.labrprt_tblview.bounds.size.height)*0.2;
    }
    return (self.labrprt_tblview.bounds.size.height)*0.4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    //NSLog(@"cell for row at index");
    static NSString *CellIdentifier = @"testlisttblcell";
    
    UITableViewCell *cell = [self.labrprt_tblview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
        //NSLog(@"cell if");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    
    cell.layer.cornerRadius = 10.0f;
    //self.labrprt_tblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //NSLog(@"cell checkkkk:%@",cell);
    
    //NSLog(@"cellcheck1");
    //NSLog(@"indexPath:%lu",(long)indexPath.row);
    //NSLog(@"Patient test Name:%@",[self.patienttestname_arr objectAtIndex:indexPath.row]);
    //NSLog(@"types:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    //NSLog(@"is ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
    //NSLog(@"Ready Array:%@",self.patienttestisready);
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==1) {
    //NSLog(@"cellcheck2");
    UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        
       // grphbtn.hidden=NO;
        if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==1) {
           
            //NSLog(@"isrepeated value:%d",[[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]);
            //if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==1) {
            
            
            
            grphbtn.hidden=NO;
            //  grphbtn.hidden=YES;
                
            [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
                
               // [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
                
                 
            [grphbtn setTag:indexPath.row];
           [grphbtn addTarget:self action:@selector(graphBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
              /*
            }else if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==0){
               // grphbtn.hidden=YES;
                //grphbtn=nil;
                
                //grphbtn.hidden=YES;
                
                [grphbtn setImage:nil forState:UIControlStateNormal];
            [grphbtn setHidden:YES];
            }
            */
            
            //NSLog(@"cellcheck3");
    UILabel*lbl;
    UILabel*lbl_range;
    //NSLog(@"cellcheck4");
    lbl_range=(UILabel*)[cell viewWithTag:1];
    lbl_range.text = [self.patienttestvalue_arr objectAtIndex:indexPath.section];
            lbl_range.hidden=NO;
            //NSLog(@"cellcheck5");
    lbl=(UILabel*)[cell viewWithTag:2];
    lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck6");
    lbl=(UILabel*)[cell viewWithTag:3];
    lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck7");
    lbl=(UILabel*)[cell viewWithTag:4];
    lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
            lbl.hidden=NO;
            //NSLog(@"cellcheck8");
    UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.hidden=NO;
    //NSLog(@"patientteststatus_arr value:%@",[self.patientteststatus_arr objectAtIndex:indexPath.row]);

            if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Positive"]||[[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Negative"]) {
                
                         //NSLog(@"cellcheck9");
                [grphbtn setImage:[UIImage imageNamed:@"blankimg"] forState:UIControlStateNormal];
               grphbtn.hidden=YES;
                lbl=(UILabel*)[cell viewWithTag:6];
                lbl.hidden=YES;
                // lbl_range.text = [self.patienttestrange_arr objectAtIndex:indexPath.row];
                //NSLog(@"cellcheck5");
                //lbl_range.hidden=YES;
                lbl=(UILabel*)[cell viewWithTag:2];
                lbl.hidden=YES;
                //lbl.text = [self.patienttestunits_arr objectAtIndex:indexPath.row];
                //lbl.hidden=YES;
                //NSLog(@"cellcheck6");
                
                //NSLog(@"cellcheck9");
                if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section] isEqualToString:@"Negative"]) {
                    //NSLog(@"cellcheck21");
                    
                    //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                     btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"Negative" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else{
                    //NSLog(@"cellcheck22");
                    //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Positive" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                lbl=(UILabel*)[cell viewWithTag:7];
                lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            }else{
                btn.hidden=NO;
               grphbtn.hidden=NO;
                
                if ([[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]==0.0) {
                    
                    //NSLog(@"Check Ranges");
                    lbl=(UILabel*)[cell viewWithTag:6];
                    lbl.hidden=YES;
                    grphbtn.hidden=YES;
                }else{
            if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]>[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]) {
                         //NSLog(@"cellcheck10");
        //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
        [btn setTitle:@"High" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
    }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]<[[self.patienttestminvalue_arr objectAtIndex:indexPath.section]intValue]) {
                 //NSLog(@"cellcheck11");
       // btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
        btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];

        [btn setTitle:@"Low" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
    }else if ([[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]>=[[self.patienttestminvalue_arr objectAtIndex:indexPath.section]intValue] ||
              [[self.patienttestvalue_arr objectAtIndex:indexPath.section]intValue]<=[[self.patienttestmaxvalue_arr objectAtIndex:indexPath.section]intValue]) {
                //NSLog(@"cellcheck12");
        //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];

        [btn setTitle:@"Normal" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
    }
    lbl=(UILabel*)[cell viewWithTag:6];
                
                
                NSString*strl = [NSString stringWithFormat:@"%@",[self.patienttestrange_arr objectAtIndex:indexPath.section]];
                //NSLog(@"strlenth:%d",(int)strl.length);
                /*
                if (strl.length>10) {
                    lbl.font = [UIFont systemFontOfSize:8];
                }
                 */
    lbl.text = strl;
                
                lbl.hidden=NO;
                         //NSLog(@"cellcheck13");
            }
    
    lbl=(UILabel*)[cell viewWithTag:7];
    lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            }
        }else{
                 //NSLog(@"cellcheck14");
          //  grphbtn.hidden=YES;
            
            //NSLog(@"celldate:%@",[self.patienttestdate_arr objectAtIndex:indexPath.row]);
            //NSLog(@"celldate:%@",[self.patienttesttime_arr objectAtIndex:indexPath.row]);
            
            
            UILabel*lbl;
            
            UILabel*lbl_range;
            
            lbl_range=(UILabel*)[cell viewWithTag:1];
            lbl_range.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:2];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:3];
            lbl.hidden=NO;
            lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.hidden=NO;
            lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
            lbl=(UILabel*)[cell viewWithTag:6];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
            UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];

            [btn setTitle:@"Pending" forState:UIControlStateNormal];
            //btn.hidden=YES;
            
           [grphbtn setImage:nil forState:UIControlStateNormal];
        grphbtn.hidden=YES;
            
            
            //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
            //[btn setTitle:@"Pending" forState:UIControlStateNormal];
            //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==2){
        
        //NSLog(@"Group entred");
        //grphbtn.hidden=YES;
        //NSLog(@"patienttestdate_arr:%@",self.patienttestdate_arr);
        ///NSLog(@"patient date:%@",[self.patienttestdate_arr objectAtIndex:indexPath.row]);
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        lbl.hidden=NO;
        lbl.text = [self.patienttestdate_arr objectAtIndex:indexPath.section];
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl.hidden=NO;
        lbl.text = [self.patienttesttime_arr objectAtIndex:indexPath.section];
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        
        //NSLog(@"patienttest ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
        if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==1) {
            //NSLog(@"Pending check if");
            btn.hidden=YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if ([[self.patienttestisready objectAtIndex:indexPath.section]intValue]==0){
            //NSLog(@"Pending check else");
            btn.hidden=NO;
            btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];
            [btn setTitle:@"Pending" forState:UIControlStateNormal];
            btn.layer.cornerRadius = btn.frame.size.height/2;
        }
        UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        //[grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
        
        //[grphbtn setImage:nil forState:UIControlStateNormal];
        grphbtn.hidden=YES;
        
       
      //cell.accessoryView
    
    }else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==3){
        //NSLog(@"Panel");
       //grphbtn.hidden=YES;
        
        
        
        
        
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = [self.patienttestname_arr objectAtIndex:indexPath.section];
                 //NSLog(@"cellcheck15");
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        btn.hidden=YES;
        UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        [grphbtn setImage:nil forState:UIControlStateNormal];
        grphbtn.hidden=YES;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      //grphbtn.hidden=YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"didselect method.....");
    //NSLog(@"didselect type:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    
    
    //self.navigationController.title=self.navigation_name_str;
    
    if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==2 && [[self.patienttestisready objectAtIndex:indexPath.section]intValue]!=0) {
        //NSLog(@"group entredee didselet");
    
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
        self.navigationController.title = [self.patienttestname_arr objectAtIndex:indexPath.section];
        detailreport.patientid_str = self.patientid_str;
        
        detailreport.testdict = [self.patientgrouptestname_arr objectAtIndex:indexPath.section];
        //NSLog(@"group tests one:%@",[self.patientgrouptestname_arr objectAtIndex:indexPath.row]);
        //NSLog(@"group tests details:%@",detailreport.testdict);
        
        [self.navigationController pushViewController:detailreport animated:YES];
        
        detailreport.filterdateshow_str = self.datestore_str;
        detailreport.tempreportdict = self.tempreportdict;
    } else if ([[self.patienttesttype_arr objectAtIndex:indexPath.section]intValue]==3 && [[self.patienttestisready objectAtIndex:indexPath.section]intValue]!=0) {
        //NSLog(@"group entredee didselet 2");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
        self.navigation_name_str = [self.patienttestname_arr objectAtIndex:indexPath.section];
        detailreport.patientid_str = self.patientid_str;
        detailreport.paneltest_dict = [self.paneltests_arr objectAtIndex:indexPath.row];
        detailreport.panelgrps_dict = [self.panelgrps_arr objectAtIndex:indexPath.section];
    
        [self.navigationController pushViewController:detailreport animated:YES];
        detailreport.filterdateshow_str = self.datestore_str;
        detailreport.tempreportdict = self.tempreportdict;
    }
    self.datestore_str =[NSString stringWithFormat:@"%@",self.dateshow_lbl.text];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)graphBtnClicked:(id)sender{
    UIButton*tagbutton = (UIButton*)sender;
    indexvalue = (int)tagbutton.tag;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];

    IMDIHLReport * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"reportgraph"];
    mrvc.patientid_str = self.patientid_str;
    mrvc.tempreportdict = self.tempreportdict;
    self.datestore_str =[NSString stringWithFormat:@"%@",self.dateshow_lbl.text];
    mrvc.filterdateshow_str = self.datestore_str;
    IMIHLDBManager*dbmanger = [IMIHLDBManager getSharedInstance];
    
    dbmanger = [dbmanger getAllGroupTestsDB:[self.patienttestname_arr objectAtIndex:indexvalue]];
    
    
    //NSLog(@"indexValue:%d",indexvalue);
    //[mrvc allocateArray];
    
    //NSLog(@"arr:%@",self.patienttestid_arr);
    /*
    [mrvc.patienttestid_arr addObject:[self.patienttestid_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestname_arr addObject:[self.patienttestname_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestvalue_arr addObject:[self.patienttestvalue_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestunits_arr addObject:[self.patienttestunits_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestdate_arr addObject:[self.patienttestdate_arr objectAtIndex:indexvalue]];
    [mrvc.patienttesttime_arr addObject:[self.patienttesttime_arr objectAtIndex:indexvalue]];
    [mrvc.patienttesttype_arr addObject:[self.patienttesttype_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestrange_arr addObject:[self.patienttestrange_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestmaxvalue_arr addObject:[self.patienttestmaxvalue_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestminvalue_arr addObject:[self.patienttestminvalue_arr objectAtIndex:indexvalue]];
    [mrvc.patienttestisready addObject:[self.patienttestisready objectAtIndex:indexvalue]];
    */
    
    NSMutableArray*id_arr =[[NSMutableArray alloc]init];
    NSMutableArray*name_arr =[[NSMutableArray alloc]init];
    NSMutableArray*testvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*units_arr =[[NSMutableArray alloc]init];
    NSMutableArray*dates_arr =[[NSMutableArray alloc]init];
    NSMutableArray*time_arr =[[NSMutableArray alloc]init];
    NSMutableArray*type_arr =[[NSMutableArray alloc]init];
    NSMutableArray*range_arr =[[NSMutableArray alloc]init];
    NSMutableArray*maxvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*minvalue_arr =[[NSMutableArray alloc]init];
    NSMutableArray*isready_arr =[[NSMutableArray alloc]init];
    
    //NSLog(@"count paitient:%d",(int)dbmanger.patienttestid_arr.count);
   // int j;
    
    
    //NSLog(@"db testnames:%@",dbmanger.patienttestname_arr);
    for (int i=0; i<dbmanger.patienttestid_arr.count; i++) {
        //NSLog(@"timesss");
        
        //NSLog(@"i value:%d",i);
            if (i<5) {
                
                
            [id_arr addObject:[dbmanger.patienttestid_arr objectAtIndex:i]];
            [name_arr addObject:[dbmanger.patienttestname_arr objectAtIndex:i]];
            [testvalue_arr addObject:[dbmanger.patienttestvalue_arr objectAtIndex:i]];
            [units_arr addObject:[dbmanger.patienttestunits_arr objectAtIndex:i]];
            [dates_arr addObject:[dbmanger.patienttestdate_arr objectAtIndex:i]];
            [time_arr addObject:[dbmanger.patienttesttime_arr objectAtIndex:i]];
            [type_arr addObject:[dbmanger.patienttesttype_arr objectAtIndex:i]];
            [range_arr addObject:[self.patienttestrange_arr objectAtIndex:indexvalue]];
            [maxvalue_arr addObject:[dbmanger.patienttestmaxvalue_arr objectAtIndex:i]];
            [minvalue_arr addObject:[dbmanger.patienttestminvalue_arr objectAtIndex:i]];
            [isready_arr addObject:[dbmanger.patienttestisready objectAtIndex:i]];
               // j++;
            }else{
            
                break;
            }
        }
        
    
    
    mrvc.departmentname_str = [NSString stringWithFormat:@"%@",[self.patienttestdept_arr objectAtIndex:indexvalue]];
   // mrvc.deptName_lbl.text = [NSString stringWithFormat:@"%@",[self.patienttestdept_arr objectAtIndex:indexvalue]];
    //mrvc.testName_lbl.text = [NSString stringWithFormat:@"%@",[self.patienttestname_arr objectAtIndex:indexvalue]];
    
    //NSLog(@"testnames db:%@",name_arr);
    
    mrvc.patienttestid_arr =id_arr;
    mrvc.patienttestname_arr =name_arr;
    mrvc.patienttestvalue_arr =testvalue_arr;
    mrvc.patienttestunits_arr =units_arr;
    mrvc.patienttestdate_arr =dates_arr;
    mrvc.patienttesttime_arr =time_arr;
    mrvc.patienttesttype_arr =type_arr;
    mrvc.patienttestrange_arr =range_arr;
    mrvc.patienttestmaxvalue_arr =maxvalue_arr;
    mrvc.patienttestminvalue_arr =minvalue_arr;
    mrvc.patienttestisready =isready_arr;
   // mrvc.patientid_str = self.patientid_str;
    mrvc.selected_index = [NSString stringWithFormat:@"%d",indexvalue];
    //NSLog(@"reportcheck");
    [self.navigationController pushViewController:mrvc animated:YES];
    
    
    
    
//[self loadViewControllerFromStoryBoard:@"reportgraph"];

}

- (IBAction)backBtnClick:(id)sender {
    //NSLog(@"calledddd:%@",self.calledchg_str);
    if([self.calledchg_str isEqualToString:@"0"]){
        // self.calledchg_str=@"1";
        [self loadViewControllerFromStoryBoard:@"myreports"];
        
    }else{
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
    }
}

- (IBAction)changeButtonClick:(id)sender {
    self.calledchg_str=@"1";
        [self loadViewControllerFromStoryBoard:@"myreports"];
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"myreports"]) {
        MyReportsVC * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"myreports"];
        mrvc.patientid_str = self.patientid_str;
        /*
        if ([self.calledchg_str isEqualToString:@"1"]) {
            mrvc.calledchg_str=@"0";
        }else{
        mrvc.calledchg_str=@"1";
        }
         */
        mrvc.calledchg_str=self.calledchg_str;
        
        self.datestore_str =[NSString stringWithFormat:@"%@",self.dateshow_lbl.text];
        mrvc.filterdateshow_str = self.datestore_str;
        mrvc.tempreportdict = self.tempreportdict;
        //NSLog(@"tempreportdict myreports:%@",self.tempreportdict);
        [self.navigationController pushViewController:mrvc animated:YES];
    }else{
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    if ([self.navigation_name_str isEqualToString:@"0"]) {
    [self.navigationController pushViewController:vc animated:YES];
    }else{
    self.navigationItem.title=self.navigation_name_str;
        
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        detailreport.testdata_arr = self.patientgrouptestname_arr;
    }
    }
    
    
    
    
}

-(void)showAlertController:(NSString*)msgshow{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:msgshow
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    
    [alert addAction:button0];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.labrprt_tblview reloadData];
}

@end
