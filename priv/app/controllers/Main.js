var module = angular.module('soil.controllers.Main', []);

module.controller('MainController',['$scope','BulletService','NewsService',function($scope,BulletService,NewsService) {

  $scope.channels = [];
  $scope.tsungReport = document.location.origin + "/static/tsung_report/report.html?dummyVar="+ (new Date()).getTime();
  $scope.toggler = {
    'home':true
    ,'connections':false
    ,'register':false
    ,'benchmark':false
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
    if ($scope.toggler.connections) {
      $scope.view();
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
    });
  }

}]);
