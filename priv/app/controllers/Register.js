var module = angular.module('soil.controllers.Register', []);

module.controller('RegisterController', ['$scope','$timeout','BulletService', 'FactoryAlert'
    ,function($scope, $timeout, BulletService, FactoryAlert) {

  $scope.alerts = [
    { 'type': 'info', 'msg': 'Please fill in all form elements.' }
  ];

  $scope.pushAlerts = function() {
    var msg = null;
    if ($scope.signUpForm.fname.$invalid && $scope.signUpForm.fname.$dirty 
	&& !$scope.signUpForm.fname.$focused) {
      msg = FactoryAlert.makeAlert("error","First name is required");
    } 
    if ($scope.signUpForm.lname.$invalid && $scope.signUpForm.lname.$dirty 
	&& !$scope.signUpForm.lname.$focused) {
      msg = FactoryAlert.makeAlert("error","Last name is required");
    }
    if ($scope.signUpForm.addressline1.$invalid && $scope.signUpForm.addressline1.$dirty 
	&& !$scope.signUpForm.addressline1.$focused) {
      msg = FactoryAlert.makeAlert("error","Address Line 1 is required");
    }
    if ($scope.signUpForm.addressline2.$invalid && $scope.signUpForm.addressline2.$dirty 
	&& !$scope.signUpForm.addressline2.$focused) {
      msg = FactoryAlert.makeAlert("error","Address Line 2 is required");
    } 
    if ($scope.signUpForm.postcode.$invalid && $scope.signUpForm.postcode.$dirty 
	&& !$scope.signUpForm.postcode.$focused) {
      msg = FactoryAlert.makeAlert("error","Postcode is required");
    }
    if ($scope.signUpForm.city.$invalid && $scope.signUpForm.city.$dirty 
	&& !$scope.signUpForm.city.$focused) {
      msg = FactoryAlert.makeAlert("error","City / Town is required"); 
    }
    if ($scope.signUpForm.email.$invalid && $scope.signUpForm.email.$dirty 
	&& !$scope.signUpForm.email.$focused) {
      msg = FactoryAlert.makeAlert("error","Email is required");
    }
    if ($scope.signUpForm.password.$invalid && $scope.signUpForm.password.$dirty 
	&& !$scope.signUpForm.password.$focused) {
      msg = FactoryAlert.makeAlert("error","Password is required");
    }
    if ($scope.signUpForm.confirm_password.$invalid && $scope.signUpForm.confirm_password.$dirty 
	&& !$scope.signUpForm.confirm_password.$focused) {
      if (!$scope.signUpForm.confirm_password.$error.passwordVerify) {
        msg = FactoryAlert.makeAlert("error","Passwords do not match!");
      }
    }
    if ($scope.signUpForm.confirm_password.$valid && !$scope.signUpForm.confirm_password.$error.passwordVerify) {
      msg = FactoryAlert.makeAlert("error","Please confirm password!");
    } 
    if ($scope.signUpForm.$valid) {
       msg = FactoryAlert.makeAlert("success","Please submit the form.");
    }   
    $scope.pushAlert(msg,true);
  };

  $scope.pushAlert = function(alert,expire) {
    var timeout = 3000;
    if (alert != null) {
      while($scope.alerts.length > 0) {
        $scope.alerts.pop();
      }
      $scope.alerts.push(alert);
    }
    if (expire) {
      $timeout(function(){
        $scope.closeAlert($scope.alerts.indexOf(alert));
       }, timeout);
     }
  };

  $scope.closeAlert = function(index) {
    $scope.alerts.splice(index, 1);
    if ($scope.signUpForm.$valid) {
      $scope.alerts.push(FactoryAlert.makeAlert("success","Please submit the form."));
    } else {
      $scope.alerts.push(FactoryAlert.makeAlert("info","Please fill in all form elements."));
    }
  };

  $scope.submit = function () {
    if ($scope.signUpForm.$valid) {
      var requestNewUser = $scope.newUser;
      var requestNewAddress = $scope.newAddress;
      var requestNewCustomer = $scope.newShopper;
      var request = { header : { action : 'register' }, 
        body : { user : requestNewUser, address : requestNewAddress, customer : requestNewCustomer } };
      console.log("REQUEST IS:",request);
      var promise = BulletService.send(request);
      $scope.newCustomer = {'gender': "f"};
      $scope.signUpForm.$setPristine(); 
      promise.then(function(response) {
        if(response.header.result === "timeout") {
          $scope.pushAlert(FactoryAlert.makeAlert("danger","Request timed out. Try again later"),false);
        } else {
          $scope.pushAlert(FactoryAlert.makeAlert("success","Thank you."),false);  
        }
      });
    }
  };
}]);

module.factory('FactoryAlert', [function() {
  return {
    makeAlert: function(type,msg) {
      return {'type' : type, 'msg' : msg};
    }
  }
}]);
