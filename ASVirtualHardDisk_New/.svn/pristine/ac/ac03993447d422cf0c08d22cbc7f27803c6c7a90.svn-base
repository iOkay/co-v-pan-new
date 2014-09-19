//
//  MoongoseServer.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "MongooseServer.h"

@implementation MongooseServer

@synthesize servlets;
@synthesize ctx;

void *handleRequest(enum mg_event event,
                    struct mg_connection *conn,
                    const struct mg_request_info *request_info) {
    
    const char *cl;
    char *buf;
    int len;
    ServletResponse *response = nil;
    
    MongooseServer *server = (MongooseServer *)request_info->user_data;
    
    // Reads the body of the request
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *body = nil;
    
    if ((cl = mg_get_header(conn, "Content-Length")) != NULL) {
        
        len = atoi(cl);
        if ((buf = malloc(len)) != NULL) {
            mg_read(conn, buf, len);
            body = [NSData dataWithBytes:buf length:len];
            free(buf);
        }
    }
    
    NSString *path = [NSString stringWithUTF8String:request_info->uri];
    
    if ([path rangeOfString:@"/(-bin-)/downLoad.tfs"].location != NSNotFound)
    {
        path = @"/(-bin-)/downLoad.tfs";
    }
    
    // Search for a servlet to respond to the exact path
    
    Servlet *servlet = [server.servlets valueForKey:path];
    
    // If an exact match is not found, tries to match wildcard servlets
    if (!servlet) {
        for (NSString *servletPath in server.servlets) {
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"self LIKE %@", servletPath];
            if ([pred evaluateWithObject:path]) {
                servlet = [server.servlets valueForKey:servletPath];
            }
        }
    }
    
    if (servlet) 
    {
        servlet.connect = conn;
        ServletRequest *request = [[[ServletRequest alloc] initWithRequestInfo:request_info body:body] autorelease];
        
        if (strcmp(request_info->request_method, "GET") == 0) {
            response = [servlet doGet:request];
        } else if (strcmp(request_info->request_method, "POST") == 0) {
            response = [servlet doPost:request];
        }
        
    } 
    else
    {
        
        // If directory listing is enabled and no servlet was found, let
        // Mongoose handle it
        
        if (strcmp(mg_get_option(server.ctx, "enable_directory_listing"), "yes") == 0) {
            
            return NULL;
            
        } 
        else 
        {
            
            // If no servlets were found to respond, sends a 404 error
            
            servlet = [[[Servlet alloc] init] autorelease];
            response = [servlet sendNotFound];
        }
    }
    
    NSData *resp = [[response toBinary] retain];
    
    mg_write(conn, [resp bytes], [resp length]);
    
    [pool release];
    
    return "handled";
}


- (id)initWithPort:(int)port allowDirectoryListing:(BOOL)listing {
    if ((self = [super init])) {
        
        NSString *portStr = [NSString stringWithFormat:@"%d", port];
        
        //----------------------------------------------------------
        // Modified by dai Yunxing
        NSString *webPage = NSLocalizedString(@"WebServerWebPage", nil);
        NSMutableString *rootPath = [[NSMutableString alloc] 
                                     initWithString:NSHomeDirectory()];
        [rootPath appendString:webPage];
        NSLog(@"RootPath -- %@",rootPath);
        //----------------------------------------------------------
        
        const char *options[] = {
            "document_root", [rootPath UTF8String],//[NSHomeDirectory() UTF8String],
            "listening_ports", [portStr UTF8String],
            "enable_directory_listing", listing ? "yes" : "no",
            NULL
        };
        
        //---
        [rootPath release];
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (id)initWithOptions:(const char *[])options {
    
    if ((self = [super init])) {
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;

}

- (void)dealloc {
    
    mg_stop(ctx);
    [servlets release];
    NSLog(@"MongooseServer Release");
    [super dealloc];
}

- (void)addServlet:(Servlet *)servlet forPath:(NSString *)path {
    [servlets setValue:servlet forKey:path];
}

- (void)removeServletForPath:(NSString *)path {
    [servlets removeObjectForKey:path];
}

@end
