module = angular.module('soil.services.News',[]);

module.factory('NewsService', ['$rootScope',function($rootScope) {  

  var Service = { latest: null };
  
  Service.news = function(n) {
    Service.latest = n;
    $rootScope.$apply();
  }

  return Service; 
}]);
