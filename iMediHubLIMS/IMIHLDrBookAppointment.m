//
//  IMIHLDrBookAppointment.m
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDrBookAppointment.h"
#import "IMIHLRestService.h"
#import "IMIHDLocations.h"
#import "IMIHLDashboardVC.h"
#import "IMIHDoctorSpecialities.h"
#import "IMIHLDoctorsList.h"
@interface IMIHLDrBookAppointment ()
{
    //BOOL dropdownflagone,dropdownflagtwo,dropdownflaglocation;

}

@end

@implementation IMIHLDrBookAppointment

- (void)viewDidLoad {
    [self.backarrowbutton setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];

    [self getLocationList];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    }else{
    
        IMIHLDoctorsList * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //vc.patientid_str = self.patientid_str;
        //vc.patientname_str = self.patientname_str;
        vc.deptid_str = self.deptid_str;
        vc.locid_str = self.locationid_str;
        vc.specialityname_str = self.specialityname_str;
        vc.locationname_str = self.locationname_str;
        vc.patientid_str = self.patientid_str;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


#pragma mark -kDropDown
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    _Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    _Dropobj.delegate = self;
    [_Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [_Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
        //self.locationid_str =nil;
         self.locationname_str = [self.locationnamelist_arr objectAtIndex:anIndex];
        self.location_dropbtn.titleLabel.text=self.locationname_str;
    
        self.locationid_str = [self.locationidlist_arr objectAtIndex:anIndex];
        //NSLog(@"locationid:%@",self.locationid_str);
    
    self.deptidlist_arr=nil;
    self.specialitynamelist_arr=nil;
    [self getSpecialityList:self.locationid_str];
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    ///----------------Get Selected Value[Multiple selection]-----------------//
    /*
     if (ArryData.count>0) {
     _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
     CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
     _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
     }
     else{
     _lblSelectedCountryNames.text=@"";
     }
     */
}

- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    if ([touch.view isKindOfClass:[UIView class]]) {
        [_Dropobj fadeOut];
    }
}



-(void)getLocationList{
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetdept getDoctorLocations:self.patientid_str];
    if (statuscode==200) {
        //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
        IMIHDLocations*locationobj = [[IMIHDLocations alloc]init];
        locationobj = [locationobj getLocationResult:restgetdept.restresult_dict];
        //NSLog(@"locationobjarr:%@",locationobj.locatid_arr);
        self.locationidlist_arr = locationobj.locatid_arr;
        self.locationnamelist_arr = locationobj.locatname_arr;
        
        if (locationobj.locatid_arr.count!=0) {
            
            [self.location_dropbtn setTitle: [self.locationnamelist_arr objectAtIndex:0] forState: UIControlStateNormal];
            [self getSpecialityList:[locationobj.locatid_arr objectAtIndex:0]];
            [self.specialities_TableView reloadData];
        }
        
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
    }
}

-(void)getSpecialityList:(NSString*)locationid_str{
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetdept getDoctorSpecialities:locationid_str];
    if (statuscode==200) {
        //NSLog(@"status of specialities:%@",restgetdept.restresult_dict);
       IMIHDoctorSpecialities *drspecialityobj = [[IMIHDoctorSpecialities alloc]init];
        drspecialityobj = [drspecialityobj getSpecialitesResult:restgetdept.restresult_dict];
        //NSLog(@"drspecialityobj:%@",drspecialityobj.deptid_arr);
        self.deptidlist_arr = drspecialityobj.deptid_arr;
        self.specialitynamelist_arr = drspecialityobj.specialityname_arr;
        [self.specialities_TableView reloadData];
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
    }
}



-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Appointment"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


- (IBAction)selectLocationClick:(id)sender {
    
    //NSLog(@"locationnamelist_arr:%@",self.locationnamelist_arr);
[_Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Location" withOption:self.locationnamelist_arr xy:CGPointMake(30, self.location_dropbtn.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.specialities_TableView.frame.size.height)) isMultiple:NO];
    
}

-(CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}


// TableViewDelegateMethods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.deptidlist_arr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self screenSize].height/20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[self.specialitynamelist_arr objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    NSString *headerTitle;
    
        headerTitle = @"Specialities";
    
    return headerTitle;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"Section:%d Row:%d selected and its data is %@",
         // indexPath.section,indexPath.row,cell.textLabel.text);
    self.deptid_str = [NSString stringWithFormat:@"%@",[self.deptidlist_arr objectAtIndex:indexPath.row]];
    
    self.specialityname_str =cell.textLabel.text;
    [self loadViewControllerFromStoryBoard:@"doctorslist"];
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
