//
//  main.m
//  Alfred-Cocoapods-Search
//
//  Created by Vasilis Akoinoglou on 5/9/13.
//  Copyright (c) 2013 Vasilis Akoinoglou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alfred.h"

@interface NSString (AlfAdditions)
- (NSString *)stripped;
@end
@implementation NSString (AlfAdditions)
- (NSString *)stripped
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *query = [NSString stringWithUTF8String:argv[1]];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://search.cocoapods.org/api/v2.0/pods.picky.hash.json?query=%@&ids=20&offset=0", query]]];
        [req addValue:@"gzip" forHTTPHeaderField:@"Accept-encoding"];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *searchResults = json[@"allocations"][0];
        searchResults = [searchResults lastObject];
        
        Alfred *alfred = [Alfred new];
        
        for (NSDictionary *result in searchResults)
        {
            AlfredObject *obj = [AlfredObject new];
            obj.icon = @"both.png";
            
            NSString *name = result[@"id"];
            NSString *url = result[@"link"];
            NSString *version = result[@"version"];
            NSString *summary = result[@"summary"];
            
            NSArray *platforms = result[@"platforms"];
            
            if (platforms.count)
            {
                if (platforms.count == 1 && [platforms containsObject:@"ios"])
                    obj.icon = @"ios.png";
                else if (platforms.count == 1 && [platforms containsObject:@"osx"])
                    obj.icon = @"osx.png";
            }
            
            obj.title = [NSString stringWithFormat:@"%@ (%@)", [name stripped], [version stripped]];
            obj.subtitle = [summary stripped];
            obj.arg = [url stripped];
            obj.uid = [url stripped];
            
            [alfred.objects addObject:obj];
        }
        
        [alfred.objects sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
        printf("%s", [[alfred serializedResults] UTF8String]);
        
    }
    return 0;
}

