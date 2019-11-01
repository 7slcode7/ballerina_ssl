import ballerina/grpc;
import ballerina/io;

public function main (string... args) {
    EventServiceClient analyticsClient = new("https://localhost:9806",
    config = {
            secureSocket: {
                 keyStore: {
                    // path: "/home/lahiru/Documents/NewAnalyitics/wso2am-analytics-3.0.3-SNAPSHOT/resources/security/wso2carbon.p12",//"/home/lahiru/Documents/NewAnalyitics/wso2am-analytics-3.0.3-SNAPSHOT/resources/security/wso2carbon.jks",//"home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaKeystore.p12",
                    // password: "wso2carbon"
                       path : "/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaKeystore.p12",
                       password : "ballerina"
                },
                trustStore: {
                    // path:"/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaTruststore.p12",//" "/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaTruststore.p12",
                    // path: "/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaTruststore.p12",
                    //    path: "/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaTruststore.p12",
                    // #####################
                    // path : "/home/lahiru/Downloads/Certificate/client-truststore.p12",
                    // password: "wso2carbon" //ballerina     wso2carbon
                    // #####################
                    path : "/home/lahiru/Desktop/TestZip/mcgw/runtime/bre/security/ballerinaTruststore.p12",
                    password : "ballerina"
                }
            // protocol: {
            //       name: "TLSv1.2",
            //       versions: ["TLSv1.2","TLSv1.1"]//,"TLSv1.1"
            // }
                // ciphers: ["TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
            // certValidation : {
            //       enable: true
            // },
            //  ocspStapling : false
            }
    } );
    // io:println("Grpc :" + streamId +"triggered------------------------>>>>>>>>>>>>>>>>>" );
    grpc:StreamingClient ep;


    var res = analyticsClient->consume(EventServiceMessageListner);
    // var res = analyticsClient->consume();
    if(res is grpc:Error){
        io:println("Error from connector :" + res.reason()+ " - " + <string>res.detail()["message"]);
        return ;
    }
    else{
        io:println("Initialized Connection Successfully");
        ep = res;
    }
    Event event = {payload:"{\"meta_clientType\":\"PRODUCTION\", \"applicationConsumerKey\":\"X9Lbunoh83Kp8KPP1lS_qqyBtcca\", \"applicationName\":\"JWT_APP\", \"applicationId\":\"2\", \"applicationOwner\":\"admin\", \"apiContext\":\"/petstore/v1/1.0.0\", \"apiName\":\"Swagger-Petstore-New\", \"apiVersion\":\"1.0.0\", \"apiResourcePath\":\"/pet/{petId}\", \"apiResourceTemplate\":\"/pet/{petId}\", \"apiMethod\":\"GET\", \"apiCreator\":\"__unknown__\", \"apiCreatorTenantDomain\":\"carbon.super\", \"apiTier\":\"Unlimited\", \"apiHostname\":\"localhost:9095\", \"username\":\"admin\", \"userTenantDomain\":\"__unknown__\", \"userIp\":\"localhost\", \"userAgent\":\"curl/7.58.0\", \"requestTimestamp\":1571378177397, \"throttledOut\":true,\"responseTime\":1620, \"serviceTime\":272, \"backendTime\":1348, \"responseCacheHit\":false, \"responseSize\":0, \"protocol\":\"http\", \"responseCode\":200, \"destination\":\"https://petstore.swagger.io/v2\", \"securityLatency\":12, \"throttlingLatency\":8, \"requestMedLat\":0, \"responseMedLat\":0, \"backendLatency\":1348, \"otherLatency\":0, \"gatewayType\":\"MICRO\", \"label\":\"MICRO\"}",
    headers: [{key:"stream.id", value:"InComingRequestStream"}]};
    grpc:Error? connErr = ep->send(event);
        if (connErr is grpc:Error) {
            io:println("Error from Connector: " + connErr.reason() + " - "
                                       + <string> connErr.detail()["message"]);
        } else {
            io:println("Analytics data passed successfully ---->   ##### ---->");
        }
    
}



service EventServiceMessageListner = service {
        resource function onMessage(string message) {
        // total = 1;
        io:println("#### --------------  Response received from server: " + message);
    }

    resource function onError(error err) {
        io:println("Error reported from server: " + err.reason() + " - "
                                           + <string> err.detail()["message"]);
}

    resource function onComplete() {
        // total = 1;
        io:println("Server Complete Sending Responses.");
    }
};

















// public function main (string... args) {
//     EventServiceClient analyticsClient = new("http://localhost:9806");
//     // io:println("Grpc :" + streamId +"triggered------------------------>>>>>>>>>>>>>>>>>" );
//     grpc:StreamingClient ep;
//     var res = analyticsClient->consume(EventServiceMessageListner);
//     // var res = analyticsClient->consume();
//     if(res is grpc:Error){
//         io:println("Error from connector :" + res.reason()+ " - " + <string>res.detail()["message"]);
//         return ;
//     }
//     else{
//         io:println("Initialized Connection Successfully");
//         ep = res;
//     }
//     Event event = {payload:"{\"meta_clientType\":\"PRODUCTION\", \"applicationConsumerKey\":\"X9Lbunoh83Kp8KPP1lS_qqyBtcca\", \"applicationName\":\"JWT_APP\", \"applicationId\":\"2\", \"applicationOwner\":\"admin\", \"apiContext\":\"/petstore/v1/1.0.0\", \"apiName\":\"Swagger-Petstore-New\", \"apiVersion\":\"1.0.0\", \"apiResourcePath\":\"/pet/{petId}\", \"apiResourceTemplate\":\"/pet/{petId}\", \"apiMethod\":\"GET\", \"apiCreator\":\"__unknown__\", \"apiCreatorTenantDomain\":\"carbon.super\", \"apiTier\":\"Unlimited\", \"apiHostname\":\"localhost:9095\", \"username\":\"admin\", \"userTenantDomain\":\"__unknown__\", \"userIp\":\"localhost\", \"userAgent\":\"curl/7.58.0\", \"requestTimestamp\":1571378177400, \"throttledOut\":true,\"responseTime\":1620, \"serviceTime\":272, \"backendTime\":1348, \"responseCacheHit\":false, \"responseSize\":0, \"protocol\":\"http\", \"responseCode\":200, \"destination\":\"https://petstore.swagger.io/v2\", \"securityLatency\":12, \"throttlingLatency\":8, \"requestMedLat\":0, \"responseMedLat\":0, \"backendLatency\":1348, \"otherLatency\":0, \"gatewayType\":\"MICRO\", \"label\":\"MICRO\"}",
//     headers: [{key:"stream.id", value:"InComingRequestStream"}]};
//     grpc:Error? connErr = ep->send(event);
//         if (connErr is grpc:Error) {
//             io:println("Error from Connector: " + connErr.reason() + " - "
//                                        + <string> connErr.detail()["message"]);
//         } else {
//             io:println("Analytics data passed successfully ---->   ##### ---->");
//         }
// }




// #########################################################################################################
//Section 






// public function dataToAnalytics(string payloadString, string streamId){
//     io:println("Grpc :" + streamId +"triggered------------------------>>>>>>>>>>>>>>>>>" );
//     grpc:StreamingClient ep;
//     var res = analyticsClient->consume(EventServiceMessageListner);
//     // var res = analyticsClient->consume();
//     if(res is grpc:Error){
//         io:println("Error from connector :" + res.reason()+ " - " + <string>res.detail()["message"]);
//         return ;
//     }
//     else{
//         io:println("Initialized Connection Successfully");
//         ep = res;
//     }
//     Event event = {payload:payloadString,
//     headers: [{key:"stream.id", value:streamId}]};
//     grpc:Error? connErr = ep->send(event);
//         if (connErr is grpc:Error) {
//             io:println("Error from Connector: " + connErr.reason() + " - "
//                                        + <string> connErr.detail()["message"]);
//         } else {
//             io:println("Analytics data passed successfully ---->   ##### ---->");
//         }
// }
