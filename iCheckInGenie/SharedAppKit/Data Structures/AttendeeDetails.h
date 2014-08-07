//
//  AttendeeDetails.h
//  iCheckInGenie
//
//  Created by Krishna on 7/29/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AttendeeDetails : NSObject

@property (nonatomic, retain) NSString *Acct_Id;
@property (nonatomic, retain) NSNumber *Additional_Guests;
@property (nonatomic, retain) NSString *Attendee_Checkedin_Barcd_Txt;
@property (nonatomic, retain) NSString *Attendee_Chkd_In_Sts_Cd;
@property (nonatomic, retain) NSString *Attendee_Id;
@property (nonatomic, retain) NSString *City_Txt;
@property (nonatomic, retain) NSNumber *Cnfrm_Cd;
@property (nonatomic, retain) NSString *Crt_By_Usrid;
@property (nonatomic, retain) NSString *Crt_Dttm;
@property (nonatomic, retain) NSString *Custm_Fld_1_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_1_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_2_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_2_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_3_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_3_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_4_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_4_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_5_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_5_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_6_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_6_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_7_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_7_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_8_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_8_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_9_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_9_Val_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_10_Lbl_Txt;
@property (nonatomic, retain) NSString *Custm_Fld_10_Val_Txt;
@property (nonatomic, retain) NSString *Del_Ind;
@property (nonatomic, retain) NSString *Eml_Addr_Txt;
@property (nonatomic, retain) NSString *Ev_Attendee_Id;
@property (nonatomic, retain) NSString *Ev_Id;
@property (nonatomic, retain) NSString *Ev_Venue_Id;
@property (nonatomic, retain) NSNumber *Fst_Nm;
@property (nonatomic, retain) NSString *Last_Nm;
@property (nonatomic, retain) NSString *Mod_By_Usrid;
@property (nonatomic, retain) NSString *Mod_Dttm;
@property (nonatomic, retain) NSString *Notes;
@property (nonatomic, retain) NSNumber *Phn_Num;
@property (nonatomic, retain) NSString *St_Cd;
@property (nonatomic, retain) NSString *Validity;

@end