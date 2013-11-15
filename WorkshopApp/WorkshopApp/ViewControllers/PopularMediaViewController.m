//
//  PopularMediaViewController.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "PopularMediaViewController.h"
#import "PopularMediaCell.h"
#import "ImageViewController.h"
#import "MediaManager.h"
#import "MediaObject.h"

@interface PopularMediaViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MediaManager *mediaManager;
@property (nonatomic, strong) NSArray *mediaObjects;
@end

@implementation PopularMediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    self.title = @"Media";
    
    self.mediaObjects = [NSArray array];

    self.mediaManager = [[MediaManager alloc] init];

    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didTapRefresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    [self updateContent];
}

- (void)updateContent
{
    [self.mediaManager fetchPopularMediaWithCompletionBlock:^(NSArray *media, NSError *error) {

        dispatch_sync(dispatch_get_main_queue(), ^{

            if (media) {
                self.mediaObjects = media;
                [self.tableView reloadData];
                self.navigationItem.rightBarButtonItem.enabled = YES;
            } else if (error) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"An Error Occurred"
                                                                 message:error.localizedDescription
                                                                delegate:nil
                                                       cancelButtonTitle:@"Okay"
                                                       otherButtonTitles:nil];
                [alert show];
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
        });

    }];
}

#pragma mark - Button Actions

- (void)didTapRefresh:(UIBarButtonItem *)sender
{
    sender.enabled = NO;
    [self updateContent];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediaObject *mediaObject = [self.mediaObjects objectAtIndex:indexPath.row];
    ImageViewController *vc = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:Nil mediaObject:mediaObject];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    PopularMediaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PopularMediaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    MediaObject *mediaObject = [self.mediaObjects objectAtIndex:indexPath.row];
    [cell setMediaObject:mediaObject];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.mediaObjects count];
    } else {
        return 0;
    }
}

@end
