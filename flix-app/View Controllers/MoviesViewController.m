//
//  MoviesViewController.m
//  flix-app
//
//  Created by gfloresv on 6/25/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include<unistd.h>
#include<netdb.h>
#include "Movie.h"
#import "MovieAPIManager.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *movieArray;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loadingIndicator startAnimating];
    self.tableView.rowHeight = UITableViewAutomaticDimension;	
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
        self.tableView.backgroundColor= [UIColor darkGrayColor];
    [self isNetworkAvailable];
    [self fetchMovies];
    
    //allows 'pull down to refresh'
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
 
}

//credit to: https://stackoverflow.com/questions/8812459/easiest-way-to-detect-internet-connection-on-ios/8813279#8813279
-(BOOL)isNetworkAvailable
{

    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        //added from: https://guides.codepath.org/ios/Using-UIAlertController
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No internet connection"
               message:@"Cannot load. Please check your connection and try again."
        preferredStyle:(UIAlertControllerStyleAlert)];
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            [self isNetworkAvailable];
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
           }];
        return NO;
    }
    else{
        [self fetchMovies];
        NSLog(@"-> connection established!\n");
        return YES;
    }
}

- (void) fetchMovies {
     // new is an alternative syntax to calling alloc init.
     MovieAPIManager *manager = [MovieAPIManager new];
     [manager fetchNowPlaying:^(NSArray *movies, NSError *error) {
         self.movieArray =(NSMutableArray*) movies;
         [self.tableView reloadData];
         [self.loadingIndicator stopAnimating];
     }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    //making an instance of a cell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    //colors the cell
    cell.backgroundColor = [UIColor darkGrayColor];
    //storing the current movie inside of the row (based on the movies position in the movie dict)
    
    Movie *curr_movie = self.movieArray[indexPath.row];
    cell.titleLabel.text = curr_movie.title;
    cell.descriptionLabel.text = curr_movie.descriptionLabel;
    
    //gets the poster path
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = curr_movie.posterUrl;
    NSString *fullPosterPathURLString = [baseURLString stringByAppendingFormat:@"%@", posterURLString];
    
    NSURL *posterURLPath = [NSURL URLWithString:fullPosterPathURLString];
    //clears image
    cell.posterView.image = nil;
    //sets the image view to our requested poster path from the tmdb
    [cell.posterView setImageWithURL:posterURLPath];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Tapping on a movie.");
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.movieArray[indexPath.row];
    DetailsViewController *detailViewController = [segue destinationViewController];
    
    detailViewController.movie = movie;
}


@end
