module = angular.module('soil.services.Bullet',[]);

module.factory('BulletService', ['$q','$cookies','$timeout','$rootScope','NewsService',
  function($q,$cookies,$timeout,$rootScope,NewsService) {  

  var Service = { url : "", promise: null, cid : 0 };

  var clientTimeout = $cookies.clientTimeout;
  var sid = $cookies.SID;
  var tsid = $cookies.TSID;
  if (sid == undefined) {
    console.log("SETTING SID",tsid);
    $cookies.SID = tsid;
    sid = tsid;
  } 
  var port = "8443";
  var protocol = window.location.protocol;
  if (protocol === "http:") {
    protocol = "ws:"
    port = "8080";
  } else {
    protocol = "wss:"
  }
  Service.url = protocol + '//' + window.location.hostname + ':' + port + '/bullet/' + sid;
  console.log("Bullet URL: ", Service.url);

  var options = { 'disableEventSource': true, 'disableXHRPolling' : true, 'disableWebSocket' : false};

  var bullet = $.bullet(Service.url, options);
  var callbacks = {};
  var currentCallbackId = 0;

  var isOpened = false;
  var scheduledQueue = [];

  bullet.onopen = function(){
    isOpened = true;
    for (var i = 0; i < scheduledQueue.length; i++) {
      console.log("DEQUEUING REQUESTS",scheduledQueue);
      fireBullet(scheduledQueue[i]);
      scheduledQueue.splice(i,1);
    }
    //console.log("CONNECTION OPENED: ",bullet);
  };

  bullet.onclose = bullet.ondisconnect = function(){
    console.log('CONNECTION CLOSED');
    isOpened = false;
  };

  bullet.onmessage = function(e){
    if (e.data != 'pong'){
      var json = $.parseJSON(e.data);
      listener(json);
      if (json.hasOwnProperty('header')) { 
        if (json.header.type === "news") {
          NewsService.news(json);
        }
      }
    }
  };

  bullet.onheartbeat = function(){
    //console.log('HEARTBEAT');
  };

  function sendRequest(request) {
    var defer = $q.defer();
    var callbackId = getCallbackId();
    Service.cid = callbackId; 
    request.header.cbid = callbackId;
    var timeoutPromise = $timeout(function(data){
      var timeoutRequest = request;
      timeoutRequest.header.cbid = callbackId;
      timeoutRequest.header.result = "timeout";
      timeoutRequest.header.msg = "A timeout occurred";
      listener(timeoutRequest);
    },clientTimeout);

    callbacks[callbackId] = {
      time: new Date(),
      cb: defer,
      timeoutPromise: timeoutPromise
    };

    if (isOpened) {
      fireBullet(request);
    } else {
      scheduledQueue.push(request);
    }
    return defer.promise;
  }

  function fireBullet(request) {
    bullet.send(JSON.stringify(request));
  }

  function listener(response) {
    if(callbacks.hasOwnProperty(response.header.cbid)) {
      var callback = callbacks[response.header.cbid];
      $timeout.cancel(callback.timeoutPromise);
      $rootScope.$apply(callback.cb.resolve(response));
      delete callbacks[response.header.cbid];
    }
  }

  function getCallbackId() {
    currentCallbackId += 1;
    if(currentCallbackId > 10000) {
      currentCallbackId = 0;
    }
    return currentCallbackId;
  }

  Service.send = function(msg) {
    msg.header.cbid = null;
    var promise = sendRequest(msg);
    Service.promise = promise; 
    return promise;
  }
  return Service; 
}]);
