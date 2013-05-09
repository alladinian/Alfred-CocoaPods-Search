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
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cocoapods.org/search?query=%@&ids=10", query]]];
        [req addValue:@"gzip" forHTTPHeaderField:@"Accept-encoding"];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *searchResults = json[@"allocations"][0];
        searchResults = [searchResults lastObject];
        
        Alfred *alfred = [Alfred new];
        
        for (NSString *result in searchResults)
        {
            AlfredObject *obj = [AlfredObject new];
            obj.icon = @"both.png";
            
            NSXMLDocument *doc = [[NSXMLDocument alloc] initWithXMLString:result options:NSXMLDocumentTidyHTML error:&error];
            NSString *name = [[[[doc rootElement] nodesForXPath:@"//h3/a" error:&error] lastObject] stringValue];
            NSString *url = [[[[[doc rootElement] nodesForXPath:@"//h3/a" error:&error] lastObject] attributeForName:@"href"] stringValue];
            NSString *version = [[[[[doc rootElement] nodesForXPath:@"//span[@class='version']" error:&error] lastObject] childAtIndex:0] stringValue];
            NSString *summary = [[[[doc rootElement] nodesForXPath:@"//p" error:&error] objectAtIndex:1] stringValue];
            
            NSString *os = [[[[doc rootElement] nodesForXPath:@"//span[@class='os']" error:&error] lastObject] stringValue];
            if (os)
            {
                if ([[os lowercaseString] isEqualToString:@"ios only"])
                {
                    obj.icon = @"ios.png";
                }
                else obj.icon = @"osx.png";
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

