package networking;

import haxe.Json;
import sys.Http;

//Maps HTTP status codes to strings.
//TODO: Make this lol.

//This enum describes success and fail HTTP status codes.
//How these are actrually handled is function dependent.
//If you just want to return a normal Success or Fail variable, please see Response below.
enum HttpResponse {
    Success(status:Int, msg:String);
    Fail(status:Int, msg:String);
    Other(status:Int, msg:String);
}

//This enum describes success and fail states, and lets you have custom messages in them indicating what happened.
//It is not used by this class directly, but it is used in classes that use this class.
//For example, User.login might return Fail("Captcha Required") when you need to do a Captcha.
enum Response {
    Success(msg:String);
    Fail(msg:String);
    Other(msg:String);
}

class APICall {
    //Easy shorthand for calling the Discord API.
    //The only supported methods so far are GET and POST.
    public static function call(path:String, method:String, headers:Dynamic, parameters:Dynamic, body:Dynamic):HttpResponse {
        var status:Int;
        var req:Http = new Http("https://discord.com/api/v9/" + path);
        req.onStatus = function(stat:Int) {
            status = stat;
        }

        if (headers != null) {
            for (field in Reflect.fields(headers)) {
                req.addHeader(field, Std.string(Reflect.field(headers, field)));
            }
        }

        if (parameters != null) {
            for (param in Reflect.fields(parameters)) {
                req.addParameter(param, Std.string(Reflect.field(parameters, param)));
            }
        }

        if (body != null) {
            req.setPostData(Json.stringify(body));
        }

        switch (method) {
            case "GET":
                req.request();

            case "POST":
                req.addHeader("content-type", "application/json");
                req.request(true);

            default:
                return HttpResponse.Other(0, "UNIMPLEMENTED");
                //TODO: Implement the methods that will end up here.
        }

        if (status < 200 || (status >= 300 && status < 400)) {
            return HttpResponse.Other(status, req.responseData);
        } else if (status < 300) {
            return HttpResponse.Success(status, req.responseData);
        } else {
            return HttpResponse.Fail(status, req.responseData);
        }
    }
}