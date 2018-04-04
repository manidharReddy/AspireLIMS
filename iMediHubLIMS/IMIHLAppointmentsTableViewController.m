//
//  IMIHLAppointmentsTableViewController.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLAppointmentsTableViewController.h"
#import "IMIHLRestService.h"
#import "IMIHLAppointments.h"
#import "MBProgressHUD.h"
#import "IMIHLDBManager.h"
#import "InternetConnection.h"
#import "IMIHLBookAppointment.h"
@interface IMIHLAppointmentsTableViewController ()
@property (strong, nonatomic) IBOutlet UIButton *submit_btn;
@property (strong, nonatomic) IBOutlet UIView *popreason;
@property (strong, nonatomic) IBOutlet UITextView *txtviewreason;
@property(nonatomic,retain)NSMutableArray*appntmntid_arr;
@property(nonatomic,retain)NSMutableArray*appntmntusrname_arr;
@property(nonatomic,retain)NSMutableArray*appntmntdptname_arr;
@property(nonatomic,retain)NSMutableArray*appntmnttestname_arr;
@property(nonatomic,retain)NSMutableArray*appntmntdate_arr;
@property(nonatomic,retain)NSMutableArray*appntmnttime_arr;
@property(nonatomic,retain)NSMutableArray*appntmntstatus_arr;
@end

@implementation IMIHLAppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self setData];
    //[self.backarrowbarbtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    
    self.submitBtn.layer.cornerRadius = self.submitBtn.bounds.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    
    self.cancelBtn.layer.cornerRadius = self.cancelBtn.bounds.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    
    InternetConnection*ic = [InternetConnection getSharedInstance];
    if (ic.CheckNetwork==YES) {
        
        [self performSelector:@selector(getAppointments) withObject:nil afterDelay:0.1];
    
    }else{
    
    }
    
    self.txtviewreason.delegate=self;
    self.popreason.hidden=YES;
   // self.popreason.layer.cornerRadius = 10;
    self.popreason.layer.borderWidth = 1;
    self.popreason.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //self.txtviewreason.layer.cornerRadius = 10;
    self.txtviewreason.layer.borderWidth = 1;
    self.txtviewreason.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    
    //[self getAppointments];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden = NO;
    self.backarrowbarbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backarrowbarbtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backarrowbarbtn];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setData{
    self.appntmntid_arr = [[NSMutableArray alloc]initWithObjects:@"apntmt101",@"apntmt102",@"apntmt103",@"apntmt104", nil];
    //self.appntmntusrname_arr = [[NSMutableArray alloc]initWithObjects:@"Surya bia",@"Kiran bai",@"Naresh",@"Suresh Kumar", nil];
    self.appntmntdptname_arr = [[NSMutableArray alloc]initWithObjects:@"Bio Chemistry",@"Microbiology",@"Pathology",@"Radiology", nil];
    self.appntmnttestname_arr = [[NSMutableArray alloc]initWithObjects:@"Test1",@"Test2",@"Test3",@"Test4", nil];
    self.appntmntdate_arr = [[NSMutableArray alloc]initWithObjects:@"2th June 2016",@"3th May 2016",@"21th Apr 2016",@"2th Apr 2016", nil];
    self.appntmnttime_arr = [[NSMutableArray alloc]initWithObjects:@"11:30am",@"2:30pm",@"11:30am",@"4:30pm", nil];
    [self.apntmentTblView reloadData];
}

-(void)getLocalAppointments{
    IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    [dbmanager getPatientAppointmentsList];
    self.appntmntid_arr = dbmanager.apptid_arr;
    self.appntmntdptname_arr = dbmanager.departmentname_arr;
    self.appntmnttestname_arr = dbmanager.apptest_arr;
    self.appntmntdate_arr = dbmanager.apptdate_arr;
    //self.appntmnttime_arr = apptobj.bookedtime_arr;
    self.appntmntstatus_arr = dbmanager.patientteststatus_arr;
    
    [self.apntmentTblView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)getAppointments{
    IMIHLRestService*restgetappntmts = [IMIHLRestService getSharedInstance];
   // int statuscode =[restgetappntmts getAllAppointments:self.patientid_str];
    [restgetappntmts getAllAppointments:self.patientid_str withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            //NSLog(@"status of All Appointments:%@",restgetappntmts.restresult_dict);
            if (restgetappntmts.restresult_dict!=nil) {
                
                
                IMIHLAppointments*apptobj = [[IMIHLAppointments alloc]init];
                apptobj = [apptobj getAppointmentsList:restgetappntmts.restresult_dict];
                //NSLog(@"apptobj apppnts arr:%@",apptobj.apointmentId_arr);
                //self.deptidlist_arr = deptobj.deptid_arr;
                //self.deptnamelist_arr = deptobj.deptname_arr;
                
                //if ([[restgetappntmts.restresult_dict objectForKey:@"message"]isEqualToString:@"No Records found"]) {
                //  self.apntmentTblView.hidden=YES;
                
                //}else{
                
                self.appntmntid_arr = apptobj.apointmentId_arr;
                self.appntmntdptname_arr = apptobj.deptname_arr;
                self.appntmnttestname_arr = apptobj.testname_arr;
                self.appntmntdate_arr = apptobj.bookeddate_arr;
                self.appntmnttime_arr = apptobj.bookedtime_arr;
                self.appntmntstatus_arr = apptobj.status_arr;
                
                [self.apntmentTblView reloadData];
                
                
                //}
            }else{
                
                [self showAlertController:@"You dnt have any appointments"];
            }
            
        }else if(response==0){

            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restgetappntmts.restresult_dict objectForKey:@"message"]);
            [self showAlertController:@"You dnt have any appointments"];
        }
    }];
    
    [self.apntmentTblView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:alrtmsg
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//////////////////////////////TableView Delegate Methods/////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.appntmntid_arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.view.frame.size.width<self.view.frame.size.height) {
        return self.apntmentTblView.bounds.size.height*0.2;
    }
    return self.apntmentTblView.bounds.size.height*0.4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    //NSLog(@"cellforenter");
    static NSString *CellIdentifier = @"appointmentslist";
    
    UITableViewCell *cell = [self.apntmentTblView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //NSLog(@"cell entered");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    //self.apntmentTblView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //mtable.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
   // [cell.imageView setImage:[UIImage imageWithIcon:@"fa-calendar-check-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor brownColor] fontSize:20]];

    cell.layer.cornerRadius = 10.0f;
    
    
    UILabel*lbl;
    
    //NSLog(@"appntmntdate_arr names:%@",[self.appntmntdate_arr objectAtIndex:indexPath.row]);
    //NSLog(@"testname:%@",[self.appntmnttestname_arr objectAtIndex:indexPath.row]);
    lbl=(UILabel*)[cell viewWithTag:1];
    //lbl.text = [self.appntmntusrname_arr objectAtIndex:indexPath.row];
   // lbl.text = [self.appntmntusrname_arr objectAtIndex:indexPath.row];
    
    lbl.text = self.patientname_str;
    lbl=(UILabel*)[cell viewWithTag:2];
    //lbl.text = [self.appntmntdptname_arr objectAtIndex:indexPath.row];
    UITextView*txtView=(UITextView*)[cell viewWithTag:3];
    txtView.text = [self.appntmnttestname_arr objectAtIndex:indexPath.section];
    lbl=(UILabel*)[cell viewWithTag:4];
    lbl.text = [self.appntmntdate_arr objectAtIndex:indexPath.row];
    lbl=(UILabel*)[cell viewWithTag:5];
    lbl.text = [NSString stringWithFormat:@"Time:%@",[self.appntmnttime_arr objectAtIndex:indexPath.section]];
    
    //lbl.hidden=YES;
    
    UIButton*btncancel = (UIButton*)[cell viewWithTag:10];
    UIButton*btnreschedule = (UIButton*)[cell viewWithTag:11];
    btncancel.layer.cornerRadius = btncancel.bounds.size.height/2;
    btncancel.clipsToBounds = YES;
    
    btnreschedule.layer.cornerRadius = btncancel.bounds.size.height/2;
    btnreschedule.clipsToBounds = YES;
    UIButton*btn = (UIButton*)[cell viewWithTag:6];
    [btn setTitle:[self.appntmntstatus_arr objectAtIndex:indexPath.section] forState:UIControlStateNormal];

    if ([[self.appntmntstatus_arr objectAtIndex:indexPath.section] isEqualToString:@"pendding"]) {
    //btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btncancel.enabled=YES;
        btnreschedule.enabled=YES;
        [btncancel setTag:[[self.appntmntid_arr objectAtIndex:indexPath.section] integerValue]];
        [btncancel addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [btnreschedule setTag:[[self.appntmntid_arr objectAtIndex:indexPath.section] integerValue]];
        [btnreschedule addTarget:self action:@selector(reScheduleSubmit:) forControlEvents:UIControlEventTouchUpInside];

    }else if ([[self.appntmntstatus_arr objectAtIndex:indexPath.section] isEqualToString:@"confirmed"]){
        //btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        btncancel.enabled=YES;
        btnreschedule.enabled=YES;
        [btncancel setTag:[[self.appntmntid_arr objectAtIndex:indexPath.section] integerValue]];
        [btncancel addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [btnreschedule setTag:[[self.appntmntid_arr objectAtIndex:indexPath.section] integerValue]];
        [btnreschedule addTarget:self action:@selector(reScheduleSubmit:) forControlEvents:UIControlEventTouchUpInside];

    }else if ([[self.appntmntstatus_arr objectAtIndex:indexPath.section] isEqualToString:@"Rescheduled"]) {
        //btn.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btncancel.enabled=NO;
        btnreschedule.enabled=NO;
        
    }else if ([[self.appntmntstatus_arr objectAtIndex:indexPath.section] isEqualToString:@"Cancelled"]) {
        btn.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btncancel.enabled=NO;
        btnreschedule.enabled=NO;
        btncancel.hidden=YES;
        btnreschedule.hidden=YES;
        
    }
    
    
    else{
        btn.hidden=YES;
        btncancel.enabled=NO;
        btnreschedule.enabled=NO;
    }
    
    
    
    
    
    //btn.hidden=YES;
    
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.popreason.hidden=YES;
    self.txtviewreason.text=@"Enter Reason";
    [self.txtviewreason resignFirstResponder];
}

-(IBAction)reScheduleClick:(id)sender{
    
    
    
    
    
    
        
    

}

-(void)cancelTextView:(UIButton*)apptid{

   
    
    
    
    //self.reason_str = textview.text;
   
}

-(IBAction)submit:(id)sender{
    
    self.isCancle_str=@"Yes";
    UIButton*apptnmBtn = (UIButton*)sender;
    //NSLog(@"apptnbtn id:%d",apptnmBtn.tag);
    self.apptnID_str = [NSString stringWithFormat:@"%ld",(long)apptnmBtn.tag];
self.popreason.hidden=NO;
}

-(IBAction)reScheduleSubmit:(id)sender{
    
    self.isCancle_str=@"No";
    UIButton*apptnmBtn = (UIButton*)sender;
    //NSLog(@"apptnbtn id:%d",apptnmBtn.tag);
    self.apptnID_str = [NSString stringWithFormat:@"%ld",(long)apptnmBtn.tag];
    self.popreason.hidden=NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   // UITouch *touch = [touches anyObject];
    //NSLog(@"event:%@",touch);
    //if ([touch.view isKindOfClass:[UITableView class]]) {
        self.popreason.hidden=YES;
        self.txtviewreason.text=@"Enter Reason";
     [self.txtviewreason resignFirstResponder];
    
    //}
}

///////////////////////////////End Of Table Delegate////////////////////////
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}








/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backArrowClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

- (IBAction)submitClick:(id)sender {
    //NSLog(@"canceld clicked");
    //UIButton*apptbtn = (UIButton*)sender;
    
    IMIHLRestService*restser = [[IMIHLRestService alloc]init];
   // NSString*appid = [NSString stringWithFormat:@"%d",apptbtn.tag];
    if([self.isCancle_str isEqualToString:@"Yes"]){
        [restser cancelAppointment:self.apptnID_str :self.txtviewreason.text withCompletionHandler:^(NSInteger response) {
            if (response == 200) {
                [self showAlertController:@"Your Appointment has been succesfully canceled"];
            }else{
                 [self showAlertController:@"Cancelation Failed"];
            }
        }];
        /*
    if ([restser cancelAppointment:self.apptnID_str :self.txtviewreason.text] ==200) {
       
        [self showAlertController:@"Succesfully Canceled"];
        
    }else{
        [self showAlertController:@"Cancelation Failed"];
    }
         */
        
        
    }else{
        
        
        [restser reSchedule:self.apptnID_str :self.txtviewreason.text withCompletionHandler:^(NSInteger response) {
            if (response == 200) {
                [self showAlertController:@"Your Appointment has been succesfully canceled"];
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                IMIHLBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"bookappointment"];
                bvc.patientid_str = self.patientid_str;
                bvc.patientname_str = self.patientname_str;
                [self.navigationController pushViewController:bvc animated:YES];
            }else{
                [self showAlertController:@"Re-Schedule Failed"];
            }
        }];
                /*
        if ([restser reSchedule:self.apptnID_str :self.txtviewreason.text] ==200) {
            
            
            
            [self showAlertController:@"Succesfully Re-Schedule"];
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            IMIHLBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"bookappointment"];
            bvc.patientid_str = self.patientid_str;
            bvc.patientname_str = self.patientname_str;
            [self.navigationController pushViewController:bvc animated:YES];
        }else{
            [self showAlertController:@"Re-Schedule Failed"];
        }
                 */
    
    }
    self.popreason.hidden=YES;
}

- (IBAction)cancel:(id)sender {
     self.popreason.hidden=YES;
    self.txtviewreason.text=@"";
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //NSLog(@"textViewShouldBeginEditing:");
    textView.text=@"";
    return YES;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //NSLog(@"textview delegate entred");
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.apntmentTblView reloadData];
}
@end
