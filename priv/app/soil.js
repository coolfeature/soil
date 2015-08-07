var app = angular.module('Soil', [
  'ngCookies'
  ,'soil.services.Bullet'
  ,'soil.controllers.Main'
]);

app.run(['$rootScope',function($rootScope) {
}]);
