//
//  PlacieViewController.m
//  PKMultipartInputStream
//
//  Created by keenteam on 2018/12/12.
//  Copyright © 2018年 FilePost. All rights reserved.
//



-(void)multiPartPost:(NSDictionary *)dicData{
    
       NSURL *url = [NSURL URLWithString:@"http://192.168.1.112:8080/TestSerlvet/interfaces"];
       NSMutableString *bodyContent = [NSMutableString string];
        for(NSString *key in dicData.allKeys){
            id value = [dicData objectForKey:key];
                [bodyContent appendFormat:@"--%@\r\n",POST_BOUNDS];
                [bodyContent appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
                 [bodyContent appendFormat:@"%@\r\n",value];
             }
         [bodyContent appendFormat:@"--%@--\r\n",POST_BOUNDS];
         NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
         NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
         [request addValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",POST_BOUNDS] forHTTPHeaderField:@"Content-Type"];
         [request addValue: [NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
         [request setHTTPMethod:@"POST"];
         [request setHTTPBody:bodyData];
         NSLog(@"请求的长度%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
         __autoreleasing NSError *error=nil;
         __autoreleasing NSURLResponse *response=nil;
         NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding]);
         NSData *reciveData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
         if(error){
                 NSLog(@"出现异常%@",error);
             }else{
                     NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
                     if(httpResponse.statusCode==200){
                             NSLog(@"服务器成功响应!>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
            
                         }else{
                                 NSLog(@"服务器返回失败>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
                    
                             }
            
                 }
}




AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]; manager.requestSerializer.timeoutInterval = 20;
manager.responseSerializer.acceptableContentTypes = [NSSetsetWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
NSDictionary*dict = @{@"token":access_toke};
NSString*url = @"http://api.cwaipo.cn/users/uploadUserImage";
[manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) { [formData appendPartWithFileData:imageData name:@"userImg"fileName:@"1.jpg"mimeType:@"image/jpg"]; } progress:^(NSProgress* _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask* _Nonnull task, id_Nullable responseObject) { [NSNotificationCenter.defaultCenter postNotificationName:@"userUploadAvatarSuccess"object:nil];NSLog(@"上传成功%@",responseObject);
    
} failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {NSLog(@"上传失败"); }]; }





#import <AFHTTPSessionManager.h>

NSDictionary*params = @{@"param1": @"xxx";@"param2":@"xxx"};
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]; manager.responseSerializer = [AFHTTPResponseSerializer serializer];
manager.responseSerializer.acceptableContentTypes = [NSSetsetWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
[manager.requestSerializer setValue:@"multipart/form-data"forHTTPHeaderField:@"Content-Type"];
[manager POST:@"https://www.xxx.com"parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {//给定数据流的数据名，文件名，文件类型（以图片为例）[formData appendPartWithFileData:_iconData name:@"image"fileName:@"image.png"mimeType:@"image/png"];/*常用数据流类型： @"image/png" 图片 @“video/quicktime” 视频流 */} progress:^(NSProgress* _Nonnull uploadProgress) { } success:^(NSURLSessionDataTask* _Nonnull task, id_Nullable responseObject) { [SVProgressHUD dismiss];NSDictionary*resDict = [NSJSONSerializationJSONObjectWithData:responseObject options:NSJSONReadingMutableContainerserror:nil];NSLog(@"resDict:%@",resDict);NSString*result_code = [resDict objectForKey:@"result_code"];if([result_code isEqual:@"SUCCESS"]) { [self.navigationController popViewControllerAnimated:YES]; } } failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {NSLog(@"error:%@",error); }];
    
    
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager]; [session.requestSerializer setValue:@"multipart/form-data"forHTTPHeaderField:@"Content-Type"]; [session POST:@"YOUR URL PATH"parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){NSData*data = [[NSDataalloc] initWithContentsOfFile:path]; [formData appendPartWithFileData :data name:@"content"fileName:@"928-1"mimeType:@"multipart/form-data"]; } progress:nilsuccess:^(NSURLSessionDataTask* _Nonnull task, id_Nonnull responseObject){ success(); } failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error){ fail(); }];
    
    
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",                                                         @"text/html", @"image/jpeg",  @"image/png",  @"text/json", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",[utils getAppUploadMeidaUrl],ModifyPIC] parameters:dictonary constructingBodyWithBlock:^(id formData) {
        if (self.arrPic.count) {
            for (UIImage *eImage in self.arrPic) {
                int x = arc4random() % 100;
                int y = arc4random() % 100;
                NSData *imageData=UIImageJPEGRepresentation(eImage,100);
                NSString *fileName=[NSString stringWithFormat:@"%zd-%zd.jpg",x,y];
                NSString *photoDescribe=@" ";
                //照片content
                [formData appendPartWithFileData:imageData name:@"picFile" fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject=== %@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"task=== %@",task);
        NSLog(@"error=== %@",error);
    }];
    
    
    
    
    
    
    
    
#define TEST_FORM_BOUNDARY @"test1234"
    
#define BMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
    
    
    -(void)sendPost:(NSString*)urlStr Paramater:(NSDictionary*)para data:(NSData*)data name:(NSString*)fileName andContentType:(NSString *)cotentype
    
    {
        
        NSMutableData *dataM = [NSMutableDatadata];
        
        /* 普通参数*/
        
        [para enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
            
            NSString *boundry = [NSStringstringWithFormat:@"--%@\r\n",TEST_FORM_BOUNDARY];
            
            [dataM appendData:BMEncode(boundry)];
            
            NSString *disposition = [NSStringstringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key];
            
            NSLog(@"%@",disposition);
            
            [dataM appendData:BMEncode(disposition)];
            
            [dataM appendData:BMEncode(@"\r\n")];
            
            [dataM appendData:BMEncode(obj)];
            
            [dataM appendData:BMEncode(@"\r\n")];
            
            
            
        }];
        
        /* 普通参数*/
        
        /* 文件参数*/
        
        if(data&&data.length>0)
            
        {
            
            NSString *boundry = [NSStringstringWithFormat:@"--%@\r\n",TEST_FORM_BOUNDARY];
            
            [dataM appendData:BMEncode(boundry)];
            
            NSString *disposition=[NSStringstringWithFormat:@"Content-Disposition:form-data; name=\"uploadfile\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",fileName,cotentype];
            
            NSLog(@"%@",disposition);
            
            [dataM appendData:BMEncode(disposition)];
            
            [dataM appendData:data];
            
            [dataM appendData:BMEncode(@"\r\n")];
            
            
            
        }
        
        /* 文件参数*/
        
        //尾部的分隔符
        
        NSString *strBottom = [NSStringstringWithFormat:@"--%@--\r\n",TEST_FORM_BOUNDARY];
        
        [dataM appendData:BMEncode(strBottom)];
        
        NSURL *url = [NSURLURLWithString:urlStr];
        
        NSMutableURLRequest *request = [[NSMutableURLRequestalloc]initWithURL:url];
        
        [request setValue:@"ZYB" forHTTPHeaderField:@"User-Agent"];
        
        [request setValue:@"max-age=7200" forHTTPHeaderField:@"Cache-Control"];
        
        //设置上传数据的长度及格式
        
        [request setValue:[NSStringstringWithFormat:@"multipart/form-data; boundary=%@",TEST_FORM_BOUNDARY]forHTTPHeaderField:@"Content-Type"];
        
        [request setValue:[NSStringstringWithFormat:@"%lu",(unsignedlong)dataM.length]forHTTPHeaderField:@"Content-Length"];
        
        
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:dataM];
        
        //创建会话
        
        NSURLSession *session = [NSURLSessionsharedSession];
        
        NSURLSessionUploadTask *updataTask = [sessionuploadTaskWithRequest:requestfromData:dataM completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error) {
            
            if (!error) {
                
                NSLog(@"response:%@",response);
                
                NSString *dataStr = [[NSStringalloc]initWithData:dataencoding:NSUTF8StringEncoding];
                
                
                
                NSLog(@"dataStr:%@",dataStr);
                
            }else{
                
                NSLog(@"error:%@",error);
                
            }
            
        }];
        
        [updataTask resume];
        
    }

