//
//  Movie.h
//  flix-app
//
//  Created by gfloresv on 7/1/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *descriptionLabel;
@property (nonatomic, strong) NSString *backdropURL;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSURL *posterURLPath;

 - (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;
@end

NS_ASSUME_NONNULL_END
