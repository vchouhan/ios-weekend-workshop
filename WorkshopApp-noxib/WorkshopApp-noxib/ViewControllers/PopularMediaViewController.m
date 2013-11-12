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

@interface PopularMediaViewController () <UITableViewDataSource, UITableViewDelegate, MediaManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MediaManager *mediaManager;
@property (nonatomic, strong) NSArray *mediaArray;
@end

@implementation PopularMediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.mediaArray = [NSArray array];

    self.mediaManager = [[MediaManager alloc] init];
    self.mediaManager.delegate = self;

    CGRect frame = (CGRect){0, 0, self.view.bounds.size.width, self.view.bounds.size.height};
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateContent
{
    [self.mediaManager fetchPopularMedia];
}

#pragma mark - MediaManager Delegate

- (void)mediaManager:(MediaManager *)mediaManager didSucceedWithMedia:(NSArray *)media
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.mediaArray = media;
        [self.tableView reloadData];
    });
}

- (void)mediaManager:(MediaManager *)mediaManager didFailWithError:(NSError *)error
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"An Error Occurred"
                                                         message:error.localizedDescription
                                                        delegate:nil
                                               cancelButtonTitle:@"Okay"
                                               otherButtonTitles:nil];
        [alert show];
    });
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *vc = [[ImageViewController alloc] init];
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
    
    NSDictionary *mediaObject = [self.mediaArray objectAtIndex:indexPath.row];
    [cell setMediaObject:mediaObject];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.mediaArray count];
    } else {
        return 0;
    }
}

@end
