//
//  BYRSSParser.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYRSSParser.h"
#import "BYArticleModel.h"

@interface BYRSSParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableDictionary *dictTempDataStorage;
@property (nonatomic, strong) NSMutableString *foundValue;
@property (nonatomic, strong) NSString *currentElement;

@end

@implementation BYRSSParser

// 下载并解析数据
//- (void)downloadData {
//    NSString *URLStr = @"http://feed.yeeyan.org/select";
//    NSURL *url = [NSURL URLWithString:URLStr];
//    [self downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
//        //        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //        NSLog(@"%@",str);
//        if (data) {
//            self.xmlParser = [[NSXMLParser alloc] initWithData:data];
//            self.xmlParser.delegate = self;
//            
//            self.foundValue = [[NSMutableString alloc] init];
//            
//            [self.xmlParser parse];
//        }
//    }];
//}

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSArray *dataArr))completionHandler{
    // 创建session configuration对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 创建URLSession对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 创建一个data task对象响应下载的数据
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",[error localizedDescription]);
        } else {
            // 获取响应的状态码
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld",HTTPStatusCode);
            }
            if (data) {
                self.xmlParser = [[NSXMLParser alloc] initWithData:data];
                self.xmlParser.delegate = self;
                
                self.foundValue = [[NSMutableString alloc] init];
                
                [self.xmlParser parse];
            }
            // 回到主队列添加完成后的操作处理
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(self.dataArr);
            }];
        }
    }];
    
    [task resume];
}

#pragma mark - NSXMLParserDelegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.dataArr = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    NSLog(@"%ldItems,%@",self.dataArr.count,self.dataArr);
    NSMutableArray *articleArr = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArr) {
        BYArticleModel *model = [[BYArticleModel alloc] initWithDict:dict];
        [articleArr addObject:model];
    }
    self.dataArr = articleArr;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",[parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"item"]) {
        self.dictTempDataStorage = [[NSMutableDictionary alloc] init];
    }
    self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        [self.dataArr addObject:[self.dictTempDataStorage copy]];
    } else if ([elementName isEqualToString:@"title"]) {
        [self.dictTempDataStorage setObject:[self.foundValue copy] forKey:@"title"];
    } else if ([elementName isEqualToString:@"link"]) {
        [self.dictTempDataStorage setObject:[self.foundValue copy] forKey:@"link"];
    } else if ([elementName isEqualToString:@"description"]) {
//        NSString *description = [self filterHTML:self.foundValue];
        [self.dictTempDataStorage setObject:[self.foundValue copy] forKey:@"description"];
    } else if ([elementName isEqualToString:@"author"]) {
        [self.dictTempDataStorage setObject:[self.foundValue copy] forKey:@"author"];
    }

    // 清空Mutable String
    [self.foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    BOOL isFound = [self.currentElement isEqualToString:@"title"]
    ||[self.currentElement isEqualToString:@"link"]
    ||[self.currentElement isEqualToString:@"description"]
    ||[self.currentElement isEqualToString:@"author"];
    
    if (isFound) {
        if (![string isEqualToString:@"\n"]) {
            [self.foundValue appendString:string];
        }
    }
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
//     NSString * regEx = @"<([^>]*)>";
//     html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

@end
