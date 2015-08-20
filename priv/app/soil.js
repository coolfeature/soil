var app = angular.module('Soil', [
  'ngCookies'
  ,'soil.controllers.Main'
  ,'soil.controllers.Register'
  ,'soil.services.News'
  ,'soil.services.Bullet'
]);

app.config(function($interpolateProvider){
  $interpolateProvider.startSymbol('{[').endSymbol(']}');
});

app.run(['$rootScope',function($rootScope) {
}]);
