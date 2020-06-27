//
//  MoviesGridViewController.m
//  flix-app
//
//  Created by gfloresv on 6/26/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *movieArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor= [UIColor darkGrayColor];
    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat postersPerRow = 2;
    CGFloat posterWidth = self.collectionView.frame.size.width / postersPerRow;
    CGFloat posterHeight = 1.5 * posterWidth;
    layout.itemSize= CGSizeMake(posterWidth, posterHeight);
}

- (void) fetchMovies {
    NSLog(@"Attempting to fetch movies for grid display");
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                //gets the array of movies
                self.movieArray = dataDictionary[@"results"];
                [self.collectionView reloadData];
            }
        }];
     [task resume];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *curr_movie = self.movieArray[indexPath.item];
    NSLog(@"%@",curr_movie);
    MovieCollectionCell *movieCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = curr_movie[@"poster_path"];
    NSString *fullPosterPathURLString = [baseURLString stringByAppendingFormat:@"%@", posterURLString];
    
    NSURL *posterURLPath = [NSURL URLWithString:fullPosterPathURLString];
    movieCell.posterView.image = nil;
    [movieCell.posterView setImageWithURL:posterURLPath];
 
    return movieCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}
@end
