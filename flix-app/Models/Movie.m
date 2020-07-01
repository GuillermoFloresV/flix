//
//  Movie.m
//  flix-app
//
//  Created by gfloresv on 7/1/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    self.title = dictionary[@"title"];

    // Set the other properties from the dictionary
    self.descriptionLabel = dictionary[@"overview"];
    self.releaseDate = dictionary[@"release_date"];
    self.backdropURL = dictionary[@"backdrop_path"];
    self.posterUrl = dictionary[@"poster_path"];
    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
   NSMutableArray *movies = [NSMutableArray array];
   for (NSDictionary *dictionary in dictionaries) {
       Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
       [movies addObject:movie];
   }
   return movies;
}
@end
