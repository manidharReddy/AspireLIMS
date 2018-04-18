//
//  IMIHLDoctorsList.m
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDoctorsList.h"

#import "IMIHLRestService.h"
#import "IMIHLDashboardVC.h"
#import "IMIHDoctorProfileView.h"
//#import "IMIHDTimeSlotsVC.h"
#import "IMIHDRTimeSlotVCViewController.h"
@interface IMIHLDoctorsList ()

@end

@implementation IMIHLDoctorsList

- (void)viewDidLoad {
        [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDoctorsList];
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backarrowbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backarrowbutton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backarrowbutton];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDoctorsList{
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetdept getDoctorsList:self.locid_str :self.deptid_str];
    if (statuscode==200) {
        //NSLog(@"status of doctorslist:%@",restgetdept.restresult_dict);
        self.doctobj = [[IMIHLDoctorList alloc]init];
        self.doctobj = [self.doctobj getDoctorListResult:restgetdept.restresult_dict];
        //NSLog(@"doctors ids:%@",self.doctobj.doctid_arr);
        
        [self.DoctotsList_TableView reloadData];
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
    }
}
-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"List of doctors....!"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


// TableViewDelegateMethods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.doctobj.doctid_arr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"DoctorsCell";
    
    UITableViewCell *cell = [self.DoctotsList_TableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //NSLog(@"cell if");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    self.DoctotsList_TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //cell.textLabel.text=@"";
   // [cell.textLabel setText:[self.specialitynamelist_arr objectAtIndex:indexPath.row]];
    

    UILabel*lbl;
    //UILabel*lbl_range;
    //NSLog(@"cellcheck4");
    lbl=(UILabel*)[cell viewWithTag:1];
    lbl.text = [self.doctobj.doctname_arr objectAtIndex:indexPath.row];
    lbl.hidden=NO;
    //NSLog(@"cellcheck5");
    //NSLog(@"self.specialityname_str:%@",self.specialityname_str);
    lbl=(UILabel*)[cell viewWithTag:2];
    lbl.text = self.specialityname_str;
    lbl.hidden=NO;
    //NSLog(@"cellcheck6");
    lbl=(UILabel*)[cell viewWithTag:3];
    //NSLog(@"self.locationname_str:%@",self.locationname_str);
    lbl.text = self.locationname_str;
    lbl.hidden=NO;
    //NSLog(@"cellcheck7");
    UIButton*btn = (UIButton*)[cell viewWithTag:4];
    btn.tag =indexPath.row;
    [btn addTarget:self action:@selector(bookButonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.hidden=NO;
    //NSLog(@"cellcheck8");
    lbl=(UILabel*)[cell viewWithTag:5];
    lbl.text = [NSString stringWithFormat:@"%@ yrs exp * %@ rs",[self.doctobj.doctexp_arr objectAtIndex:indexPath.row],[self.doctobj.doctfee_arr objectAtIndex:indexPath.row]];
    lbl.hidden=NO;
    //NSLog(@"cellcheck9");
    UIImageView*imgview = (UIImageView*)[cell viewWithTag:6];

    [imgview setImage:[UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:[self.doctobj.doctprofileimg_arr objectAtIndex:indexPath.row] options:0]]];
    imgview.hidden=NO;
    
        return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    NSString *headerTitle;
    
    headerTitle = @"DoctorsList";
    
    return headerTitle;
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    self.doctr_arr =nil;
    self.doctr_arr = [[NSMutableArray alloc]init];
    
    [self.doctr_arr addObject:[self.doctobj.doctname_arr objectAtIndex:indexPath.row]];
    [self.doctr_arr addObject:[self.doctobj.doctstds_arr objectAtIndex:indexPath.row]];
    [self.doctr_arr addObject:self.specialityname_str];
    [self.doctr_arr addObject:[self.doctobj.doctprofileimg_arr objectAtIndex:indexPath.row]];
    [self.doctr_arr addObject:[self.doctobj.doctexp_arr objectAtIndex:indexPath.row]];
    [self.doctr_arr addObject:[self.doctobj.doctfee_arr objectAtIndex:indexPath.row]];
    [self.doctr_arr addObject:[self.doctobj.doctspecialty_arr objectAtIndex:indexPath.row]];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          //(long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
    [self loadViewControllerFromStoryBoard:@"doctorprofile"];
    
}
- (IBAction)bookButonClicked:(id)sender {
    UIButton*btn = (UIButton*)sender;
    //NSLog(@"btn index:%d",(int)btn.tag);
    self.dr_name_str = [NSString stringWithFormat:@"%@",[self.doctobj.doctname_arr objectAtIndex:btn.tag]];
    self.doctid_str = [NSString stringWithFormat:@"%@",[self.doctobj.doctid_arr objectAtIndex:btn.tag]];
    self.dr_img_str = [NSString stringWithFormat:@"%@",[self.doctobj.doctprofileimg_arr objectAtIndex:btn.tag]];
    [self loadViewControllerFromStoryBoard:@"bookdrappointmentdoct"];
}
- (IBAction)backArrowLeftClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"dashboardvc"]) {
        IMIHLDashboardVC * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //vc.patientid_str = self.patientid_str;
        //vc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([identifiername isEqualToString:@"doctorprofile"]) {
    IMIHDoctorProfileView *doctrprofileview = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        doctrprofileview.doctr_arr = self.doctr_arr;
        //NSLog(@"doctor profile:%@",doctrprofileview.doctr_arr);
        [self.navigationController pushViewController:doctrprofileview animated:YES];
    }else if ([identifiername isEqualToString:@"bookdrappointmentdoct"]) {
        //NSLog(@"Time slotbookdrappointmentdoct page");
        IMIHDRTimeSlotVCViewController *doctrtimeslotobj = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //doctrprofileview.doctr_arr = self.doctr_arr;
        ////NSLog(@"doctor profile:%@",doctrprofileview.doctr_arr);
        doctrtimeslotobj.doctid_str = self.doctid_str;
        doctrtimeslotobj.dr_img_str = self.dr_img_str;
        doctrtimeslotobj.dr_name_str = self.dr_name_str;
        doctrtimeslotobj.patientid_str = self.patientid_str;
        [self.navigationController pushViewController:doctrtimeslotobj animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
