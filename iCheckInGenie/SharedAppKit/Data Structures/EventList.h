//
//  EventList.h
//  iCheckInGenie
//
//  Created by Krishna on 7/29/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface EventList : NSObject

@property (nonatomic, retain) NSString *Acct_Id;
@property (nonatomic, retain) NSString *Cnfrm_Cd_Lgth_Nb;
@property (nonatomic, retain) NSString *Comt_Txt;
@property (nonatomic, retain) NSString *Crt_Dttm;
@property (nonatomic, retain) NSString *Custm_Fld_1_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_2_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_3_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_4_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_5_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_6_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_7_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_8_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_9_Sel_In;
@property (nonatomic, retain) NSString *Custm_Fld_10_Sel_In;
//@property (nonatomic, assign) BOOL     Del_Ind;


@property (nonatomic, retain) NSString *Enabl_Db_Sync_In;
@property (nonatomic, retain) NSString *Enabl_Ieventgenie_Data_Src_In;
@property (nonatomic, retain) NSString *Ev_Addr_1_Txt;
@property (nonatomic, retain) NSString *Ev_Addr_2_Txt;
@property (nonatomic, retain) NSString *Ev_Barcd_Type_Cd;

@property (nonatomic, retain) NSString *Ev_Cd_Txt;
@property (nonatomic, retain) NSString *Ev_Chk_In_End_Dttm;
@property (nonatomic, retain) NSString *Ev_Chk_In_Strt_Dttm;
@property (nonatomic, retain) NSString *Ev_City_Txt;


@property (nonatomic, retain) NSString *Ev_Cntct_Id;
@property (nonatomic, retain) NSString *Ev_Cont_Email;
@property (nonatomic, retain) NSString *Ev_Desc;
@property (nonatomic, retain) NSString *Ev_Early_Chk_In_End_Dttm;
@property (nonatomic, retain) NSString *Ev_End_Dt;
@property (nonatomic, retain) NSString *Ev_Id;
@property (nonatomic, retain) NSString *Ev_Nm;

@property (nonatomic, retain) NSString *Ev_St_Cd;
@property (nonatomic, retain) NSString *Ev_Strt_Dt;
@property (nonatomic, retain) NSString *Ev_Sts_Cd;
@property (nonatomic, retain) NSString *Ev_Type_Id;
@property (nonatomic, retain) NSString *Ev_Zip_Cd;
@property (nonatomic, retain) NSString *Hosted_By_Txt;
@property (nonatomic, retain) NSString *Mod_By_Usrid;
@property (nonatomic, retain) NSString *Mod_Dttm;

@property (nonatomic, retain) NSString *ModuleId;

@property (nonatomic, retain) NSString *Parnt_Ev_Id;
@property (nonatomic, retain) NSString *PendingCheckIns;
@property (nonatomic, retain) NSString *Regs_Strt_Dt;
@property (nonatomic, retain) NSString *Sync_Ev_Id;
@property (nonatomic, retain) NSString *TotalAttendees;
@property (nonatomic, retain) NSString *TotalCheckIns;


@end
