//
//  ViewController.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "MainViewController.h"
#import "AudioPlayerView.h"
#import "RadioStationSelectionViewController.h"
#import "StationSelectionViewController.h"
#import "AlarmSelectionViewController.h"
#import "SoundSelectionViewController.h"
#import "Configuration.h"
#import "TuneinProvider.h"
#import "StationProvider.h"
#import "Station.h"
#import "StationTuneinDetails.h"
#import "Sound.h"
#import "NSDate+Utility.h"

#define LocalNotificationInfoDateKey @"LocalNotificationInfoDateKey"

@interface MainViewController () <RadioStationSelectionDelegate, StationSelectionDelegate, AlarmSelectionDelegate, SoundSelectionDelegate>
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionValueLabel;
@property (nonatomic, weak) IBOutlet UIButton *radioSelectionButton;
@property (nonatomic, weak) IBOutlet UILabel *alarmSelectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *alarmSelectionValueLabel;
@property (nonatomic, weak) IBOutlet UIButton *alarmSelectionButton;
@property (weak, nonatomic) IBOutlet UILabel *soundSelectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundSelectionValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *soundSelectionButton;
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayerView *audioPlayerView;
@property (nonatomic, strong) TuneinProvider *tuneinProvider;
@property (nonatomic, strong) StationProvider *stationProvider;
@end

@implementation MainViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self != nil) {
		self.tuneinProvider = [TuneinProvider sharedProvider];
		self.stationProvider = [StationProvider sharedProvider];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self refreshView];
	[self configureAccessibilityLabels];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
}

- (void)refreshView {
	[self addPlayerView];
	self.radioSelectionValueLabel.text = [Configuration currentConfiguration].currentSelectedRadioStationURLString;
	self.alarmSelectionValueLabel.text = [[Configuration currentConfiguration].currentAlarmDate dateAndTimeString];
	self.soundSelectionValueLabel.text = [Configuration currentConfiguration].currentSelectedSound.soundName;
	if ([Configuration currentConfiguration].shouldPlayImmediately) {
		[Configuration currentConfiguration].playImmediately = NO;
		NSURL *url = [Configuration currentConfiguration].currentSelectedRadioStationURL;
		if (url == nil) {
			url = [NSURL URLWithString:[Configuration currentConfiguration].currentSelectedRadioStationURLString];
		}
		
		STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
		[self.audioPlayer queueDataSource:dataSource withQueueItemId:@0];
	}
}

- (void)addPlayerView {
	if (self.audioPlayer != nil) {
		[self.audioPlayer stop];
	}
	self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = YES, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
	self.audioPlayer.meteringEnabled = YES;
	self.audioPlayer.volume = 1;
	
	[self.audioPlayerView removeFromSuperview];
	self.audioPlayerView = [[AudioPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2) withAudioPlayer:self.audioPlayer];
	//audioPlayerView.delegate = self;
	
	[self.view addSubview:self.audioPlayerView];
}

- (void)viewDidLayoutSubviews {
	self.audioPlayerView.frame = CGRectMake(8, self.view.bounds.size.height / 2, self.view.bounds.size.width - 16, (self.view.bounds.size.height - 16) / 2);
}

- (void)configureAccessibilityLabels {
	self.view.accessibilityLabel = @"MainView";
	self.audioPlayerView.accessibilityLabel = @"AudioPlayerView";
	self.radioSelectionLabel.accessibilityLabel = @"RadioSelectionLabel";
	self.radioSelectionValueLabel.accessibilityLabel = @"RadioSelectionValueLabel";
	self.radioSelectionButton.accessibilityLabel = @"RadioSelectionButton";
	self.alarmSelectionLabel.accessibilityLabel = @"AlarmSelectionLabel";
	self.alarmSelectionValueLabel.accessibilityLabel = @"AlarmSelectionValueLabel";
	self.alarmSelectionButton.accessibilityLabel = @"AlarmSelectionButton";
	self.soundSelectionLabel.accessibilityLabel = @"SoundSelectionLabel";
	self.soundSelectionValueLabel.accessibilityLabel = @"SoundSelectionValueLabel";
	self.soundSelectionButton.accessibilityLabel = @"SoundSelectionButton";
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)radioSelectionButtonTouched:(id)sender {
//	RadioStationSelectionViewController *controller = [[RadioStationSelectionViewController alloc] initWithNibName:@"RadioStationSelectionViewController" bundle:nil];
//	controller.delegate = self;
//	[self presentViewController:controller animated:YES completion:NULL];
	StationSelectionViewController *controller = [[StationSelectionViewController alloc] initWithNibName:@"StationSelectionViewController" bundle:nil];
	controller.delegate = self;
	controller.audioPlayer = self.audioPlayer;
	[self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)alarmSelectionButtonTouched:(id)sender {
	AlarmSelectionViewController *controller = [[AlarmSelectionViewController alloc] initWithNibName:@"AlarmSelectionViewController" bundle:nil];
	controller.delegate = self;
	[self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)soundSelectionButtonTouched:(id)sender {
	SoundSelectionViewController *controller = [[SoundSelectionViewController alloc] initWithNibName:@"SoundSelectionViewController" bundle:nil];
	controller.delegate = self;
	[self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark -
#pragma mark RadioStationSelectionDelegate
#pragma mark -

- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectionViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

//- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStationURLString:(NSString *)radioStationURLString {
//	[Configuration currentConfiguration].currentSelectedRadioStationURLString = radioStationURLString;
//	[self dismissViewControllerAnimated:YES completion:NULL];
//	[self refreshView];
//}
//
//- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStationURL:(NSURL *)radioStationURL {
//	[Configuration currentConfiguration].currentSelectedRadioStationURL = radioStationURL;
//	[self dismissViewControllerAnimated:YES completion:NULL];
//	[self refreshView];
//}

- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStation:(Station *)station {
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[weakSelf.tuneinProvider loadTuneinDataWithStationId:station.stationId
											   forTuneinBase:self.stationProvider.tuneinBase
											  withCompletion:^(id tuneinData, NSError *error) {
												  [Configuration currentConfiguration].currentSelectedRadioStationURLString = weakSelf.tuneinProvider.tuneinDetails.fileURLStrings[0];
												  [weakSelf refreshView];
											  }];
	}];
}

#pragma mark -
#pragma mark StationSelectionDelegate
#pragma mark -

- (void)stationSelectionViewControllerDidCancel:(StationSelectionViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)stationSelectionViewController:(StationSelectionViewController *)controller didFinsishWithStation:(Station *)station {
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[weakSelf.tuneinProvider loadTuneinDataWithStationId:station.stationId
											   forTuneinBase:self.stationProvider.tuneinBase
											  withCompletion:^(id tuneinData, NSError *error) {
												  [Configuration currentConfiguration].currentSelectedRadioStationURLString = weakSelf.tuneinProvider.tuneinDetails.fileURLStrings[0];
												  [weakSelf refreshView];
											  }];
	}];
}

#pragma mark -
#pragma mark AlarmSelectionDelegate
#pragma mark -

- (void)alarmSelectonVCDidCancel:(AlarmSelectionViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)alarmSelectionVC:(AlarmSelectionViewController *)controller didFinishWithAlarmDate:(NSDate *)date {
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[Configuration currentConfiguration].currentAlarmDate = date;
		[weakSelf refreshView];
		[weakSelf createLocalNotificationForDate:date];
	}];
}

- (void)registerForLocalNotifications {
	UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
	UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
	[[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

- (void)createLocalNotificationForDate:(NSDate *)date {
	//if ([[UIApplication sharedApplication] currentUserNotificationSettings] == nil) {
		[self registerForLocalNotifications];
	//}
	
	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	if (localNotif == nil) {
		return;
	}
	
	Sound *currentSound = [Configuration currentConfiguration].currentSelectedSound;
	
	localNotif.fireDate = date;
	localNotif.timeZone = [NSTimeZone defaultTimeZone];
	localNotif.alertBody = @"Aufwachen!";
	localNotif.alertAction = @"Jetzt!";
	localNotif.alertTitle = @"Wirklich!";
	localNotif.soundName = currentSound != nil ? currentSound.soundFullName : UILocalNotificationDefaultSoundName;
	localNotif.applicationIconBadgeNumber = 1;
	localNotif.userInfo = @{LocalNotificationInfoDateKey: date};
	
 	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

#pragma mark -
#pragma mark SoundSelectionDelegate implementation
#pragma mark -

- (void)soundSelectionViewControllerDidCancel:(SoundSelectionViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)soundSelectionViewController:(SoundSelectionViewController *)controller didFinishWithSound:(Sound *)sound {
	[[Configuration currentConfiguration] setCurrentSelectedSound:sound];
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[weakSelf refreshView];
	}];
}

@end
