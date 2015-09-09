<html ng-app="Soil">
<head>
  <script src="/static/libs/angular-1.2.26/angular.min.js"></script>
  <script src="/static/libs/angular-cookies-1.2.26/angular-cookies.min.js"></script>
  <script src="/static/libs/jquery-1.11.1/jquery.min.js"></script>
  <script src="/static/libs/bootstrap-3.2.0/bootstrap.min.js"></script>
  <script src="/static/libs/bullet-1.0.0/bullet.js"></script>
  <script src="/static/libs/bert-js-1.0.0/bert.js"></script>

  <link href="/static/css/bootstrap-3.2.0/bootstrap.min.css" rel="stylesheet">
  <link href="/static/css/soil-0.0.1/soil.css" rel="stylesheet">

  <script src="/app/controllers/Main.js"></script>
  <script src="/app/controllers/Register.js"></script>
  <script src="/app/services/News.js"></script>
  <script src="/app/services/Bullet.js"></script>
  <script src="/app/soil.js"></script>
</head>
<body ng-controller="MainController">

    <!-- Fixed navbar -->
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand active" ng-click="visible('home')" href="#">
          Soil
        </a>
      </div>

      <div id="navbar" class="navbar-collapse collapse">

        <ul class="nav navbar-nav">
          <li ng-class="{active: toggler.connections}"> 
            <a ng-click="visible('connections')" href="#">
              <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                Connections
            </a>
          </li>

          <li ng-class="{active: toggler.register}"> 
            <a ng-click="visible('register')" href="#">
              <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                Register
            </a>
          </li>

          <li ng-class="{active: toggler.benchmark}"> 
            <a ng-click="visible('benchmark')" href="#">
              <span class="glyphicon glyphicon-stats" aria-hidden="true"></span>
                Benchmark
            </a>
          </li>

        </ul>
        
      </div><!--/.nav-collapse -->

    </div>
  </nav>

  <div class="container">

    <!-- Home -->          
    <div id="Home" ng-if="toggler.home">
      <h1 class="cover-heading">Welcome</h1>
      <p class="lead">Soil is an example web application running on a highly scalable and resilient Erlang platform with a rich and interactive front end written in AngularJS which communicates with the application server over a bi-directional channel.</p>
    </div>

    <!-- Connections -->          
    <div id="Connections" ng-if="toggler.connections">
      <div class="row">
        <h1 class="cover-heading">Server connections</h1>
        <table class="table">
          <thead>
            <tr>
              <th>Sid</th>
              <th>Active</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr ng-repeat="channel in channels">
              <td>{[ channel.sid ]}</td>
              <td>{[ channel.properties.active ]}</td>
              <td>
                <!--<a class="btn btn-large btn-success" ng-click="send()">Send</a>-->
              </td>
            </tr>
          </tbody>
        </table>  
      </div>
    </div>

    <!-- Benchmark -->          
    <div id="Benchmark" ng-if="toggler.benchmark">
      <div class="row">
        <div class="embed-responsive embed-responsive-4by3">
          <iframe class="embed-responsive-item" ng-src="{[ tsungReport ]}"></iframe> 
        </div>
      </div>
    </div>

    <!-- Register -->          
    <div id="Register" ng-if="toggler.register" ng-controller="RegisterController">
         <form id="signUpForm" name="signUpForm" class="form-group" role="form" novalidate ng-submit="submit()">
          <div class="row eshop-top-margin"></div>

          <div class="row">	
            <div class="col-md-6">

	      <div class="control-group" ng-class="{'has-error' : signUpForm.fname.$invalid && signUpForm.fname.$dirty, 'has-success' :  signUpForm.fname.$invalid && signUpForm.fname.$dirty}">
	        <label class="control-label">First Name</label>
	          <div class="controls">
	            <div class="input-prepend">
		      <input type="text" class="form-control" id="fname" name="fname" ng-model="newShopper.fname" required placeholder="First Name" show-errors="pushAlerts()">
	            </div>
	          </div>
	      </div>

	      <div class="control-group" ng-class="{'has-error' : signUpForm.lname.$invalid && signUpForm.lname.$dirty, 'has-success' :  signUpForm.lname.$invalid && signUpForm.lname.$dirty}"> 
	        <label class="control-label">Last Name</label>
	          <div class="controls">
	            <div class="input-prepend">
		      <input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name" ng-model="newShopper.lname" required show-errors="pushAlerts()">
	            </div>
	          </div>
	      </div>

	      <div class="control-group" ng-class="{'has-error' : signUpForm.line1.$invalid && signUpForm.line1.$dirty, 'has-success' :  signUpForm.line1.$invalid && signUpForm.line1.$dirty}">
	        <label class="control-label">Address Line 1</label>
	          <div class="controls">
	            <div class="input-prepend">
		      <input type="text" class="form-control" id="line1" name="line1" placeholder="Address Line 1" ng-model="newAddress.line1" required show-errors="pushAlerts()">
	            </div>
	          </div>	
	      </div>

              <div class="control-group">
                <label class="control-label">Address Line 2</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <input type="text" class="form-control" id="line2" name="line2" placeholder="Address Line 2" ng-model="newAddress.line2">
                    </div>
                  </div>
              </div>

              <div class="control-group" ng-class="{'has-error' : signUpForm.postcode.$invalid && signUpForm.postcode.$dirty, 'has-success' :  signUpForm.postcode.$invalid && signUpForm.postcode.$dirty}">
                <label class="control-label">Postcode</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <input type="text" class="form-control" id="postcode" name="postcode" placeholder="Postcode" ng-model="newAddress.postcode" required show-errors="pushAlerts()">
                    </div>
                  </div>
              </div>

              <div class="control-group" ng-class="{'has-error' : signUpForm.city.$invalid && signUpForm.city.$dirty, 'has-success' :  signUpForm.city.$invalid && signUpForm.city.$dirty}">
                <label class="control-label">City / Town</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <input type="text" class="form-control" id="city" name="city" placeholder="City / Town" ng-model="newAddress.city" required show-errors="pushAlerts()">
                    </div>
                  </div>
              </div>

	      <div class="control-group">
	        <label class="control-label">Gender</label>
	          <div class="controls">
		    <div class="row">
		      <div class="content">
		        <div class="col-md-3">
			  <div class="radio">
			    <label>
			      <input type="radio" name="female" value="f" ng-model="newShopper.gender" ng-init="newShopper.gender='f'" required>
			        Female
			    </label>
			  </div>
		        </div>
		        <div class="col-md-3">
			  <div class="radio">
			    <label>
			     <input type="radio" name="male" value="m" ng-model="newShopper.gender" required>
			       Male
			    </label>
			  </div>
		        </div>
		        <div class="col-md-3"></div>
	              </div><!-- ./content -->
		    </div>
	          </div>
	      </div>

	    </div> <!--col-md-6-->

	    <div class="col-md-6">

              <div class="control-group" ng-class="{'has-error' : signUpForm.email.$invalid && signUpForm.email.$dirty, 'has-success' :  signUpForm.email.$invalid && signUpForm.email.$dirty}">
                <label class="control-label">Email</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <input type="email" class="form-control" id="email" name="email" placeholder="Email" ng-model="newUser.email" required show-errors="pushAlerts()">
                    </div>
                  </div>
              </div>

	      <div class="control-group" ng-class="{'has-error' : signUpForm.password.$invalid && signUpForm.password.$dirty , 'has-success' :  signUpForm.password.$invalid && signUpForm.password.$dirty}">
	        <label class="control-label">Password</label>
	          <div class="controls">
	            <div class="input-prepend">
		      <input type="Password" id="passwd" class="form-control" name="password" 
		        placeholder="Password" ng-model="newUser.password" ng-minlength='6' required show-errors="pushAlerts()">
		      <p class="help-block" ng-show="signUpForm.password.$error.minlength || signUpForm.password.$invalid">Password must be at least 6 characters</p>
	            </div>
	          </div>
	      </div>

	      <div class="control-group" ng-class="{'has-error' : signUpForm.confirm_password.$invalid && signUpForm.confirm_password.$dirty, 'has-success' :  signUpForm.confirm_password.$invalid && signUpForm.confirm_password.$dirty}">
	        <label class="control-label">Confirm Password</label>
	          <div class="controls">
	            <div class="input-prepend">
		      <input type="Password" id="confirm_password" class="form-control" name="confirm_password" 
		        placeholder="Re-enter Password" ng-model="newUser.password_verify" password-verify="newUser.password" required show-errors="pushAlerts()">
	            </div>
	          </div>
	      </div>
	
	      <!-- ALERTS -->
              <div class="control-group">
                <h2>Signing up</h2>
		  <div id="signUpStatus" style="height:58px">
		    <div ng-repeat="alert in alerts" close="closeAlert($index)">
		      <div class="alert alert-{[ alert.type ]} alert-dismissable">
  		        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  		          <strong></strong> {[ alert.msg ]}
		      </div>
		    </div>
                  </div>   
              </div>

              <div class="pull-right">
                <div class="control-group">
                  <label class="control-label" for="input01"></label>
                    <div class="controls">
                      <button type="submit" class="btn btn-success" rel="tooltip" title="Submits the form data to the server" ng-disabled="signUpForm.$invalid">Create My Account</button>
                    </div> <!-- controls -->
                </div> <!-- control-group -->
	      </div> <!-- pull-right -->

	    </div> <!-- ./col-md-6 -->
          </div><!-- row -->

          <div class="row">
          </div> <!-- row -->
        </form> 
    </div>

  </div>


  <footer class="footer">
    <div class="container">
      <p class="text-muted"><span class="glyphicon glyphicon-copyright-mark" aria-hidden="true">
      </span>  Szymon Czaja  </p>
    </div>
  </footer>


</body>
</html>

