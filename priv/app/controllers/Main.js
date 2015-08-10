var module = angular.module('soil.controllers.Main', []);

module.controller('MainController',['$scope','BulletService',function($scope,BulletService) {

  $scope.channels = [];

  $scope.send = function() {
    BulletService.send({ some: "obj" });
  }

}]);
