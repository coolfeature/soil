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
      <p class="lead">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>
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
              <td><a class="btn btn-large btn-success" ng-click="send()">Send</a></td>
            </tr>
          </tbody>
        </table>  
      </div>
    </div>

    <!-- Benchmark -->          
    <div id="Benchmark" ng-if="toggler.benchmark">
      <div class="row">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" ng-src="{[ tsungReport ]}"></iframe> 
        </div>
      </div>
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

