module = angular.module('soil.services.Bullet',[]);

module.factory('BulletService', ['$q','$cookies','$timeout','$rootScope',
  function($q,$cookies,$timeout,$rootScope) {  

  var Service = { promise: null, cid : 0 };

  var clientTimeout = $cookies.clientTimeout;
  var sid = $cookies.SID;
  var url = "wss:" + '//' + window.location.hostname + ':8443/bullet/' + sid;
  console.log("Bullet URL: ",url);
  var options = { 'disableEventSource': true, 'disableXHRPolling' : true};

  var bullet = $.bullet(url, options);
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
    console.log("CONNECTION OPENED: ",bullet);
  };

  bullet.onclose = bullet.ondisconnect = function(){
    console.log('CONNECTION CLOSED');
    isOpened = false;
  };

  bullet.onmessage = function(e){
    if (e.data != 'pong'){
      listener($.parseJSON(e.data));
    }
  };

  bullet.onheartbeat = function(){
    console.log('HEARTBEAT');
  };

  function sendRequest(request) {
    var defer = $q.defer();
    var callbackId = getCallbackId();
    Service.cid = callbackId; 
    request.cbid = callbackId;
    var timeoutPromise = $timeout(function(data){
      var timeoutRequest = request;
      timeoutRequest.cbid = callbackId;
      timeoutRequest.data.result = "timeout";
      timeoutRequest.data.msg = "A timeout occurred";
      console.log('TIMEOUT',timeoutRequest);
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

  function listener(data) {
    var messageObj = data;
    if(callbacks.hasOwnProperty(messageObj.cbid)) {
      var callback = callbacks[messageObj.cbid];
      $timeout.cancel(callback.timeoutPromise);
      $rootScope.$apply(callback.cb.resolve(messageObj));
      delete callbacks[messageObj.cbid];
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
    msg.cbid = null;
    var promise = sendRequest(msg);
    Service.promise = promise; 
    return promise;
  }
  return Service; 
}]);
