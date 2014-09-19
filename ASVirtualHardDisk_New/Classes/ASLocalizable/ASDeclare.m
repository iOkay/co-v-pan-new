//
//  ASDeclare.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASDeclare.h"
#import "ASLocalDefine.h"


@implementation ASDeclare

@synthesize fileTooLarge;
@synthesize fileIKnow;

@synthesize Preferences;
@synthesize DriveInfo;
@synthesize NickNameTitle;
@synthesize Home;
@synthesize TotalSpace;
@synthesize FreeSpace;

@synthesize resultText;
@synthesize gotobutton;

@synthesize createfolder;
@synthesize logpath;
@synthesize logpathList;
@synthesize logpathdown;
@synthesize filerequest;

@synthesize currenttime;

@synthesize namefile;
@synthesize tap;
@synthesize recorder;
@synthesize cancel;
@synthesize use;

@synthesize noweb;
@synthesize downok;
@synthesize downfalse;
@synthesize downsuspend;

@synthesize wait;

@synthesize entries;
@synthesize failed;
@synthesize error;
@synthesize errorfile;
@synthesize readfailed;
@synthesize set;

@synthesize filefalse;
@synthesize save;
@synthesize server;
@synthesize realimg;
@synthesize Connectby;
@synthesize Or;
@synthesize imgswitch;
@synthesize settingdown;
@synthesize quarterCWPressed;
@synthesize quarterCCWPressed;
@synthesize halfPressed;
@synthesize altermodify;
@synthesize quefile;
@synthesize coverfile;
@synthesize yes;
@synthesize OkIKonw;
@synthesize NoDirctory;
@synthesize status;
@synthesize dashboard;
@synthesize local;
@synthesize IntroductionText;       
@synthesize ConnectingText;
@synthesize TipsText;
@synthesize cantopen;

@synthesize alertWarning;
@synthesize alertMessage;
@synthesize alertSure;

@synthesize navBack;
@synthesize navDone;
@synthesize navDelete;
@synthesize navEdit;

@synthesize fileButtonTitle;

@synthesize verifyAlertTitle;
@synthesize verifyAlertMessage;
@synthesize verifyAlertSure;

@synthesize fileListViewAlertTitle;
@synthesize fileListViewAlertSure;
@synthesize fileListViewEdit;
@synthesize fileListViewDone;
@synthesize fileListSelectedAll;
@synthesize fileListSelectedCancel;

@synthesize deleteFileAlertTitle;
@synthesize deleteFileAlertMessage;
@synthesize deleteFileAlertSure;
@synthesize deleteFileAlertCancel;

@synthesize fileOperateDelete;
@synthesize fileOperateCopy;
@synthesize fileOperateMove;
@synthesize fileOperateCancel;
@synthesize fileOperateRoot;
@synthesize fileOperateNum;
@synthesize fileOperateZip;
@synthesize fileOperateEMail;

@synthesize resultList;

@synthesize UnkonwType;
@synthesize directoryType;

@synthesize resultAlertWarning;
@synthesize resultAlertMessage;
@synthesize resultAlertSure;

@synthesize selectedFilesEmpty;
@synthesize canNotSendMail;
@synthesize renameWarning;

@synthesize deletebutton;
@synthesize copybutton;
@synthesize zipbutton;
@synthesize emailbutton;
@synthesize sharebutton;
@synthesize movebutton;
@synthesize vdeletebutton;
@synthesize vcopybutton;
@synthesize vzipbutton;
@synthesize vemailbutton;
@synthesize vsharebutton;
@synthesize vmovebutton;

@synthesize downloadTitle;
@synthesize zbarResult;

static ASDeclare *declare;

//------------------------------------------------------------------------------
// - (void) initValue
//------------------------------------------------------------------------------
- (void) initValue
{
    Preferences = KPreferences;
    DriveInfo = KDriveInfo;
    NickNameTitle = KNickNameTitle;
    Home = KHome;
    TotalSpace = KTotalSpace;
    FreeSpace = KFreeSpace;
    
    resultText = KResultText;
    gotobutton = KGotoButton;
    
    createfolder = KCreateFolder;
    logpath = KLogPath;
    logpathList = KLogPathList;
    logpathdown = KLogPathDown;
    filerequest = Kfilerequest;
    
    currenttime = KCurrentTime;
    
    namefile = KNameFile;
    tap = KTap;
    recorder = KRecorder;
    cancel = KCancel;
    use = KUse;
    
    noweb = KNoWeb;
    downfalse = KDownFalse;
    downok = KDownOk;
    downsuspend = KDownSuspend;
    
    wait = KWait;
    
    entries = KEntriesinthezipfile;
    failed = KFailed;
    error = KError;
    errorfile = KErrorFile;
    readfailed = KReadFaile;
    set = KSet;
    
    filefalse = KNotOpen;
    save = KSave;
    server = KServer;
    realimg = KRealImage;
    Connectby = kHttpAddress;
    Or = kFtpAddress;
    imgswitch = KImgSwitch;
    settingdown = KSettingDown;
    quarterCWPressed = KQuarterCW;
    quarterCCWPressed = KQuarterCCW;
    halfPressed = KHalfPressd;
    altermodify = KAltermofiy;
    quefile = KQueFile;
    coverfile = KCoverFile;
    yes = KYES;
    NoDirctory = KNoDirctory;
    OkIKonw = KOkIKonw;
    status = KStatus;
    dashboard = KDashboard;
    local = KLocal;
    IntroductionText = KIntroductionText;
    ConnectingText = KConnectingText;
    TipsText = KTipsText;
    cantopen = KCanTOpen;
    
	alertWarning = kAlertWarning;
	alertSure = kAlertSure;
	alertMessage = kAlertMessage;
	
	navBack = kNavBack;
	navDone = kNavDone;
	navDelete = kNavDelete;
	navEdit = kNavEdit;
	
	fileButtonTitle = kFileButton;
	
	verifyAlertSure = kVerifyAlertSure;
	verifyAlertMessage = kVerifyAlertMessage;
	verifyAlertTitle = kVerifyAlertTitle;
	
	fileListViewAlertTitle = kFileListViewAlertTitle;
	fileListViewAlertSure = kFileListViewAlertSure;
	fileListViewEdit = kFileListViewEditing;
	fileListViewDone = kFileListViewDone;
	fileListSelectedAll = kFileListSelectedAll;
	fileListSelectedCancel = kFileListSelectedCancel;
	
	deleteFileAlertTitle = kDeleteFileAlertTitle;
	deleteFileAlertMessage = kDeleteFileAlertMessage;
	deleteFileAlertSure = kDeleteFileAlertSure;
	deleteFileAlertCancel = kDeleteFileAlertCancel;
	
	fileOperateDelete = kDelete;
	fileOperateCopy = kCopy;
	fileOperateMove = kMove;
	fileOperateCancel = kCancel;
	fileOperateRoot = kRoot;
	fileOperateZip = kOperateZip;
	fileOperateEMail = kOperateEMail;
	fileOperateNum = kOperateNum;
	
	resultList = kResultList;
    
    UnkonwType = kUnknowType;
    directoryType = kDirectoryType;
    
    resultAlertWarning = kResultAlertWarning;
    resultAlertMessage = kResultAlertMessage;
    resultAlertSure = kResultAlertSure;
    
    selectedFilesEmpty = kSelectedFilesEmpty;
	canNotSendMail = kLabelCanNotSendMail;
    renameWarning = kRenameWarning;
    
    fileTooLarge = kFileListLargeFileMessage;
    fileIKnow = kResultAlertSure;
    
    deletebutton = kDeletebutton;
    copybutton = kCopybutton;
    zipbutton = kZipbutton;
    emailbutton = kEmailbutton;
    sharebutton = kSharebutton;
    movebutton = kMovebutton;
    
    vdeletebutton = kvDeletebutton;
    vcopybutton = kvCopybutton;
    vzipbutton = kvZipbutton;
    vemailbutton = kvEmailbutton;
    vsharebutton = kvSharebutton;
    vmovebutton = kvMovebutton;
    
    downloadTitle = kDownLoadTitle;
    zbarResult = KResultText;
}

//------------------------------------------------------------------------------
// + (id) singletionASDeclare
//------------------------------------------------------------------------------
+ (id) singletonASDeclare{
	
	if(nil == declare)
    {
		declare = [[ASDeclare alloc] init];
		[declare initValue];
	}
	
	return declare;
	
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc{
    declare = nil;
    
	[super dealloc];
}

@end