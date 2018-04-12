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
@end

@implementation IMIHLReport

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.navigation_name_str =@"0";
    [self setIcons];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";

    if (self.tempreportdict==nil) {
       // self.calledchg_str=@"1";
        
    
        [self callReportMain];
    }else{
        self.dateshow_lbl.text = self.datestore_str;
    IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
        reportvalue= [reportvalue getReportResult:self.tempreportdict];
        
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

-(void)reports:(NSString*)patientid :(NSString*)todate :(NSString*)fromdate{
    
    self.dateshow_lbl.text = self.datestore_str;
    IMIHLRestService*restreport = [IMIHLRestService getSharedInstance];

    [restreport reports:patientid :todate :fromdate withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            
             self.reportValueObj = [[IMIHLReportValue alloc]init];
            self.tempreportdict = restreport.restresult_dict;
            NSLog(@"restreport.restresult_dict:%@",restreport.restresult_dict);
            //reportvalue= [reportvalue getReportResult:restreport.restresult_dict];
            self.reportValueObj = [self.reportValueObj getReports:restreport.restresult_dict];
            
            NSData *recentacitivitiesdata = [NSKeyedArchiver archivedDataWithRootObject:self.reportValueObj];
            
            [[NSUserDefaults standardUserDefaults] setObject:recentacitivitiesdata forKey:@"testedreports"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.labrprt_tblview reloadData];
            
        }else if(response==0){
            
            [self showAlertController:@"No Network Connection"];
            NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [userdefaults objectForKey:@"testedreports"];
             //IMIHLReportValue*reportvalue = [[IMIHLReportValue alloc]init];
            self.reportValueObj = (IMIHLReportValue*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
           
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//////////////////////////////TableView Delegate Methods/////////////////////

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.reportValueObj.alReportObjsArry.count;
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
    
   NSLog(@"cellcheck1");
    //NSLog(@"indexPath:%lu",(long)indexPath.row);
    //NSLog(@"Patient test Name:%@",[self.patienttestname_arr objectAtIndex:indexPath.row]);
   // NSLog(@"types:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    //NSLog(@"is ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
   // NSLog(@"Ready Array:%@",self.patienttestisready);
    if (indexPath.section<self.reportValueObj.alReportObjsArry.count) {
        
    
    ALReports*report = (ALReports*)[self.reportValueObj.alReportObjsArry objectAtIndex:indexPath.section];
    
        NSLog(@"report.resultDataArrObj count:%d",report.resultDataArrObj.count);
        
        NSLog(@"report value:%@",report.testTypeObj);
    NSLog(@"Index Count:%d",indexPath.section);
    
    id objct = [report.resultDataArrObj objectAtIndex:indexPath.section];
    
    if ([objct class] == [ALTest class]) {
        
    
    //if ([report.testTypeObj isEqualToString:@"1"]) {
    //NSLog(@"cellcheck2");
       
    UIButton*grphbtn = (UIButton*)[cell.contentView viewWithTag:8];
        ALTest*testObj = objct;
        //(ALTest*)[report.resultDataArrObj objectAtIndex:indexPath.section];
       // grphbtn.hidden=NO;
       NSLog(@"cellcheck helloooo");
        if ([testObj.isentered isEqualToString:@"1"]) {
           NSLog(@"cellcheck helloooo2");
            //NSLog(@"isrepeated value:%d",[[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]);
            //if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==1) {
            
            if ([testObj.isrepeated isEqualToString:@"1"]) {
                
            
            
            grphbtn.hidden=NO;
            //  grphbtn.hidden=YES;
                
            [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor blueColor] fontSize:25] forState:UIControlStateNormal];
                
               // [grphbtn setImage:[UIImage imageWithIcon:@"fa-line-chart" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
                
                 
            [grphbtn setTag:indexPath.section];
           [grphbtn addTarget:self action:@selector(graphBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }else if([testObj.isrepeated isEqualToString:@"0"]){
                grphbtn.hidden=YES;
                
                [grphbtn setImage:nil forState:UIControlStateNormal];
                [grphbtn setHidden:YES];
            }
                /*
            }else if ([[self.patienttestisrepeated_arr objectAtIndex:indexPath.row]intValue]==0){
               // grphbtn.hidden=YES;
                //grphbtn=nil;
                
                grphbtn.hidden=YES;
                
                [grphbtn setImage:nil forState:UIControlStateNormal];
            [grphbtn setHidden:YES];
            }
            */
            
            NSLog(@"cellcheck3");
    UILabel*lbl;
    UILabel*lbl_range;
    NSLog(@"cellcheck4");
    lbl_range=(UILabel*)[cell viewWithTag:1];
            lbl_range.text = testObj.testresultvalue;
            lbl_range.hidden=NO;
            NSLog(@"cellcheck5");
    lbl=(UILabel*)[cell viewWithTag:2];
    lbl.text = testObj.testunits;
            lbl.hidden=NO;
            NSLog(@"cellcheck6");
    lbl=(UILabel*)[cell viewWithTag:3];
    lbl.text = testObj.testdatesplit;
            lbl.hidden=NO;
            NSLog(@"cellcheck7");
    lbl=(UILabel*)[cell viewWithTag:4];
    lbl.text = testObj.testtimesplit;
            lbl.hidden=NO;
            NSLog(@"cellcheck8");
    UIButton*btn = (UIButton*)[cell viewWithTag:5];
            btn.hidden=NO;
    //NSLog(@"patientteststatus_arr value:%@",[self.patientteststatus_arr objectAtIndex:indexPath.row]);

            if ([testObj.testresultvalue isEqualToString:@"Positive"]||[testObj.testresultvalue isEqualToString:@"Negative"]) {
                
                         NSLog(@"cellcheck9");
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
                if ([testObj.testresultvalue isEqualToString:@"Negative"]) {
                    NSLog(@"cellcheck21");
                    
                    //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                     btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                    [btn setTitle:@"Negative" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
                }else{
                    NSLog(@"cellcheck22");
                    //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                    [btn setTitle:@"Positive" forState:UIControlStateNormal];
                    //lbl_range.textColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
                    lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
                }
                lbl=(UILabel*)[cell viewWithTag:7];
                lbl.text = testObj.testname;
            }else{
                btn.hidden=NO;
               grphbtn.hidden=NO;
                
                if ([testObj.testranges isEqualToString:@"0.0"]) {
                    
                    NSLog(@"Check Ranges");
                    lbl=(UILabel*)[cell viewWithTag:6];
                    lbl.hidden=YES;
                    grphbtn.hidden=YES;
                }else{
            if ([testObj.testresultvalue intValue]>[testObj.testmaxvalue intValue]) {
                         //NSLog(@"cellcheck10");
        //btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
                btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
        [btn setTitle:@"High" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:0/255.0 alpha:1.0];
    }else if ([testObj.testresultvalue intValue]<[testObj.testminvalue intValue]) {
                 //NSLog(@"cellcheck11");
       // btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:155.0/255.0 blue:41.0/255.0 alpha:1.0];
        btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];

        [btn setTitle:@"Low" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
    }else if ([testObj.testresultvalue intValue]>=[testObj.testminvalue intValue] ||
              [testObj.testresultvalue intValue]<=[testObj.testmaxvalue intValue]) {
                //NSLog(@"cellcheck12");
        //btn.backgroundColor = [UIColor colorWithRed:13/255.0 green:183.0/255.0 blue:13.0/255.0 alpha:1.0];
        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];

        [btn setTitle:@"Normal" forState:UIControlStateNormal];
        lbl_range.textColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
    }
    lbl=(UILabel*)[cell viewWithTag:6];
                
                
                NSString*strl = [NSString stringWithFormat:@"%@",testObj.testranges];
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
    grphbtn.hidden=NO;
    lbl=(UILabel*)[cell viewWithTag:7];
    lbl.text = testObj.testname;
            }
        }else{
                 NSLog(@"cellcheck14");
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
            lbl.text = testObj.testdatesplit;
            lbl=(UILabel*)[cell viewWithTag:4];
            lbl.hidden=NO;
            lbl.text = testObj.testtimesplit;
            lbl=(UILabel*)[cell viewWithTag:6];
            lbl.hidden=YES;
            lbl=(UILabel*)[cell viewWithTag:7];
            lbl.text = testObj.testname;
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
        
    }else if([objct class] == [ALGroup class]){
    
    //else if ([report.testTypeObj isEqualToString:@"2"]){
        
        NSLog(@"Group entred");
       // grphbtn.hidden=YES;
        //NSLog(@"patienttestdate_arr:%@",self.patienttestdate_arr);
        ///NSLog(@"patient date:%@",[self.patienttestdate_arr objectAtIndex:indexPath.row]);
        ALGroup*groupObj =objct;
        //(ALGroup*)[report.resultDataArrObj objectAtIndex:indexPath.section];
        UILabel*lbl;
        
        UILabel*lbl_range;
        
        lbl_range=(UILabel*)[cell viewWithTag:1];
        lbl_range.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:2];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:3];
        lbl.hidden=NO;
        lbl.text = groupObj.groupDate;
        lbl=(UILabel*)[cell viewWithTag:4];
        lbl.hidden=NO;
        lbl.text = groupObj.groupTime;
        lbl=(UILabel*)[cell viewWithTag:6];
        lbl.hidden=YES;
        lbl=(UILabel*)[cell viewWithTag:7];
        lbl.text = groupObj.groupName;
        UIButton*btn = (UIButton*)[cell viewWithTag:5];
        
        //NSLog(@"patienttest ready:%@",[self.patienttestisready objectAtIndex:indexPath.row]);
        NSLog(@"groupIsEntered:%@",groupObj.groupIsEntered);
        if ([groupObj.groupIsEntered isEqualToString:@"1"]) {
            //NSLog(@"Pending check if");
            btn.hidden=YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if ([groupObj.groupIsEntered isEqualToString:@"0"]){
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
    
    }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didselect method.....");
    //NSLog(@"didselect type:%@",[self.patienttesttype_arr objectAtIndex:indexPath.row]);
    
    
    //self.navigationController.title=self.navigation_name_str;
    ALReports*report = (ALReports*)[self.reportValueObj.alReportObjsArry objectAtIndex:indexPath.section];
    if ([report.testTypeObj isEqualToString:@"2"]) {
        //NSLog(@"group entredee didselet");
        ALGroup*groupObj = [report.resultDataArrObj objectAtIndex:indexPath.section];
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLDetail*detailreport = [storyboard instantiateViewControllerWithIdentifier:@"detailreport"];
        self.navigationController.title = groupObj.groupName;
        detailreport.patientid_str = self.patientid_str;
         //NSString*keyForGroupTest = [NSString stringWithFormat:@"%@%@",groupObj.groupName,groupObj.groupDate];
        //detailreport.testdict = groupObj.grouptests;
        //NSLog(@"group tests one:%@",[self.patientgrouptestname_arr objectAtIndex:indexPath.row]);
        //NSLog(@"group tests details:%@",detailreport.testdict);
        //detailreport.filterdateshow_str = self.datestore_str;
        //detailreport.tempreportdict = self.tempreportdict;
        detailreport.groupObj = groupObj;
        [self.navigationController pushViewController:detailreport animated:YES];
        
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
    NSLog(@"indexValue:%d",indexvalue);
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];

    IMDIHLReport * mrvc = [storyboard instantiateViewControllerWithIdentifier:@"reportgraph"];
    ALReports*report = [self.reportValueObj.alReportObjsArry objectAtIndex:indexvalue];
   ALTest*testObj = [report.resultDataArrObj objectAtIndex:indexvalue];
    mrvc.testId = testObj.testid;
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
        //detailreport.testdata_arr = self.patientgrouptestname_arr;
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
