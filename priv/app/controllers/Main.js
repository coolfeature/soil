var module = angular.module('soil.controllers.Main', []);

module.controller('MainController',['$scope','BulletService','NewsService',function($scope,BulletService,NewsService) {

  $scope.channels = [];

  $scope.toggler = {
    'about':true
    ,'connections':false
  };

  $scope.visible = function(view) {
    for (var key in $scope.toggler) {
      if ($scope.toggler.hasOwnProperty(key)) {
        if (key !== view) {
          if ($scope.toggler[key] == true) {
            $scope.toggler[key] = false;
          }
        } else {
          $scope.toggler[key] = true;
        }
      }
    }
  };

  $scope.$watch(function() {return NewsService},function() {
    if (NewsService.latest != null ) {
      console.log("Latest news: ",NewsService.latest);
    } 
  },true); 

  $scope.view = function() {
    var promise = BulletService.send({ header: { action: "view"} , body : {} });
    promise.then(function(response){
      $scope.channels = response.body;
      console.log("RESPONSE: ",$scope.channels[0].sid);
      console.log("RESPONSE: ",$scope.channels[0].properties.active);
    });
  }

}]);
