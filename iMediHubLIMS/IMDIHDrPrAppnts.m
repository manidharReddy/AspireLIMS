//
//  IMDIHDrPrAppnts.m
//  iMediHubLIMS
//
//  Created by ihub on 06/06/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMDIHDrPrAppnts.h"
#import "MBProgressHUD.h"
#import "IMIHLDBManager.h"
#import "InternetConnection.h"
#import "IMIHLRestService.h"
#import "IMIHDDrPreviousAppts.h"
@interface IMDIHDrPrAppnts ()
@property(nonatomic,retain)NSMutableArray*appntmntid_arr;
@property(nonatomic,retain)NSMutableArray*appntmntusrname_arr;
@property(nonatomic,retain)NSMutableArray*appntmntdptname_arr;
@property(nonatomic,retain)NSMutableArray*appntmnttestname_arr;
@property(nonatomic,retain)NSMutableArray*appntmntdate_arr;
@property(nonatomic,retain)NSMutableArray*appntmnttime_arr;
@property(nonatomic,retain)NSMutableArray*appntmntstatus_arr;@end

@implementation IMDIHDrPrAppnts

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    
    InternetConnection*ic = [InternetConnection getSharedInstance];
    if (ic.CheckNetwork==YES) {
        
        [self performSelector:@selector(getAppointments) withObject:nil afterDelay:0.1];
        
    }else{
        
    }

}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backarrowbarbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backarrowbarbtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backarrowbarbtn];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getAppointments{
    IMIHLRestService*restgetappntmts = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetappntmts getDrAppointments:self.patientid_str];
    if (statuscode==200) {
        //NSLog(@"status of All Appointments:%@",restgetappntmts.restresult_dict);
        if (restgetappntmts.restresult_dict!=nil) {
            
            
            IMIHDDrPreviousAppts*apptobj = [[IMIHDDrPreviousAppts alloc]init];
            apptobj = [apptobj getAppointmentsList:restgetappntmts.restresult_dict];
            //NSLog(@"apptobj apppnts arr:%@",apptobj.doctname_arr);
            //self.deptidlist_arr = deptobj.deptid_arr;
            //self.deptnamelist_arr = deptobj.deptname_arr;
            
            //if ([[restgetappntmts.restresult_dict objectForKey:@"message"]isEqualToString:@"No Records found"]) {
            //  self.apntmentTblView.hidden=YES;
            
            //}else{
            
            self.appntmntid_arr = apptobj.doctname_arr;
            self.appntmntdptname_arr = apptobj.deptname_arr;
            self.appntmnttestname_arr = apptobj.testname_arr;
            self.appntmntdate_arr = apptobj.bookeddate_arr;
            self.appntmnttime_arr = apptobj.bookedtime_arr;
            self.appntmntstatus_arr = apptobj.status_arr;
            
            
            
            
            //}
        }else{
            
            [self showAlertController:@"You dnt have any appointments"];
        }
        
    }else if(statuscode==0){
        
        
        
        
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetappntmts.restresult_dict objectForKey:@"message"]);
        [self showAlertController:@"You dnt have any appointments"];
    }
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

#pragma mark - Table view data source
//////////////////////////////TableView Delegate Methods/////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.appntmntid_arr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //mtable.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    // [cell.imageView setImage:[UIImage imageWithIcon:@"fa-calendar-check-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor brownColor] fontSize:20]];
    
    
    
    
    UILabel*lbl;
    
    //NSLog(@"appntmntdate_arr names:%@",[self.appntmntdate_arr objectAtIndex:indexPath.row]);
    
    lbl=(UILabel*)[cell viewWithTag:1];
    //lbl.text = [self.appntmntusrname_arr objectAtIndex:indexPath.row];
    // lbl.text = [self.appntmntusrname_arr objectAtIndex:indexPath.row];
    
    lbl.text = [self.appntmntid_arr objectAtIndex:indexPath.row];
    //lbl=(UILabel*)[cell viewWithTag:2];
    //lbl.text = [self.appntmntdptname_arr objectAtIndex:indexPath.row];
    //lbl=(UILabel*)[cell viewWithTag:3];
    //lbl.text = [self.appntmnttestname_arr objectAtIndex:indexPath.row];
    lbl=(UILabel*)[cell viewWithTag:4];
    lbl.text = [self.appntmntdate_arr objectAtIndex:indexPath.row];
    lbl=(UILabel*)[cell viewWithTag:7];
    
    lbl.text = [NSString stringWithFormat:@"Time:%@",[self.appntmnttime_arr objectAtIndex:indexPath.row]];
    
    
    //lbl.hidden=YES;
    
    UIButton*btn = (UIButton*)[cell viewWithTag:6];
    [btn setTitle:[self.appntmntstatus_arr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    if ([[self.appntmntstatus_arr objectAtIndex:indexPath.row] isEqualToString:@"pending"]) {
        btn.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:145.0/255.0 blue:50.0/255.0 alpha:1.0];
    }else if ([[self.appntmntstatus_arr objectAtIndex:indexPath.row] isEqualToString:@"confirmed"]){
        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0];
        
    }else{
        btn.hidden=YES;
    }
    
    //lbl=(UILabel*)[cell viewWithTag:6];
    
    //btn.hidden=YES;
    
    
    
    return cell;
}


///////////////////////////////End Of Table Delegate////////////////////////
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
@end
