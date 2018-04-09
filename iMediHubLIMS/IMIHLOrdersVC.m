//
//  IMIHLOrdersVC.m
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLOrdersVC.h"
#import "IMIHLRestService.h"
#import "IMIHLPdfViewer.h"
#import "IMIHLOrderServiceListVC.h"
@interface IMIHLOrdersVC ()

@end

@implementation IMIHLOrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"Orders List View");
    self.navigationController.navigationBarHidden=NO;
    self.orders_tblview.delegate=self;
    self.orders_tblview.dataSource=self;
    //[self getOrdersService];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    [self performSelector:@selector(getOrdersService) withObject:nil afterDelay:0.1];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backItemBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backItemBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backItemBar];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getOrdersService{
    //NSLog(@"getOrdersService called");
    IMIHLRestService*ordersrestcall = [IMIHLRestService getSharedInstance];
    
   // [ordersrestcall getPatientOrdersList:self.patientid_str];
    [ordersrestcall getPatientOrdersList:self.patientid_str withCompletionHandler:^(NSInteger response) {
        if (response == 200) {
            self.orderlist_obj = [[IMIHLOrdersList alloc]init];
            self.orderlist_obj = [self.orderlist_obj getOrdersListResult:ordersrestcall.restresult_dict];
            [self.orders_tblview reloadData];
            //[[NSUserDefaults standardUserDefaults] setObject:ordersrestcall.restresult_dict forKey:@"orders"];
            //[[NSUserDefaults standardUserDefaults]setValue:ordersrestcall.restresult_dict forKey:@"order"];
            //[[NSUserDefaults standardUserDefaults] synchronize];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSData *recentacitivitiesdata = [NSKeyedArchiver archivedDataWithRootObject:self.orderlist_obj];
            
            [[NSUserDefaults standardUserDefaults] setObject:recentacitivitiesdata forKey:@"orderObj"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }else if(response == 0){
           [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [userdefaults objectForKey:@"orderObj"];
             self.orderlist_obj  = (IMIHLOrdersList*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.orders_tblview reloadData];
        }else{
            [self showAlertController:@"Not Avialable"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    /*
    if ([ordersrestcall getPatientOrdersList:self.patientid_str]==200) {
        //NSLog(@"orders result:%@",ordersrestcall.restresult_dict);
        self.orderlist_obj = [[IMIHLOrdersList alloc]init];
        self.orderlist_obj = [self.orderlist_obj getOrdersListResult:ordersrestcall.restresult_dict];
        [self.orders_tblview reloadData];
        //[[NSUserDefaults standardUserDefaults] setObject:ordersrestcall.restresult_dict forKey:@"orders"];
        //[[NSUserDefaults standardUserDefaults]setValue:ordersrestcall.restresult_dict forKey:@"order"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }else{
        //NSLog(@"orderss  localldict:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"orders"]);
        //ordersrestcall.restresult_dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"orders"];
      //ordersrestcall.restresult_dict =  [[NSUserDefaults standardUserDefaults]valueForKey:@"order"];
       // self.orderlist_obj = [[IMIHLOrdersList alloc]init];
        //self.orderlist_obj = [self.orderlist_obj getOrdersListResult:ordersrestcall.restresult_dict];
        //[self.orders_tblview reloadData];
       [self showAlertController:@"Not Avialable"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
     */
    
    }

-(void)reportDownloadPdf:(NSString*)orderid_str :(NSString*)type{
    //NSLog(@"Report Dwonload Pdf");
    
    IMIHLRestService*restserviceObj = [IMIHLRestService getSharedInstance];
   // [restserviceObj downloadFile:orderid_str :self.patientid_str];
    if ([type isEqualToString:@"report"]) {
        if ([restserviceObj reportDownloadPdf:orderid_str :type]==200) {
            self.pdfname = [NSString stringWithFormat:@"%@_%@",type,orderid_str];
            [self loadViewControllerFromStoryBoard:@"pdfviewer"];
        }else{
            
            [self showAlertController:@"Report is not available"];
        }
    }else{
        if ([restserviceObj invoiceDownloadPdf:orderid_str :type]==200) {
            self.pdfname = [NSString stringWithFormat:@"%@_%@",type,orderid_str];
            [self loadViewControllerFromStoryBoard:@"pdfviewer"];
        }else{
            [self showAlertController:@"Invoice is not available"];
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

-(void)downloadPopAlert:(NSString*)msgshow{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Download"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:msgshow
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Report"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                                  [self reportDownloadPdf:self.orderid_str :@"report"];
                              }];
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Invoice"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                                 [self reportDownloadPdf:self.orderid_str :@"invoice"];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [self presentViewController:alert animated:YES completion:nil];
    
    
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

- (IBAction)backBarItemClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboard"];
}

// TableViewDelegateMethods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderlist_obj.orderid_arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.view.frame.size.width<self.view.frame.size.height) {
        return self.orders_tblview.bounds.size.height*0.18;
    }
    return self.orders_tblview.bounds.size.height*0.38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"orderscell";
    
    UITableViewCell *cell = [self.orders_tblview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //NSLog(@"cell if");
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    self.orders_tblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.textLabel.text=@"";
    // [cell.textLabel setText:[self.specialitynamelist_arr objectAtIndex:indexPath.row]];
    cell.layer.cornerRadius = 10.0f;
    UILabel*lbl;
    
    //NSLog(@"cellcheck4");
    lbl=(UILabel*)[cell viewWithTag:1];
    NSString*orderidtemp =[self.orderlist_obj.orderid_arr objectAtIndex:indexPath.section];
    lbl.text =orderidtemp;
    lbl.hidden=NO;
    //NSLog(@"cellcheck5");
    
    lbl=(UILabel*)[cell viewWithTag:2];
    lbl.text = [self.orderlist_obj.orderdate_arr objectAtIndex:indexPath.section];
    lbl.hidden=NO;
    //NSLog(@"dates:%@",[self.orderlist_obj.orderdate_arr objectAtIndex:indexPath.row]);
    lbl=(UILabel*)[cell viewWithTag:3];
    lbl.text = [self.orderlist_obj.ordertime_arr objectAtIndex:indexPath.section];
    lbl.hidden=NO;
    
    UIButton* btninvoice = (UIButton*)[cell viewWithTag:4];
    btninvoice.tag = indexPath.section;
    
    [btninvoice addTarget:self action:@selector(invoicePreview:) forControlEvents:UIControlEventTouchUpInside];
    
    btninvoice.layer.cornerRadius = btninvoice.bounds.size.height/2;
    
    NSArray*arr = [self.orderlist_obj.orderservices_dict objectForKey:orderidtemp];
    
    UIButton* btnreport = (UIButton*)[cell viewWithTag:5];
    btnreport.tag = indexPath.section;
    if (arr.count!= 0) {
        btnreport.enabled = true;
        [btnreport addTarget:self action:@selector(reportPreview:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        btnreport.enabled = false;
    }
    
    btnreport.layer.cornerRadius = btnreport.bounds.size.height/2;
    return cell;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    NSString *headerTitle;
    
    headerTitle = @"DoctorsList";
    
    return headerTitle;
}
*/

-(IBAction)reportPreview:(id)sender{
     UIButton*btn = (UIButton*)sender;
    self.orderid_str=[self.orderlist_obj.orderid_arr objectAtIndex:btn.tag];
        [self loadViewControllerFromStoryBoard:@"orderserviceid"];
    
    
}
-(IBAction)invoicePreview:(id)sender{
    UIButton*btn = (UIButton*)sender;
    self.orderid_str=[self.orderlist_obj.orderid_arr objectAtIndex:btn.tag];
    IMIHLRestService*restserviceObj = [IMIHLRestService getSharedInstance];
    if ([restserviceObj invoiceDownloadPdf:self.orderid_str :@"invoice"]==200) {
      
        [self loadViewControllerFromStoryBoard:@"pdfviewer"];
    }else{
        [self showAlertController:@"Invoice is not available"];
    }
}
#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"Section:%ld Row:%ld selected and its data is %@",
         // (long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
   
}
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    
    if ([identifiername isEqualToString:@"pdfviewer"]) {
    IMIHLPdfViewer*pdfviewobj = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    pdfviewobj.orderid_str = [NSString stringWithFormat:@"invoice_%@",self.orderid_str];
    [self.navigationController pushViewController:pdfviewobj animated:YES];
    }else{
        IMIHLOrderServiceListVC *orderserviceObj =  [storyboard instantiateViewControllerWithIdentifier:identifiername];
        orderserviceObj.services_arr = [self.orderlist_obj.orderservices_dict objectForKey:self.orderid_str];
        if (orderserviceObj.services_arr == nil) {
            
        }else{
            orderserviceObj.orderid = self.orderid_str;
            [self.navigationController pushViewController:orderserviceObj animated:YES];
        }
        
    }
    
}
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.orders_tblview reloadData];
}
@end
